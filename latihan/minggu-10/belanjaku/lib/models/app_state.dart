
import 'package:flutter/material.dart';

class Product {
  final String nama;
  final int harga;
  final IconData ikon;

  const Product({
    required this.nama,
    required this.harga,
    required this.ikon,
  });
}

class AppState extends ChangeNotifier {
  final List<Product> _items = [];

  ThemeMode _themeMode = ThemeMode.light;

  List<Product> get items => List.unmodifiable(_items);

  int get jumlah => _items.length;

  ThemeMode get themeMode => _themeMode;

  int get totalHarga =>
      _items.fold(0, (total, item) => total + item.harga);

  void tambah(Product produk) {
    _items.add(produk);
    notifyListeners();
  }

  void hapus(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void ubahTema(bool gelap) {
    _themeMode = gelap ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

String formatRupiah(int harga) {
  final angka = harga.toString();
  final hasil = angka.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (match) => '.',
  );
  return 'Rp$hasil';
}
