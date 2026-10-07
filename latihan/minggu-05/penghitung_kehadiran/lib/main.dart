import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKehadiran());
}

class AplikasiKehadiran extends StatelessWidget {
  const AplikasiKehadiran({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penghitung Kehadiran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0B6B45),
        useMaterial3: true,
      ),
      home: const PenghitungKehadiran(),
    );
  }
}

class PenghitungKehadiran extends StatefulWidget {
  const PenghitungKehadiran({super.key});

  @override
  State<PenghitungKehadiran> createState() => _PenghitungKehadiranState();
}

class _PenghitungKehadiranState extends State<PenghitungKehadiran> {
  int _jumlah = 0;

  void _hadir() {
    setState(() {
      _jumlah++;
    });
  }

  void _reset() {
    setState(() {
      _jumlah = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Warna hijau jika kehadiran minimal 12
    final warnaTeks = _jumlah >= 12
        ? const Color(0xFF0B6B45)
        : const Color.fromARGB(221, 50, 111, 190);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Penghitung Kehadiran'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_jumlah',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: warnaTeks,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _jumlah >= 12
                  ? 'Sudah memenuhi minimal 12 pertemuan'
                  : 'Belum memenuhi syarat',
              style: TextStyle(color: warnaTeks),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: _hadir,
                  icon: const Icon(Icons.check),
                  label: const Text('Hadir'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}