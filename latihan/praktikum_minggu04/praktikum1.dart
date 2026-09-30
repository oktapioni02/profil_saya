// Praktikum 1 — Statistik nilai kelas
// Jalankan dengan: dart run praktikum1.dart

class Mahasiswa {
  final String nama;
  final double nilai;

  Mahasiswa(this.nama, this.nilai);

  @override
  String toString() => '$nama ($nilai)';
}

void main() {
  print('=== Praktikum 1: Statistik nilai kelas ===');

  // List berisi minimal delapan objek mahasiswa (ada nama yang berulang)
  final daftar = <Mahasiswa>[
    Mahasiswa('Budi', 78),
    Mahasiswa('Andi', 85),
    Mahasiswa('Citra', 92),
    Mahasiswa('Budi', 65),
    Mahasiswa('Dewi', 88),
    Mahasiswa('Andi', 70),
    Mahasiswa('Eko', 55),
    Mahasiswa('Fajar', 90),
    Mahasiswa('Citra', 81),
  ];

  // Rata-rata, tertinggi, terendah
  final total = daftar.fold<double>(0, (jumlah, m) => jumlah + m.nilai);
  final rataRata = total / daftar.length;
  final tertinggi = daftar.reduce((a, b) => a.nilai >= b.nilai ? a : b);
  final terendah = daftar.reduce((a, b) => a.nilai <= b.nilai ? a : b);

  print('Rata-rata      : ${rataRata.toStringAsFixed(2)}');
  print('Nilai tertinggi: $tertinggi');
  print('Nilai terendah : $terendah');

  // Nama yang mengulang, urut alfabetis
  final hitung = <String, int>{};
  for (final m in daftar) {
    hitung[m.nama] = (hitung[m.nama] ?? 0) + 1;
  }

  final namaBerulang = hitung.entries
      .where((e) => e.value > 1)
      .map((e) => e.key)
      .toList()
    ..sort();

  print('Nama yang mengulang (alfabetis): $namaBerulang');
}