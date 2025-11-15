import 'dart:io';

import '../application/report_state.dart';

class ExportService {
  Future<String> generateWeeklyPdf(ReportState state) async {
    final file = await _createTempFile(
      'weekly_${state.weekStart.toIso8601String()}.pdf',
    );
    final buffer = StringBuffer()
      ..writeln('Haftalık Rapor')
      ..writeln(
        'Hafta: ${_formatDate(state.weekStart)} - ${_formatDate(state.weekEnd)}',
      )
      ..writeln('Gelir: ${(state.income / 100).toStringAsFixed(2)} ₺')
      ..writeln('Gider: ${(state.expense / 100).toStringAsFixed(2)} ₺')
      ..writeln(
        'Net: ${((state.income - state.expense) / 100).toStringAsFixed(2)} ₺',
      )
      ..writeln('Maaş: ${(state.payroll / 100).toStringAsFixed(2)} ₺')
      ..writeln('Alınan Borç: ${(state.debtTaken / 100).toStringAsFixed(2)} ₺')
      ..writeln('Ödenen Borç: ${(state.debtPaid / 100).toStringAsFixed(2)} ₺')
      ..writeln('\nİşlemler:');
    for (final tx in state.transactions) {
      buffer.writeln(
        '${_formatDate(tx.txDate)} | ${tx.type} | ${tx.category} | ${(tx.amount / 100).toStringAsFixed(2)} ₺ | ${tx.description ?? ''}',
      );
    }
    await file.writeAsString(buffer.toString());
    return file.path;
  }

  Future<String> generateWeeklyExcel(ReportState state) async {
    final file = await _createTempFile(
      'weekly_${state.weekStart.toIso8601String()}.csv',
    );
    final buffer = StringBuffer('Tarih,Tip,Tutar,Açıklama,Proje\n');
    for (final tx in state.transactions) {
      buffer.writeln(
        '${_formatDate(tx.txDate)},${tx.type},${(tx.amount / 100).toStringAsFixed(2)},${tx.description ?? ''},${tx.projectId}',
      );
    }
    await file.writeAsString(buffer.toString());
    return file.path;
  }

  Future<File> _createTempFile(String name) async {
    final dir = await Directory.systemTemp.createTemp('usta_reports');
    return File('${dir.path}/$name');
  }

  String _formatDate(DateTime date) =>
      date.toLocal().toString().split(' ').first;
}
