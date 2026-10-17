import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ---------------------------------------------------------------
// MODEL + DATA
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigasi Bawah',
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
      home: const HalamanUtama(),
    );
  }
}

// ---------------------------------------------------------------
// KERANGKA UTAMA: BottomNavigationBar + IndexedStack
// ---------------------------------------------------------------
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _indeks = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanMateri(),
    HalamanProfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack menyimpan SEMUA halaman di memori dan hanya
      // menampilkan satu, sehingga posisi gulir tiap halaman
      // (mis. Beranda) tidak hilang saat berpindah tab.
      body: IndexedStack(
        index: _indeks,
        children: _halaman,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indeks,
        selectedItemColor: Colors.blue.shade800,
        onTap: (i) => setState(() => _indeks = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Materi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------
// HALAMAN 1: BERANDA
// Daftar panjang (sengaja bisa digulir) untuk membuktikan bahwa
// IndexedStack mempertahankan posisi gulir.
// ---------------------------------------------------------------
class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BERANDA')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.campaign),
              title: Text('PENGUMUMAN ${index + 1}'),
              subtitle: const Text('Gulir halaman ini, lalu pindah tab.'),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------
// HALAMAN 2: MATERI
// Grid kecil: 2 kolom (sempit) / 3 kolom (lebar >= 600).
// Tinggi kartu dihitung dari tinggi layar, sehingga enam kartu
// selalu muat dalam satu frame tanpa gulir.
// ---------------------------------------------------------------
class HalamanMateri extends StatelessWidget {
  const HalamanMateri({super.key});

  static const double _padding = 12;
  static const double _jarak = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MATERI')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final int kolom = constraints.maxWidth >= 600 ? 3 : 2;
          final int baris = (materi.length / kolom).ceil();

          final double lebarKartu =
              (constraints.maxWidth - _padding * 2 - _jarak * (kolom - 1)) /
                  kolom;
          final double tinggiKartu =
              (constraints.maxHeight - _padding * 2 - _jarak * (baris - 1)) /
                  baris;

          return GridView.builder(
            padding: const EdgeInsets.all(_padding),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kolom,
              crossAxisSpacing: _jarak,
              mainAxisSpacing: _jarak,
              childAspectRatio: lebarKartu / tinggiKartu,
            ),
            itemCount: materi.length,
            itemBuilder: (context, index) => KartuMateri(data: materi[index]),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------
// KARTU KECIL (warna & ikon berbeda tiap minggu, sudut membulat)
// ---------------------------------------------------------------
const List<MaterialColor> _warnaMinggu = [
  Colors.blue,
  Colors.lightBlue,
  Colors.indigo,
  Colors.cyan,
  Colors.blueGrey,
  Colors.teal,
];

const List<IconData> _ikonMinggu = [
  Icons.phone_android,
  Icons.data_object,
  Icons.alt_route,
  Icons.account_tree,
  Icons.widgets,
  Icons.dashboard_customize,
];

class KartuMateri extends StatelessWidget {
  final Materi data;
  const KartuMateri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final int i = (data.minggu - 1) % _warnaMinggu.length;
    final MaterialColor warna = _warnaMinggu[i];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: warna.shade50,
      clipBehavior: Clip.antiAlias, // efek ketuk ikut membulat
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // sudut membulat
        side: BorderSide(color: warna.shade200, width: 1.5),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanDetail(materi: data),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          // FittedBox: isi kartu otomatis mengecil jika ruang sempit,
          // jadi tidak pernah overflow.
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: warna.shade600,
                    foregroundColor: Colors.white,
                    child: Icon(_ikonMinggu[i], size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.judul.toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: warna.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: warna.shade600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Minggu ${data.minggu}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// HALAMAN 3: PROFIL
// ---------------------------------------------------------------
class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PROFIL')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFF1E88E5),
              foregroundColor: Colors.white,
              child: Icon(Icons.person, size: 48),
            ),
            SizedBox(height: 16),
            Text(
              'Ni Kadek Okta Pioni', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text('NIM 202463121008'), 
            Text('Teknik Komputer'),
            Text('Universitas Warmadewa'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------
// HALAMAN DETAIL
// ---------------------------------------------------------------
class HalamanDetail extends StatelessWidget {
  final Materi materi;
  const HalamanDetail({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(materi.judul.toUpperCase())),
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