
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Column(
      children: [
        Expanded(
          child: state.items.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 75,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Keranjang masih kosong',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text('Silakan pilih produk di katalog'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];

                    return Card(
                      child: ListTile(
                        leading: Icon(
                          item.ikon,
                          color: Colors.blue,
                          size: 30,
                        ),
                        title: Text(
                          item.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(formatRupiah(item.harga)),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<AppState>().hapus(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.10),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Jumlah item: ${state.jumlah}'),
              const SizedBox(height: 5),
              const Text('Total Belanja'),
              Text(
                formatRupiah(state.totalHarga),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
