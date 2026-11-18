
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final gelap = state.themeMode == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF64B5F6)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                'BelanjaKu',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Text(
                'Belanja lebih mudah dan praktis.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'Tampilan Aplikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),

        const SizedBox(height: 8),

        Card(
          child: SwitchListTile(
            secondary: Icon(
              gelap ? Icons.dark_mode : Icons.light_mode,
              color: Colors.blue,
            ),
            title: const Text('Mode Gelap'),
            subtitle: Text(
              gelap ? 'Tema gelap aktif' : 'Tema terang aktif',
            ),
            value: gelap,
            onChanged: (value) {
              context.read<AppState>().ubahTema(value);
            },
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Tentang Aplikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),

        const SizedBox(height: 8),

        Card(
          child: ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            title: const Text('BelanjaKu'),
            subtitle: const Text('Informasi aplikasi dan versi'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'BelanjaKu',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.shopping_bag,
                  color: Colors.blue,
                  size: 45,
                ),
                applicationLegalese:
                    'Aplikasi daftar belanja menggunakan Flutter, '
                    'setState, Lifting State Up, dan Provider.',
              );
            },
          ),
        ),

        Card(
          child: ListTile(
            leading: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.blue,
            ),
            title: const Text('Jumlah Keranjang'),
            subtitle: Text('${state.jumlah} produk tersimpan'),
          ),
        ),
      ],
    );
  }
}
