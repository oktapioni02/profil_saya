// Praktikum 2 — Map inventaris (interaktif di terminal)
// Jalankan dengan: dart run praktikum2.dart

import 'dart:io';

final inventaris = <String, int>{
  'Pensil': 20,
  'Buku': 3,
  'Penghapus': 12,
  'Penggaris': 4,
  'Spidol': 9,
};

// ---------- Helper input ----------

String bacaTeks(String pesan) {
  stdout.write(pesan);
  return (stdin.readLineSync() ?? '').trim();
}

int? bacaAngka(String pesan) {
  final angka = int.tryParse(bacaTeks(pesan));
  if (angka == null || angka < 0) {
    print('  ! Masukkan angka bulat 0 atau lebih.');
    return null;
  }
  return angka;
}

// Cari nama barang tanpa membedakan huruf besar/kecil
String? cariKunci(String nama) {
  for (final k in inventaris.keys) {
    if (k.toLowerCase() == nama.toLowerCase()) return k;
  }
  return null;
}

// ---------- Operasi ----------

void tampilkanSemua() {
  print('\nDaftar inventaris:');
  if (inventaris.isEmpty) {
    print('  (kosong)');
    return;
  }
  for (final e in inventaris.entries) {
    print('  - ${e.key}: ${e.value}');
  }
}

void tambahBarang() {
  final nama = bacaTeks('Nama barang baru: ');
  if (nama.isEmpty) {
    print('  ! Nama tidak boleh kosong.');
    return;
  }
  if (cariKunci(nama) != null) {
    print('  ! Barang "$nama" sudah ada. Gunakan menu edit atau tambah stok.');
    return;
  }
  final stok = bacaAngka('Stok awal: ');
  if (stok == null) return;
  inventaris[nama] = stok;
  print('  Barang "$nama" ditambahkan dengan stok $stok.');
}

void editStok() {
  final kunci = cariKunci(bacaTeks('Nama barang yang diedit: '));
  if (kunci == null) {
    print('  ! Barang tidak ditemukan.');
    return;
  }
  final stok = bacaAngka('Stok baru untuk $kunci (sekarang ${inventaris[kunci]}): ');
  if (stok == null) return;
  inventaris[kunci] = stok;
  print('  Stok $kunci diubah menjadi $stok.');
}

void hapusBarang() {
  final kunci = cariKunci(bacaTeks('Nama barang yang dihapus: '));
  if (kunci == null) {
    print('  ! Barang tidak ditemukan.');
    return;
  }
  final yakin = bacaTeks('Yakin hapus "$kunci"? (y/n): ').toLowerCase();
  if (yakin == 'y') {
    inventaris.remove(kunci);
    print('  Barang "$kunci" dihapus.');
  } else {
    print('  Dibatalkan.');
  }
}

void tambahStok() {
  final kunci = cariKunci(bacaTeks('Nama barang: '));
  if (kunci == null) {
    print('  ! Barang tidak ditemukan.');
    return;
  }
  final jumlah = bacaAngka('Jumlah yang ditambah: ');
  if (jumlah == null) return;
  inventaris[kunci] = inventaris[kunci]! + jumlah;
  print('  Stok $kunci sekarang ${inventaris[kunci]}.');
}

void kurangiStok() {
  final kunci = cariKunci(bacaTeks('Nama barang: '));
  if (kunci == null) {
    print('  ! Barang tidak ditemukan.');
    return;
  }
  final jumlah = bacaAngka('Jumlah yang dikurangi: ');
  if (jumlah == null) return;
  if (jumlah > inventaris[kunci]!) {
    print('  ! Stok tidak cukup (tersisa ${inventaris[kunci]}).');
    return;
  }
  inventaris[kunci] = inventaris[kunci]! - jumlah;
  print('  Stok $kunci sekarang ${inventaris[kunci]}.');
}

void tampilkanStokRendah() {
  // where pada entries
  final rendah = inventaris.entries.where((e) => e.value < 5).toList();
  print('\nBarang dengan stok di bawah 5:');
  if (rendah.isEmpty) {
    print('  (tidak ada)');
    return;
  }
  for (final e in rendah) {
    print('  - ${e.key}: ${e.value}');
  }
}

// ---------- Menu ----------

void tampilkanMenu() {
  print('''

===== MENU INVENTARIS =====
1. Tampilkan semua barang
2. Tambah barang baru
3. Edit stok (ganti angka)
4. Hapus barang
5. Tambah stok
6. Kurangi stok
7. Tampilkan stok di bawah 5
0. Keluar''');
}

void main() {
  while (true) {
    tampilkanMenu();
    String? pilihan;
    do {
      stdout.write('Pilih menu: ');
      pilihan = stdin.readLineSync();
      if (pilihan == null) return; // input berakhir
    } while (pilihan.trim().isEmpty); // abaikan Enter kosong

    switch (pilihan.trim()) {
      case '1':
        tampilkanSemua();
      case '2':
        tambahBarang();
      case '3':
        editStok();
      case '4':
        hapusBarang();
      case '5':
        tambahStok();
      case '6':
        kurangiStok();
      case '7':
        tampilkanStokRendah();
      case '0':
        print('Sampai jumpa!');
        return;
      default:
        print('  ! Pilihan tidak valid.');
    }
  }
}