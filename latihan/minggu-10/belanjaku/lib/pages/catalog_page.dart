
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  static const List<Product> produk = [
    Product(
      nama: 'Laptop',
      harga: 8500000,
      ikon: Icons.laptop_mac,
    ),
    Product(
      nama: 'Mouse',
      harga: 150000,
      ikon: Icons.mouse,
    ),
    Product(
      nama: 'Keyboard',
      harga: 350000,
      ikon: Icons.keyboard,
    ),
    Product(
      nama: 'Headset',
      harga: 275000,
      ikon: Icons.headphones,
    ),
    Product(
      nama: 'Monitor',
      harga: 2000000,
      ikon: Icons.desktop_windows,
    ),
    Product(
      nama: 'Flashdisk',
      harga: 75000,
      ikon: Icons.usb,
    ),
    Product(
      nama: 'Webcam',
      harga: 450000,
      ikon: Icons.videocam,
    ),
    Product(
      nama: 'Speaker',
      harga: 300000,
      ikon: Icons.speaker,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final gelap = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: produk.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.20,
      ),
      itemBuilder: (context, index) {
        final item = produk[index];

        return Card(
          elevation: 3,
          shadowColor: const Color(0xFF168BFF).withOpacity(0.25),
          color: gelap ? const Color(0xFF172B45) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: const Color(0xFF168BFF).withOpacity(0.35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.ikon,
                  size: 30,
                  color: const Color(0xFF168BFF),
                ),
                const SizedBox(height: 5),
                Text(
                  item.nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                FittedBox(
                  child: Text(
                    formatRupiah(item.harga),
                    style: const TextStyle(
                      color: Color(0xFF168BFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 29,
                  width: 34,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: const Color(0xFF168BFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    onPressed: () {
                      context.read<AppState>().tambah(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.nama} ditambahkan ke keranjang'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Icon(Icons.add, size: 19),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
