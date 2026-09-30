String hurufMutu(double nilai) {
  // Langkah 2: Validasi rentang
  if (nilai < 0 || nilai > 100) {
    throw ArgumentError('Nilai harus antara 0 sampai 100. Nilai yang dimasukkan: $nilai');
  }

  // Langkah 3: Tentukan huruf mutu
  if (nilai >= 80) {
    return 'A';
  } else if (nilai >= 70) {
    return 'B';
  } else if (nilai >= 60) {
    return 'C';
  } else if (nilai >= 50) {
    return 'D';
  } else {
    return 'E';
  }
}

void main() {
  print('=== PRAKTIKUM 1: Konversi Nilai ===');

  // 10 nilai berbeda untuk diuji
  List<double> daftarNilai = [95, 82, 75, 68, 55, 45, 100, 0, 70, 59.5];

  for (int i = 0; i < daftarNilai.length; i++) {
    double n = daftarNilai[i];
    try {
      String hasil = hurufMutu(n);
      print('Nilai $n → Huruf Mutu: $hasil');
    } catch (e) {
      print('Error pada nilai $n: $e');
    }
  }

  // Contoh yang error (opsional)
  try {
    print(hurufMutu(120)); // ini akan error
  } catch (e) {
    print('Contoh error: $e');
  }
}