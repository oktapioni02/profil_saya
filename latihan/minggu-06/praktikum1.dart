import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ---------------------------------------------------------------
// 1. MODEL
// ---------------------------------------------------------------
class Materi {
  final int minggu;
  final String judul;
  final String deskripsi;

  const Materi({
    required this.minggu,
    required this.judul,
    required this.deskripsi,
  });
}

// ---------------------------------------------------------------
// 2. DATA (enam item)
// ---------------------------------------------------------------
const List<Materi> materi = [
  Materi(
    minggu: 1,
    judul: 'Mobile Development Ecosystem',
    deskripsi:
        'Pengenalan ekosistem pengembangan aplikasi mobile, mulai dari '
        'perbedaan platform Android dan iOS hingga pilihan pendekatan '
        'pengembangan: native, hybrid, dan cross-platform. Pada pertemuan '
        'ini mahasiswa juga mengenal posisi Flutter dan Dart di antara '
        'teknologi lain, serta menyiapkan lingkungan kerja yang akan '
        'dipakai sepanjang semester.',
  ),
  Materi(
    minggu: 2,
    judul: 'Dart Fundamental I',
    deskripsi:
        'Dasar-dasar bahasa Dart: deklarasi variabel dengan var, final, '
        'dan const, tipe data seperti int, double, String, dan bool, serta '
        'operator aritmatika, perbandingan, dan logika. Materi ini juga '
        'membahas string interpolation dan null safety sebagai fondasi '
        'penulisan kode Dart yang aman.',
  ),
  Materi(
    minggu: 3,
    judul: 'Dart Fundamental II',
    deskripsi:
        'Alur kendali program menggunakan percabangan if-else dan switch, '
        'serta perulangan for, while, dan do-while. Selain itu dibahas '
        'cara membuat fungsi dengan parameter posisi, parameter bernama, '
        'nilai default, dan fungsi arrow untuk menulis kode yang lebih '
        'ringkas.',
  ),
  Materi(
    minggu: 4,
    judul: 'Dart Fundamental III',
    deskripsi:
        'Pemrograman berorientasi objek pada Dart: membuat class, '
        'konstruktor, properti, dan method. Dibahas pula pewarisan '
        '(inheritance), abstract class, serta koleksi data seperti List, '
        'Set, dan Map yang akan sering dipakai untuk menyimpan data '
        'aplikasi.',
  ),
  Materi(
    minggu: 5,
    judul: 'Flutter Widget',
    deskripsi:
        'Memahami bahwa hampir semua tampilan di Flutter adalah widget. '
        'Mahasiswa mempelajari perbedaan StatelessWidget dan '
        'StatefulWidget, siklus build, penggunaan setState, serta widget '
        'dasar seperti Text, Container, Image, Icon, dan Button untuk '
        'menyusun antarmuka sederhana.',
  ),
  Materi(
    minggu: 6,
    judul: 'Layout & Navigation',
    deskripsi:
        'Menyusun tata letak dengan Row, Column, Stack, Expanded, dan '
        'Flexible, menampilkan data banyak dengan ListView dan GridView, '
        'serta membuat layout yang menyesuaikan ukuran layar memakai '
        'LayoutBuilder. Bagian navigasi mencakup Navigator.push dan pop, '
        'named route, serta mengirim dan menerima data antar halaman.',
  ),
];

// ---------------------------------------------------------------
// 3. APLIKASI
// ---------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Materi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF2F7FD), // latar biru lembut
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      home: const HalamanMateri(),
    );
  }
}

// ---------------------------------------------------------------
// 4. HALAMAN DAFTAR (ListView.builder)
// ---------------------------------------------------------------
class HalamanMateri extends StatelessWidget {
  const HalamanMateri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DAFTAR MATERI KULIAH')),
      body: ListView.builder(
        itemCount: materi.length,
        itemBuilder: (context, index) {
          final item = materi[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(
              item.judul.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            // Di daftar cukup 2 baris; teks lengkap ada di halaman detail
            subtitle: Text(
              item.deskripsi,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            // Aksi ketuk -> buka halaman detail, kirim data lewat konstruktor
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HalamanDetail(materi: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------
// 5. HALAMAN DETAIL (menerima data lewat konstruktor)
// ---------------------------------------------------------------
class HalamanDetail extends StatelessWidget {
  final Materi materi;
  const HalamanDetail({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(materi.judul.toUpperCase())),
      // SingleChildScrollView: jaga-jaga kalau deskripsi panjang
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minggu ${materi.minggu}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Text(
              materi.judul.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              materi.deskripsi,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}