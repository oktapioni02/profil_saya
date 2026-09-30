import 'dart:io';

void main() {
  Map<int, Map<String, dynamic>> menu = {
    1: {'nama': 'Nasi Goreng', 'harga': 15000.0},
    2: {'nama': 'Mie Ayam', 'harga': 12000.0},
    3: {'nama': 'Es Teh', 'harga': 5000.0},
    4: {'nama': 'Es Jeruk', 'harga': 6000.0},
    5: {'nama': 'Ayam Geprek', 'harga': 18000.0},
  };

  double totalBelanja = 0;
  bool lanjut = true;

  print('=================================');
  print('     APLIKASI MENU KANTIN');
  print('=================================');

  while (lanjut) {
    print('\n----- MENU KANTIN -----');
    menu.forEach((kode, item) {
      print('$kode. ${item['nama']} - Rp${item['harga'].toStringAsFixed(0)}');
    });
    print('0. Selesai & Bayar');
    print('-----------------------');

    int pilihan = bacaAngka('Pilih menu (angka): ');

    switch (pilihan) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        int jumlah = bacaAngka('Jumlah pesanan: ');

        if (jumlah <= 0) {
          print('Jumlah harus lebih dari 0!');
          break;
        }

        double harga = menu[pilihan]!['harga'];
        double subtotal = harga * jumlah;
        totalBelanja += subtotal;

        print('→ ${menu[pilihan]!['nama']} x $jumlah = Rp${subtotal.toStringAsFixed(0)}');
        print('Total sementara: Rp${totalBelanja.toStringAsFixed(0)}');
        break;

      case 0:
        lanjut = false;
        break;

      default:
        print('Pilihan tidak valid! Silakan pilih angka yang ada di menu.');
    }
  }

  print('\n=================================');
  print('       RINCIAN PEMBAYARAN');
  print('=================================');
  print('Total Belanja : Rp${totalBelanja.toStringAsFixed(0)}');
  print('Terima kasih telah berbelanja!');
  print('=================================');
}

int bacaAngka(String pesan) {
  while (true) {
    stdout.write(pesan);
    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print('Input tidak boleh kosong!');
      continue;
    }

    try {
      return int.parse(input.trim());
    } catch (e) {
      print('Input tidak valid! Harap masukkan angka saja.');
    }
  }
}