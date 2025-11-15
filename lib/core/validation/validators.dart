class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bu alan boş bırakılamaz';
    }
    return null;
  }

  static String? positiveInt(String? value) {
    final parsed = int.tryParse(value ?? '');
    if (parsed == null || parsed <= 0) {
      return 'Geçerli bir pozitif sayı girin';
    }
    return null;
  }

  static String? positiveDouble(String? value) {
    final parsed = double.tryParse(value ?? '');
    if (parsed == null || parsed <= 0) {
      return 'Geçerli bir pozitif tutar girin';
    }
    return null;
  }
}
