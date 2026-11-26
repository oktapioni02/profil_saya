
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const navy = Color(0xFF05091F);
const galaxy = Color(0xFF151B50);
const blue = Color(0xFF315CDB);
const cyan = Color(0xFF55E8FF);
const purple = Color(0xFF875CFF);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: cyan,
          brightness: Brightness.dark,
        ),
      ),
      home: const GalaxyPage(),
    );
  }
}

enum Mode { data, kosong, gagal, acak }

class GalaxyPage extends StatefulWidget {
  const GalaxyPage({super.key});

  @override
  State<GalaxyPage> createState() => _GalaxyPageState();
}

class _GalaxyPageState extends State<GalaxyPage> {
  late Future<List<String>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = ambilData(Mode.data);
  }

  Future<List<String>> ambilData(Mode mode) async {
    await Future.delayed(const Duration(seconds: 2));

    if (mode == Mode.gagal ||
        (mode == Mode.acak && Random().nextBool())) {
      throw Exception('Koneksi bermasalah.');
    }

    if (mode == Mode.kosong) return [];

    return ['Andi', 'Budi', 'Citra', 'Dewi'];
  }

  void muatUlang(Mode mode) {
    setState(() {
      futureData = ambilData(mode).timeout(
        const Duration(seconds: 3),
      );
    });
  }

  Future<String> proses(String nama, int detik) async {
    await Future.delayed(Duration(seconds: detik));
    return 'Proses $nama selesai';
  }

  Future<void> ujiParalel() async {
    final sequential = Stopwatch()..start();

    await proses('A', 1);
    await proses('B', 2);
    await proses('C', 3);

    sequential.stop();

    final parallel = Stopwatch()..start();

    final hasil = await Future.wait([
      proses('A', 1),
      proses('B', 2),
      proses('C', 3),
    ]);

    parallel.stop();

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: galaxy,
        title: const Text(
          'Hasil Operasi Paralel',
          style: TextStyle(color: cyan),
        ),
        content: Text(
          'BERURUTAN\n${sequential.elapsedMilliseconds} ms\n\n'
          'PARALEL\n${parallel.elapsedMilliseconds} ms\n\n'
          '${hasil.join('\n')}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget tombol(String label, VoidCallback action) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF263E9C),
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: cyan.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 13,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: cyan.withOpacity(0.5),
          ),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  BoxDecoration kartu() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xCC202D70),
          Color(0xDD101B45),
          Color(0xCC19265C),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: cyan.withOpacity(0.4),
      ),
      boxShadow: [
        BoxShadow(
          color: blue.withOpacity(0.25),
          blurRadius: 25,
          spreadRadius: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // GALAXY BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF05091F),
                  Color(0xFF111746),
                  Color(0xFF080D2B),
                  Color(0xFF171344),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // NEBULA LIGHT
          Positioned(
            top: 80,
            right: -90,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    purple.withOpacity(0.25),
                    blue.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 130,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    cyan.withOpacity(0.16),
                    blue.withOpacity(0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // STARS
          const Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: StarPainter(),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // HEADER
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [blue, purple],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: cyan.withOpacity(0.35),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 29,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GALAXY SYSTEM',
                              style: TextStyle(
                                color: cyan,
                                fontSize: 11,
                                letterSpacing: 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Data Pengguna',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.blur_on,
                        color: purple,
                        size: 30,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'ASYNC • AWAIT • FUTURE BUILDER',
                    style: TextStyle(
                      color: Color(0xFFACBDFD),
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // MAIN CONTENT
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(17),
                      decoration: kartu(),
                      child: FutureBuilder<List<String>>(
                        future: futureData,
                        builder: (context, snapshot) {

                          // LOADING
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: purple,
                                    size: 48,
                                  ),
                                  SizedBox(height: 15),
                                  CircularProgressIndicator(
                                    color: cyan,
                                  ),
                                  SizedBox(height: 18),
                                  Text(
                                    'MENJELAJAHI GALAKSI...',
                                    style: TextStyle(
                                      color: cyan,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Sedang mengambil data',
                                    style: TextStyle(
                                      color: Color(0xFFB5C8FF),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          // ERROR
                          if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Color(0xFFFF789E),
                                    size: 70,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'SINYAL TERPUTUS!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    snapshot.error.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFFB5C8FF),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  tombol(
                                    'Hubungkan Kembali',
                                    () => muatUlang(Mode.acak),
                                  ),
                                ],
                              ),
                            );
                          }

                          final data = snapshot.data ?? [];

                          // EMPTY
                          if (data.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.satellite_alt,
                                    color: cyan,
                                    size: 70,
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    'RUANG KOSONG',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Belum ada data pengguna.',
                                    style: TextStyle(
                                      color: Color(0xFFB5C8FF),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  tombol(
                                    'Cari Data',
                                    () => muatUlang(Mode.data),
                                  ),
                                ],
                              ),
                            );
                          }

                          // SUCCESS
                          return Column(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: cyan,
                                size: 48,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'MISI BERHASIL!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${data.length} pengguna ditemukan',
                                style: const TextStyle(
                                  color: Color(0xFFB5C8FF),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF283D91),
                                            Color(0xFF171F56),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        border: Border.all(
                                          color: cyan.withOpacity(0.3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: blue.withOpacity(0.2),
                                            blurRadius: 12,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: purple,
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          data[index],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: const Text(
                                          'Pengguna terdaftar',
                                          style: TextStyle(
                                            color: Color(0xFFB5C8FF),
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.verified,
                                          color: cyan,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'PILIH KONDISI PENGUJIAN',
                    style: TextStyle(
                      color: cyan,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      tombol(
                        'Data',
                        () => muatUlang(Mode.data),
                      ),
                      tombol(
                        'Kosong',
                        () => muatUlang(Mode.kosong),
                      ),
                      tombol(
                        'Gagal',
                        () => muatUlang(Mode.gagal),
                      ),
                      tombol(
                        'Acak',
                        () => muatUlang(Mode.acak),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: ujiParalel,
                      icon: const Icon(
                        Icons.bolt,
                        color: navy,
                      ),
                      label: const Text(
                        'UJI OPERASI PARALEL',
                        style: TextStyle(
                          color: navy,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cyan,
                        elevation: 12,
                        shadowColor: cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      '✦ WEEK 11 • GALAXY ASYNC SYSTEM ✦',
                      style: TextStyle(
                        color: Color(0xFF879CEB),
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CUSTOM STAR FIELD
class StarPainter extends CustomPainter {
  const StarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);

    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.5 + 0.3;

      final paint = Paint()
        ..color = (i % 5 == 0 ? cyan : Colors.white)
            .withOpacity(random.nextDouble() * 0.5 + 0.2)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          i % 5 == 0 ? 2 : 0,
        );

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarPainter oldDelegate) {
    return false;
  }
}
