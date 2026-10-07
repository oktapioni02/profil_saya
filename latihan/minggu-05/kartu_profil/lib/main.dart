import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiProfil());
}

class AplikasiProfil extends StatelessWidget {
  const AplikasiProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0B6B45),
        useMaterial3: true,
      ),
      home: const HalamanProfil(),
    );
  }
}

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8E4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Color(0xFF0B6B45),
                    child: Icon(Icons.person, size: 36, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ni Kadek Okta Pioni',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text('202463121008 - Teknik Komputer'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _barisInfo(Icons.email_outlined, 'okta@warmadewa.ac.id'),
              const SizedBox(height: 12),
              _barisInfo(Icons.phone_outlined, '+62 8214 4249 257'),
              const SizedBox(height: 12),
              _barisInfo(Icons.school_outlined, 'Angkatan 2024'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _barisInfo(IconData ikon, String teks) {
    return Row(
      children: [
        Icon(ikon, color: const Color(0xFF0B6B45), size: 22),
        const SizedBox(width: 12),
        Text(teks),
      ],
    );
  }
}