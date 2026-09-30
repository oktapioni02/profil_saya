import 'dart:io'; // untuk membaca input dari keyboard

void main() {
  print('=== PRAKTIKUM 2: Simulasi Login ===');

  const String passwordBenar = 'dart123'; // password yang benar
  int kesempatan = 0;
  const int maksKesempatan = 3;
  bool berhasil = false;

  do {
    kesempatan++;
    stdout.write('Percobaan ke-$kesempatan - Masukkan password: ');
    String? input = stdin.readLineSync(); // baca input user

    if (input == passwordBenar) {
      print('Login berhasil! Selamat datang.');
      berhasil = true;
      break; // hentikan perulangan saat benar
    } else {
      print('Password salah!');
    }
  } while (kesempatan < maksKesempatan);

  // Setelah keluar dari do-while
  if (!berhasil) {
    print('Kesempatan habis! Akun terkunci setelah 3 kali percobaan gagal.');
  }
}