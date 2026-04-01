import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HalamanDaftarMahasiswa(),
    );
  }
}

// Model data mahasiswa
class Mahasiswa {
  final String nama;
  final String nim;
  final String profil;
  final List<String> jadwal;
  final Map<String, String> nilai;

  Mahasiswa({
    required this.nama,
    required this.nim,
    required this.profil,
    required this.jadwal,
    required this.nilai,
  });
}

// Data dummy mahasiswa
final List<Mahasiswa> daftarMahasiswa = [
  Mahasiswa(
    nama: "Dzaki Althalsyah",
    nim: "245150407111071",
    profil: "Mahasiswa Sistem Informasi yang tertarik pada Flutter",
    jadwal: [
      "Senin: Pengembangan Aplikasi Multiplatform",
      "Rabu: Pengantar Sains Data",
      "Jumat: Enterprise Architecture I",
    ],
    nilai: {
      "Pengembangan Aplikasi Multiplatform": "A",
      "Pengantar Sains Data": "A",
      "Enterprise Architecture I": "A",
    },
  ),
  Mahasiswa(
    nama: "Budi",
    nim: "245150407102928",
    profil: "Fokus pada pengembangan Backend dan Cloud Computing.",
    jadwal: ["Selasa: Jaringan Komputer", "Kamis: Statistik"],
    nilai: {"Jaringan Komputer": "B+", "Statistik": "A"},
  ),
  Mahasiswa(
    nama: "Grace",
    nim: "245150407928171",
    profil: "Pecinta Data Science dan Machine Learning.",
    jadwal: ["Senin: Kalkulus", "Rabu: Machine Learning"],
    nilai: {"Kalkulus": "A", "Machine Learning": "A"},
  ),
];

// Daftar mahasiswa (Listview)
class HalamanDaftarMahasiswa extends StatelessWidget {
  const HalamanDaftarMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Mahasiswa"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: daftarMahasiswa.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final mhs = daftarMahasiswa[index];
          // Tantangan Bonus: Custom List Item
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  mhs.nama[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                mhs.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(mhs.nim),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Interaksi Tap ke Detail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HalamanDetailMahasiswa(mahasiswa: mhs),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// PageView (profil,jadwal,nilai)
class HalamanDetailMahasiswa extends StatefulWidget {
  final Mahasiswa mahasiswa;
  const HalamanDetailMahasiswa({super.key, required this.mahasiswa});

  @override
  State<HalamanDetailMahasiswa> createState() => _HalamanDetailMahasiswaState();
}

class _HalamanDetailMahasiswaState extends State<HalamanDetailMahasiswa> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mahasiswa.nama)),
      body: Column(
        children: [
          // Area PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildSubPage("Profil", Icons.person, widget.mahasiswa.profil),
                _buildJadwalPage(),
                _buildNilaiPage(),
              ],
            ),
          ),

          // Tantangan Bonus: Page Indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => _buildIndicator(index)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget indikator
  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 25 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  // Helper untuk Sub-halaman umum
  Widget _buildSubPage(String title, IconData icon, String content) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget khusus halaman jadwal
  Widget _buildJadwalPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Icon(Icons.calendar_month, size: 80, color: Colors.green),
          const SizedBox(height: 20),
          const Text(
            "Jadwal Kuliah",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          ...widget.mahasiswa.jadwal.map(
            (j) => Card(
              child: ListTile(
                title: Text(j),
                leading: const Icon(Icons.check_circle_outline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget khusus halaman nilai
  Widget _buildNilaiPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Icon(Icons.grade, size: 80, color: Colors.orange),
          const SizedBox(height: 20),
          const Text(
            "Daftar Nilai",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            children: widget.mahasiswa.nilai.entries.map((e) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(e.key),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(e.value, textAlign: TextAlign.center),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
