
import 'package:flutter/material.dart';
import '../models/app_state.dart';

class LiftingPage extends StatefulWidget {
  const LiftingPage({super.key});

  @override
  State<LiftingPage> createState() => _LiftingPageState();
}

class _LiftingPageState extends State<LiftingPage> {
  final List<Map<String, dynamic>> produk = [
    {'nama': 'Laptop', 'harga': 8500000, 'ikon': Icons.laptop_mac},
    {'nama': 'Mouse', 'harga': 150000, 'ikon': Icons.mouse},
    {'nama': 'Keyboard', 'harga': 350000, 'ikon': Icons.keyboard},
    {'nama': 'Headset', 'harga': 275000, 'ikon': Icons.headphones},
    {'nama': 'Monitor', 'harga': 2000000, 'ikon': Icons.desktop_windows},
  ];

  final List<Map<String, dynamic>> keranjang = [];

  void tambahProduk(Map<String, dynamic> item) {
    setState(() {
      keranjang.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Lifting State Up',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Pilih produk untuk menambahkannya ke keranjang.',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 16),
        ProductChild(
          produk: produk,
          onTambah: tambahProduk,
        ),
        const SizedBox(height: 20),
        CartChild(keranjang: keranjang),
      ],
    );
  }
}

class ProductChild extends StatelessWidget {
  final List<Map<String, dynamic>> produk;
  final Function(Map<String, dynamic>) onTambah;

  const ProductChild({
    super.key,
    required this.produk,
    required this.onTambah,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: produk.map((item) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 2,
          shadowColor: const Color(0xFF168BFF).withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: const Color(0xFF168BFF).withOpacity(0.25),
            ),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF168BFF).withOpacity(0.12),
              child: Icon(item['ikon'], color: const Color(0xFF168BFF)),
            ),
            title: Text(
              item['nama'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              formatRupiah(item['harga']),
              style: const TextStyle(
                color: Color(0xFF168BFF),
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: IconButton(
              tooltip: 'Tambah ke keranjang',
              onPressed: () => onTambah(item),
              icon: const Icon(Icons.add_circle, color: Color(0xFF168BFF)),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CartChild extends StatelessWidget {
  final List<Map<String, dynamic>> keranjang;

  const CartChild({super.key, required this.keranjang});

  @override
  Widget build(BuildContext context) {
    final total = keranjang.fold<int>(
      0,
      (jumlah, item) => jumlah + (item['harga'] as int),
    );

    return Card(
      color: const Color(0xFF0D47A1),
      elevation: 5,
      shadowColor: const Color(0xFF168BFF).withOpacity(0.35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.shopping_bag, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Keranjang Lifting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Jumlah barang: ${keranjang.length}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              'Total: ${formatRupiah(total)}',
              style: const TextStyle(
                color: Color(0xFF8EDBFF),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (keranjang.isNotEmpty) ...[
              const Divider(color: Colors.white38, height: 22),
              ...keranjang.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '• ${item['nama']} — ${formatRupiah(item['harga'])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
