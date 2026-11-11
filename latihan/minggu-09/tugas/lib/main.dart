
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

import 'halaman_kamera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catatan Bergambar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const NotesPage(),
    );
  }
}

class NoteItem {
  final String title;
  final String content;
  final Uint8List image;

  NoteItem({
    required this.title,
    required this.content,
    required this.image,
  });
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  final List<NoteItem> notes = [];

  Uint8List? selectedImage;
  bool isProcessing = false;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    setState(() {
      isProcessing = true;
    });

    try {
      Uint8List? bytes;

      if (source == ImageSource.camera) {
        bytes = await Navigator.push<Uint8List>(
          context,
          MaterialPageRoute(
            builder: (context) => const HalamanKamera(),
          ),
        );
      } else {
        final XFile? file = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );

        if (file != null) {
          bytes = await file.readAsBytes();
        }
      }

      if (!mounted) return;

      if (bytes != null) {
        setState(() {
          selectedImage = bytes;
        });
      }
    } on PlatformException catch (e) {
      if (!mounted) return;

      String message = 'Izin kamera atau galeri tidak diberikan.';

      if (e.code == 'camera_access_denied') {
        message = 'Akses kamera ditolak. Silakan berikan izin kamera.';
      } else if (e.code == 'photo_access_denied') {
        message = 'Akses galeri ditolak. Silakan berikan izin foto.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil gambar: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  void saveNote() {
    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty ||
        selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Isi judul, catatan, dan pilih satu foto terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    setState(() {
      notes.insert(
        0,
        NoteItem(
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: selectedImage!,
        ),
      );

      titleController.clear();
      contentController.clear();
      selectedImage = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan berhasil disimpan!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catatan Bergambar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buat Catatan Baru',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Catatan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: contentController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Isi Catatan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Tambahkan Foto',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isProcessing
                        ? null
                        : () => pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Kamera'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isProcessing
                        ? null
                        : () => pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeri'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (isProcessing)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text('Sedang memproses gambar...'),
                ],
              )
            else if (selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  selectedImage!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Belum ada foto dipilih'),
              ),

            const SizedBox(height: 16),

            FilledButton.icon(
              onPressed: isProcessing ? null : saveNote,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Catatan'),
            ),

            const Divider(height: 36),

            const Text(
              'Daftar Catatan',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (notes.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('Belum ada catatan.'),
                ),
              )
            else
              ...notes.map(
                (note) => Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.memory(
                        note.image,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(note.content),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
