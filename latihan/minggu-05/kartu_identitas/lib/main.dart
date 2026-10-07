import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiKartuIdentitas());
}

class AplikasiKartuIdentitas extends StatelessWidget {
  const AplikasiKartuIdentitas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Identitas Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0B6B45),
        useMaterial3: true,
      ),
      home: const HalamanKartu(),
    );
  }
}

// ========== StatefulWidget ==========
class HalamanKartu extends StatefulWidget {
  const HalamanKartu({super.key});

  @override
  State<HalamanKartu> createState() => _HalamanKartuState();
}

class _HalamanKartuState extends State<HalamanKartu> {
  bool _modeGelap = false;

  void _gantiTema() {
    setState(() {
      _modeGelap = !_modeGelap;
    });
  }

  @override
  Widget build(BuildContext context) {
    final warnaLatar = _modeGelap
        ? const Color(0xFF1A1A2E)
        : const Color(0xFFF0F7F4);

    final warnaKartu = _modeGelap
        ? const Color(0xFF16213E)
        : Colors.white;

    final warnaTeks = _modeGelap
        ? Colors.white
        : Colors.black87;

    final warnaHijau = const Color(0xFF0B6B45);

    final warnaBorder = _modeGelap
        ? Colors.white24
        : const Color(0xFFE2E8E4);

    return Scaffold(
      backgroundColor: warnaLatar,

      appBar: AppBar(
        title: const Text('Kartu Identitas Digital'),
        centerTitle: true,
        backgroundColor: warnaHijau,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // ========== KARTU ==========
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: warnaKartu,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: warnaBorder,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    // ========== FOTO + NAMA ==========
                    Row(
                      children: [

                        // FOTO DARI ASSETS
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: warnaHijau,
                          backgroundImage: const AssetImage(
                            'assets/okta.jpg',
                          ),
                        ),

                        const SizedBox(width: 16),

                        // NAMA
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Ni Kadek Okta Pioni',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warnaTeks,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                '202463121008',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: warnaTeks.withOpacity(0.7),
                                ),
                              ),

                              Text(
                                'Teknik Komputer',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: warnaHijau,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Divider(
                      color: warnaBorder,
                    ),

                    const SizedBox(height: 16),

                    // ========== DATA DIRI ==========

                    _barisData(
                      Icons.email_outlined,
                      'Email',
                      'okta@warmadewa.ac.id',
                      warnaTeks,
                      warnaHijau,
                    ),

                    const SizedBox(height: 14),

                    _barisData(
                      Icons.phone_outlined,
                      'Telepon',
                      '+62 8214 4249 257',
                      warnaTeks,
                      warnaHijau,
                    ),

                    const SizedBox(height: 14),

                    _barisData(
                      Icons.school_outlined,
                      'Program Studi',
                      'Teknik Komputer',
                      warnaTeks,
                      warnaHijau,
                    ),

                    const SizedBox(height: 14),

                    _barisData(
                      Icons.location_on_outlined,
                      'Alamat',
                      'Denpasar, Bali',
                      warnaTeks,
                      warnaHijau,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ========== TOMBOL GANTI TEMA ==========
              FilledButton.icon(
                onPressed: _gantiTema,

                icon: Icon(
                  _modeGelap
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),

                label: Text(
                  _modeGelap
                      ? 'Mode Terang'
                      : 'Mode Gelap',
                ),

                style: FilledButton.styleFrom(
                  backgroundColor: warnaHijau,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),

                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== HELPER WIDGET ==========
  Widget _barisData(
    IconData ikon,
    String label,
    String nilai,
    Color warnaTeks,
    Color warnaIkon,
  ) {
    return Row(
      children: [

        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: warnaIkon.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),

          child: Icon(
            ikon,
            color: warnaIkon,
            size: 22,
          ),
        ),

        const SizedBox(width: 14),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: warnaTeks.withOpacity(0.6),
              ),
            ),

            Text(
              nilai,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: warnaTeks,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
