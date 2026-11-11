import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 3 - Penanganan Izin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const PermissionPage(),
    );
  }
}

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  PermissionStatus _status = PermissionStatus.denied;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    setState(() => _isChecking = true);
    final status = await Permission.camera.status;
    setState(() {
      _status = status;
      _isChecking = false;
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.request();
    setState(() => _status = status);

    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Izin Kamera Diperlukan'),
        content: const Text(
          'Aplikasi membutuhkan akses kamera agar Anda bisa:\n\n'
          '• Mengambil foto profil\n'
          '• Menggunakan fitur pratinjau kamera\n'
          '• Menyimpan momen penting\n\n'
          'Silakan buka Pengaturan dan aktifkan izin Kamera untuk aplikasi ini.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Nanti'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Buka Pengaturan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 3 — Penanganan Izin'),
        centerTitle: true,
      ),
      body: Center(
        child: _isChecking
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _status.isGranted
                          ? Icons.check_circle
                          : Icons.no_photography,
                      size: 80,
                      color: _status.isGranted ? Colors.green : Colors.red,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _status.isGranted
                          ? 'Izin Kamera Diberikan'
                          : 'Izin Kamera Belum Diberikan',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Status saat ini: ${_status.toString().split('.').last}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 40),
                    if (!_status.isGranted) ...[
                      ElevatedButton.icon(
                        onPressed: _requestPermission,
                        icon: const Icon(Icons.camera),
                        label: const Text('Minta Izin Kamera'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () => openAppSettings(),
                        icon: const Icon(Icons.settings),
                        label: const Text('Buka Pengaturan'),
                      ),
                    ] else ...[
                      const Text(
                        'Izin sudah diberikan.\nAplikasi siap digunakan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                    const SizedBox(height: 32),
                    Text(
                      'Catatan: Aplikasi ini tidak akan crash meskipun izin ditolak.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}