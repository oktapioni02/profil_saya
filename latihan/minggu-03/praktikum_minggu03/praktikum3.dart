void main() {
  print('=== PRAKTIKUM 3: Pola Bilangan ===\n');

  // ---------- A. Bilangan 1-50, lewati kelipatan 3 ----------
  print('A. Bilangan 1 sampai 50 (kelipatan 3 dilewati):');
  for (int i = 1; i <= 50; i++) {
    if (i % 3 == 0) {
      continue; // lewati kelipatan 3
    }
    print(i);
  }

  print('\n--------------------------------\n');

  // ---------- B. Segitiga bintang 5 baris ----------
  print('B. Segitiga bintang 5 baris:');
  for (int baris = 1; baris <= 5; baris++) {
    String bintang = '';
    for (int j = 1; j <= baris; j++) {
      bintang += '* ';
    }
    print(bintang);
  }

  print('\n--------------------------------\n');

  // ---------- C. Faktorial ----------
  int angka = 5; // bisa diganti

  // Versi while
  int faktorialWhile = 1;
  int i = 1;
  while (i <= angka) {
    faktorialWhile *= i;
    i++;
  }

  // Versi rekursif
  int faktorialRekursif = hitungFaktorial(angka);

  print('C. Faktorial dari $angka');
  print('   Versi while     : $faktorialWhile');
  print('   Versi rekursif  : $faktorialRekursif');
}

// Fungsi rekursif
int hitungFaktorial(int n) {
  if (n <= 1) {
    return 1; // basis
  }
  return n * hitungFaktorial(n - 1); // rekursif
}