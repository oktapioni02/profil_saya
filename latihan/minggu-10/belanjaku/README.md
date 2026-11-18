# BelanjaKu
### Aplikasi Daftar Belanja Berbasis Flutter

## Deskripsi
BelanjaKu merupakan aplikasi daftar belanja yang menggabungkan materi praktikum state management Flutter, mulai dari setState, Lifting State Up, hingga Provider.

## Fitur Aplikasi
1. Penghitung angka dengan riwayat perubahan.
2. Demonstrasi Lifting State Up melalui daftar produk dan ringkasan keranjang.
3. Katalog produk dengan harga.
4. Keranjang belanja dengan fitur tambah, hapus, dan total harga otomatis.
5. Pengaturan tema terang dan gelap.
6. Jumlah keranjang terlihat pada seluruh halaman.

## Teknologi
- Flutter
- Dart
- Provider
- ChangeNotifier

## Penjelasan Penempatan State

### 1. Praktikum 1 — setState
State penghitung dan riwayat disimpan di CounterPage karena hanya digunakan pada halaman penghitung. setState digunakan untuk memperbarui tampilan ketika angka berubah.

### 2. Praktikum 2 — Lifting State Up
Data keranjang demonstrasi disimpan pada LiftingPage sebagai widget induk. Data dan fungsi penambahan dikirimkan kepada ProductChild dan CartChild agar kedua widget dapat menggunakan data yang sama.

### 3. State Management Provider
AppState menggunakan ChangeNotifier untuk menyimpan data keranjang utama dan pengaturan tema karena keduanya dibutuhkan oleh beberapa halaman aplikasi.

### 4. State Navigasi
Indeks halaman aktif disimpan pada HomePage menggunakan setState karena hanya digunakan untuk mengatur perpindahan antarhalaman.

### 5. Data Produk
Daftar produk disimpan sebagai static const di CatalogPage karena datanya bersifat tetap dan tidak memerlukan pembaruan state.

## Alur Provider
- ChangeNotifierProvider menyediakan AppState untuk seluruh aplikasi.
- context.watch digunakan untuk membaca dan mendengarkan perubahan state.
- context.read digunakan untuk menjalankan aksi penambahan, penghapusan, dan perubahan tema.
- notifyListeners digunakan untuk memberitahu widget ketika state berubah.

## Cara Menjalankan
1. Instal Flutter dan VS Code.
2. Buka folder project BelanjaKu.
3. Jalankan `flutter pub add provider`.
4. Jalankan `flutter run -d chrome`.

## Kesimpulan
BelanjaKu menggabungkan tiga pendekatan pengelolaan state, yaitu setState, Lifting State Up, dan Provider. Setiap state ditempatkan berdasarkan kebutuhan dan cakupan penggunaannya agar aplikasi lebih terstruktur dan mudah dikelola.