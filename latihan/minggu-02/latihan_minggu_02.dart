// ============================================
// Nama  : Ni Kadek Okta Pioni
// NIM   : 202463121008
// Kelas : K2
// Tugas : Latihan Dart Mandiri - Minggu 02
// ============================================

// ============================================
// TUGAS 1: Konversi Suhu
// ============================================
// Fungsi untuk mengubah Celsius ke Fahrenheit
double konversiKeFahrenheit(double derajatCelsius) {
  double hasil = (derajatCelsius * 9 / 5) + 32;
  return hasil;
}

// Fungsi untuk mengubah Celsius ke Kelvin
double konversiKeKelvin(double derajatCelsius) {
  double hasil = derajatCelsius + 273.15;
  return hasil;
}

// ============================================
// TUGAS 2: Class Produk
// ============================================
class Produk {
  final String nama;
  final double harga;
  final double? diskon; // diskon bersifat opsional, boleh null

  Produk({required this.nama, required this.harga, this.diskon});

  // Getter untuk menghitung harga akhir setelah diskon
  double get hargaAkhir {
    if (diskon == null || diskon == 0) {
      return harga;
    }
    return harga - (harga * diskon! / 100);
  }

  // Getter untuk menampilkan info produk
  String get info {
    if (diskon == null) {
      return '$nama - Rp${harga.toStringAsFixed(0)} (tanpa diskon)';
    }
    return '$nama - Rp${harga.toStringAsFixed(0)} '
        '(diskon $diskon%) -> Rp${hargaAkhir.toStringAsFixed(0)}';
  }
}

// ============================================
// TUGAS 3: Demonstrasi var, final, const, late
// ============================================
void demonstrasiKeyword() {
  // var: dipakai karena nilainya akan berubah (misal counter)
  var jumlahPeserta = 25;
  jumlahPeserta = 30;
  print('Jumlah peserta: $jumlahPeserta');

  // final: nilai ditentukan saat runtime dan tidak akan diubah lagi
  final waktuDibuat = DateTime.now();
  print('Waktu dibuat: $waktuDibuat');

  // const: nilai sudah tetap saat kompilasi
  const nilaiPhi = 3.14159;
  const namaInstitusi = 'Universitas Warmadewa';
  print('Phi: $nilaiPhi');
  print('Institusi: $namaInstitusi');

  // late: nilai baru diisi setelah deklarasi
  late String statusAkhir;
  int nilaiUjian = 80;

  if (nilaiUjian >= 75) {
    statusAkhir = 'Lulus';
  } else {
    statusAkhir = 'Tidak Lulus';
  }
  print('Status: $statusAkhir');
}

// ============================================
// MAIN: Menjalankan semua tugas
// ============================================
void main() {
  print('=== TUGAS 1: Konversi Suhu ===');
  double suhuAwal = 30.0;
  print('Suhu awal: $suhuAwal derajat Celsius');
  print('Hasil Fahrenheit: '
      '${konversiKeFahrenheit(suhuAwal).toStringAsFixed(2)} F');
  print('Hasil Kelvin: '
      '${konversiKeKelvin(suhuAwal).toStringAsFixed(2)} K');

  print('');
  print('=== TUGAS 2: Class Produk ===');
  final barang1 = Produk(nama: 'Buku Gambar', harga: 12000);
  print(barang1.info);
  final barang2 = Produk(nama: 'Pensil Warna', harga: 25000, diskon: 15);
  print(barang2.info);
  final barang3 = Produk(nama: 'Tas Sekolah', harga: 180000, diskon: 20);
  print(barang3.info);

  print('');
  print('=== TUGAS 3: Keyword var, final, const, late ===');
  demonstrasiKeyword();
}