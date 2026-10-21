import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Wajib agar format tanggal bahasa Indonesia tersedia
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true);

    return MaterialApp(
      title: 'Aplikasi Kuliah',
      // Satu jenis huruf untuk SELURUH aplikasi
      theme: base.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      ),
      home: const HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    // Hasil: Rabu, 21 Oktober 2026
    final tanggal = DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('Praktikum 1')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tanggal hari ini:'),
            const SizedBox(height: 8),
            Text(
              tanggal,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}