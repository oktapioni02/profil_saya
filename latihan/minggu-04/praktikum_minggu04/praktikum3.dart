// Praktikum 3 — Higher-order function
// Jalankan dengan: dart run praktikum3.dart

// Versi higher-order function: kriteria dikirim sebagai function
List<T> filterData<T>(List<T> data, bool Function(T) kriteria) {
  final hasil = <T>[];
  for (final item in data) {
    if (kriteria(item)) hasil.add(item);
  }
  return hasil;
}

// Versi perulangan biasa: loop harus ditulis ulang untuk tiap kriteria
List<int> genapBiasa(List<int> data) {
  final hasil = <int>[];
  for (final x in data) {
    if (x % 2 == 0) hasil.add(x);
  }
  return hasil;
}

List<int> lebihBesarDariLimaBiasa(List<int> data) {
  final hasil = <int>[];
  for (final x in data) {
    if (x > 5) hasil.add(x);
  }
  return hasil;
}

List<int> kelipatanTigaBiasa(List<int> data) {
  final hasil = <int>[];
  for (final x in data) {
    if (x % 3 == 0) hasil.add(x);
  }
  return hasil;
}

void main() {
  print('=== Praktikum 3: Higher-order function ===');

  final angka = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Tiga kriteria berbeda, isi filterData tidak berubah
  print('Genap          : ${filterData(angka, (x) => x % 2 == 0)}');
  print('Lebih dari 5   : ${filterData(angka, (x) => x > 5)}');
  print('Kelipatan tiga : ${filterData(angka, (x) => x % 3 == 0)}');

  // Versi perulangan biasa (hasil sama, tetapi kodenya berulang)
  print('--- Versi perulangan biasa ---');
  print('Genap          : ${genapBiasa(angka)}');
  print('Lebih dari 5   : ${lebihBesarDariLimaBiasa(angka)}');
  print('Kelipatan tiga : ${kelipatanTigaBiasa(angka)}');

  print('''
Perbandingan keterbacaan:
- filterData: satu function untuk semua kriteria, pemanggilan singkat
  dan langsung menunjukkan maksud (mis. "x > 5"). Bisa dipakai untuk
  tipe data apa pun karena bersifat generik.
- Perulangan biasa: setiap kriteria butuh function/loop sendiri, kode
  berulang (boilerplate), dan makin panjang bila kriteria bertambah.
''');
}