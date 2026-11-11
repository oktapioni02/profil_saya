
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HalamanKamera extends StatefulWidget {
  const HalamanKamera({super.key});

  @override
  State<HalamanKamera> createState() => _HalamanKameraState();
}

class _HalamanKameraState extends State<HalamanKamera>
    with WidgetsBindingObserver {
  CameraController? controller;

  bool loading = true;
  bool sedangMemotret = false;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    siapkanKamera();
  }

  Future<void> siapkanKamera() async {
    if (!mounted) return;

    setState(() {
      loading = true;
      pesanError = null;
    });

    try {
      if (!kIsWeb) {
        final izin = await Permission.camera.request();

        if (!izin.isGranted) {
          if (!mounted) return;

          setState(() {
            pesanError = izin.isPermanentlyDenied
                ? 'Izin kamera ditolak permanen.'
                : 'Izin kamera belum diberikan.';
            loading = false;
          });
          return;
        }
      }

      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('Kamera tidak ditemukan.');
      }

      final cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController.initialize();

      if (!mounted) {
        await cameraController.dispose();
        return;
      }

      controller = cameraController;

      setState(() {
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = 'Kamera gagal dibuka: $e';
        loading = false;
      });
    }
  }

  Future<void> ambilFoto() async {
    final cam = controller;

    if (cam == null ||
        !cam.value.isInitialized ||
        sedangMemotret) {
      return;
    }

    setState(() {
      sedangMemotret = true;
    });

    try {
      final foto = await cam.takePicture();
      final bytes = await foto.readAsBytes();

      if (!mounted) return;

      Navigator.pop(context, bytes);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil foto: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          sedangMemotret = false;
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      final cam = controller;
      controller = null;
      cam?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      siapkanKamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cam = controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambil Foto'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : pesanError != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.no_photography,
                          size: 65,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          pesanError!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: pesanError!.contains('permanen')
                              ? openAppSettings
                              : siapkanKamera,
                          child: Text(
                            pesanError!.contains('permanen')
                                ? 'Buka Pengaturan'
                                : 'Coba Lagi',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : cam != null && cam.value.isInitialized
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Center(
                          child: CameraPreview(cam),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: FloatingActionButton.large(
                            onPressed: sedangMemotret
                                ? null
                                : ambilFoto,
                            child: sedangMemotret
                                ? const CircularProgressIndicator()
                                : const Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text('Kamera belum tersedia'),
                    ),
    );
  }
}
