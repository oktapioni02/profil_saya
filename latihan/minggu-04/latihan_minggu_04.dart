// Tugas: Pengolah Data Akademik
//
// Catatan: seluruh operasi memakai method iterable (where, map, fold,
// forEach, toList, dll.), tanpa perulangan manual (for / while).

typedef MataKuliah = Map<String, dynamic>;

// Data mata kuliah disimpan dalam List<Map>
final List<MataKuliah> daftarMataKuliah = [
  {'kode': 'IF101', 'nama': 'Pemrograman Mobile', 'sks': 3},
  {'kode': 'IF102', 'nama': 'Teknologi Basis Data', 'sks': 3},
  {'kode': 'IF103', 'nama': 'Algoritma dan Struktur Data', 'sks': 4},
  {'kode': 'IF104', 'nama': 'Jaringan Komputer', 'sks': 3},
  {'kode': 'IF105', 'nama': 'Computer Vision', 'sks': 3},
  {'kode': 'IF106', 'nama': 'Matematika Diskrit', 'sks': 2},
  {'kode': 'IF107', 'nama': 'Deep Learning', 'sks': 2},
  {'kode': 'IF108', 'nama': 'Natural Language Processing', 'sks': 3},
];

// ---------------------------------------------------------------
// 1. Pencarian berdasarkan kata kunci (pada nama atau kode)
// ---------------------------------------------------------------
List<MataKuliah> cariByKataKunci(List<MataKuliah> data, String kataKunci) {
  final kunci = kataKunci.toLowerCase();
  return data
      .where((mk) =>
          (mk['nama'] as String).toLowerCase().contains(kunci) ||
          (mk['kode'] as String).toLowerCase().contains(kunci))
      .toList();
}

// ---------------------------------------------------------------
// 2. Penyaringan berdasarkan SKS
// ---------------------------------------------------------------
List<MataKuliah> filterBySks(List<MataKuliah> data, int sks) {
  return data.where((mk) => mk['sks'] == sks).toList();
}

// ---------------------------------------------------------------
// 3. Pengurutan berdasarkan nama (A-Z, tanpa mengubah data asli)
// ---------------------------------------------------------------
List<MataKuliah> urutkanByNama(List<MataKuliah> data) {
  return data.toList()
    ..sort((a, b) => (a['nama'] as String)
        .toLowerCase()
        .compareTo((b['nama'] as String).toLowerCase()));
}

// ---------------------------------------------------------------
// Tambahan: total SKS dan tampilan hasil
// ---------------------------------------------------------------
int totalSks(List<MataKuliah> data) {
  return data.map((mk) => mk['sks'] as int).fold(0, (a, b) => a + b);
}

void tampilkan(String judul, List<MataKuliah> data) {
  print('\n$judul');
  if (data.isEmpty) {
    print('  (tidak ada data)');
    return;
  }
  data.forEach((mk) => print(
      '  ${mk['kode']} | ${(mk['nama'] as String).padRight(28)} | ${mk['sks']} SKS'));
  print('  Total: ${data.length} mata kuliah, ${totalSks(data)} SKS');
}

void main() {
  print('=== Pengolah Data Akademik ===');

  tampilkan('Semua mata kuliah:', daftarMataKuliah);

  // Pencarian
  tampilkan('Hasil cari "pemrograman":',
      cariByKataKunci(daftarMataKuliah, 'pemrograman'));
  tampilkan('Hasil cari "data":', cariByKataKunci(daftarMataKuliah, 'data'));
  tampilkan('Hasil cari "xyz":', cariByKataKunci(daftarMataKuliah, 'xyz'));

  // Penyaringan
  tampilkan('Mata kuliah 3 SKS:', filterBySks(daftarMataKuliah, 3));
  tampilkan('Mata kuliah 2 SKS:', filterBySks(daftarMataKuliah, 2));

  // Pengurutan
  tampilkan('Diurutkan berdasarkan nama (A-Z):',
      urutkanByNama(daftarMataKuliah));
}