import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../domain/weekly_snapshot.dart';

class ExportService {
  Future<String> generateWeeklyPdf(WeeklySnapshot snapshot) async {
    final doc = pw.Document();
    final start = snapshot.weekStart;
    final end = start.add(const Duration(days: 6));
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(
            'Haftalık Rapor',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text('Tarih: ${_formatDate(start)} - ${_formatDate(end)}'),
          pw.SizedBox(height: 12),
          pw.Table(
            border: pw.TableBorder.all(width: 0.3),
            children: [
              _statRow('Gelir', snapshot.incomeTotal),
              _statRow('Gider', snapshot.expenseTotal),
              _statRow('Net', snapshot.incomeTotal - snapshot.expenseTotal),
              _statRow('Maaş', snapshot.payrollTotal),
              _statRow('Borç', snapshot.debtTotal),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text('Aktif Projeler', style: pw.TextStyle(fontSize: 18)),
          if (snapshot.activeProjects.isEmpty)
            pw.Text('Aktif proje yok')
          else
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: snapshot.activeProjects
                  .map(
                    (p) => pw.Text(
                      '• ${p.title} (${p.status})',
                    ),
                  )
                  .toList(),
            ),
          pw.SizedBox(height: 16),
          pw.Text('İşlemler', style: pw.TextStyle(fontSize: 18)),
          if (snapshot.transactions.isEmpty)
            pw.Text('İşlem kaydı yok')
          else
            pw.Table.fromTextArray(
              headers: ['Tarih', 'Tür', 'Kategori', 'Tutar'],
              data: snapshot.transactions
                  .map(
                    (tx) => [
                      _formatDate(tx.txDate),
                      tx.type,
                      tx.category,
                      _formatCurrency(tx.amount),
                    ],
                  )
                  .toList(),
            ),
        ],
      ),
    );
    final file = await _createFile(
      'weekly_${_formatDate(start)}.pdf',
    );
    await file.writeAsBytes(await doc.save());
    return file.path;
  }

  Future<String> generateWeeklyExcel(WeeklySnapshot snapshot) async {
    final excel = Excel.createExcel();
    final sheet = excel['Özet'];
    sheet.appendRow(['Hafta Baş.', _formatDate(snapshot.weekStart)]);
    sheet.appendRow([
      'Hafta Sonu',
      _formatDate(snapshot.weekStart.add(const Duration(days: 6)))
    ]);
    sheet.appendRow(['Gelir', _formatCurrency(snapshot.incomeTotal)]);
    sheet.appendRow(['Gider', _formatCurrency(snapshot.expenseTotal)]);
    sheet.appendRow(
        ['Net', _formatCurrency(snapshot.incomeTotal - snapshot.expenseTotal)]);
    sheet.appendRow(['Maaş', _formatCurrency(snapshot.payrollTotal)]);
    sheet.appendRow(['Borç', _formatCurrency(snapshot.debtTotal)]);

    final txSheet = excel['İşlemler'];
    txSheet.appendRow(['Tarih', 'Tip', 'Kategori', 'Tutar', 'Açıklama']);
    for (final tx in snapshot.transactions) {
      txSheet.appendRow([
        _formatDate(tx.txDate),
        tx.type,
        tx.category,
        _formatCurrency(tx.amount),
        tx.description ?? '',
      ]);
    }

    final bytes = excel.encode();
    final file = await _createFile(
      'weekly_${_formatDate(snapshot.weekStart)}.xlsx',
    );
    await file.writeAsBytes(bytes!, flush: true);
    return file.path;
  }

  Future<File> _createFile(String name) async {
    final dir = await getApplicationDocumentsDirectory();
    final folder =
        await Directory('${dir.path}/usta_reports').create(recursive: true);
    return File('${folder.path}/$name');
  }

  pw.TableRow _statRow(String label, int amount) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text(label),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text(_formatCurrency(amount)),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) =>
      date.toLocal().toString().split(' ').first;

  String _formatCurrency(int amount) =>
      '${(amount / 100).toStringAsFixed(2)} ₺';
}
