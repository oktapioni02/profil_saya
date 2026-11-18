
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int angka = 0;
  final List<String> riwayat = [];

  void catat(String aktivitas) {
    riwayat.insert(0, aktivitas);
    if (riwayat.length > 10) {
      riwayat.removeLast();
    }
  }

  void tambah() {
    setState(() {
      angka++;
      catat('Angka bertambah menjadi $angka');
    });
  }

  void kurang() {
    if (angka > 0) {
      setState(() {
        angka--;
        catat('Angka berkurang menjadi $angka');
      });
    }
  }

  void reset() {
    setState(() {
      angka = 0;
      catat('Angka direset menjadi 0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF64B5F6)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'NILAI SEKARANG',
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$angka',
                style: const TextStyle(
                  fontSize: 65,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Praktikum setState',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: tambah,
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: angka > 0 ? kurang : null,
                icon: const Icon(Icons.remove),
                label: const Text('Kurang'),
              ),
            ),
          ],
        ),

        OutlinedButton.icon(
          onPressed: reset,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset Angka'),
        ),

        const SizedBox(height: 20),

        const Text(
          'Riwayat Aktivitas',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        if (riwayat.isEmpty)
          const Text('Belum ada aktivitas.')
        else
          ...riwayat.map(
            (item) => Card(
              child: ListTile(
                leading: const Icon(Icons.history, color: Colors.blue),
                title: Text(item),
              ),
            ),
          ),
      ],
    );
  }
}
