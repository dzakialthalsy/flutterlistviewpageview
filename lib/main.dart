import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Informasi Akademik Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'sans-serif',
      ),
      home: const HalamanDaftarMahasiswa(),
    );
  }
}

class Mahasiswa {
  final String nama;
  final String nim;
  final String email;
  final String profil;
  final List<String> jadwal;
  final Map<String, String> nilai;

  Mahasiswa({
    required this.nama,
    required this.nim,
    required this.email,
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
    email: "dz4ic7@student.ub.ac.id",
    profil:
        "Mahasiswa Sistem Informasi angkatan 2024 yang memiliki ketertarikan mendalam pada pengembangan aplikasi mobile menggunakan Flutter. Saat ini sedang fokus mempelajari State Management dan integrasi API untuk membangun aplikasi yang skalabel dan user-friendly.",
    jadwal: [
      "Senin: Pengembangan Aplikasi Multiplatform (08:00)",
      "Selasa: Arsitektur Perusahaan (10:30)",
      "Kamis: Administrasi Basis Data (13:00)",
    ],
    nilai: {
      "Pemrograman Mobile": "A",
      "Analisis Sistem": "A",
      "Desain Antarmuka": "A-",
      "Basis Data Terdistribusi": "B+",
    },
  ),
  Mahasiswa(
    nama: "Budi",
    nim: "245150407111080",
    email: "budi@student.ub.ac.id",
    profil:
        "Seorang tech-enthusiast yang berfokus pada sisi Backend Engineering. Memiliki minat eksplorasi pada teknologi Cloud Computing dan keamanan jaringan. Aktif dalam organisasi kemahasiswaan di bidang robotika dan pengembangan IoT.",
    jadwal: [
      "Senin: Keamanan Informasi (08:00)",
      "Rabu: Statistik Dasar (09:00)",
      "Jumat: Pemrograman Web (13:00)",
    ],
    nilai: {
      "Jaringan Komputer": "B+",
      "Struktur Data": "A",
      "Statistik Dasar": "B",
    },
  ),
  Mahasiswa(
    nama: "Grace",
    nim: "245150407111099",
    email: "grace@student.ub.ac.id",
    profil:
        "Mahasiswa berprestasi yang fokus pada bidang Data Science. Mahir dalam bahasa pemrograman Python dan R. Memiliki visi untuk mengimplementasikan Machine Learning guna membantu pengambilan keputusan di sektor publik dan pemerintahan.",
    jadwal: [
      "Selasa: Kecerdasan Buatan (07:30)",
      "Rabu: Algoritma & Pemrograman (10:00)",
      "Kamis: Etika Profesi (15:00)",
    ],
    nilai: {
      "Kalkulus": "A",
      "Statistik Komputasi": "A",
      "Machine Learning": "B+",
    },
  ),
];

// Halaman daftar mahasiswa dengan ListView
class HalamanDaftarMahasiswa extends StatelessWidget {
  const HalamanDaftarMahasiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Mahasiswa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: daftarMahasiswa.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final mhs = daftarMahasiswa[index];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue.shade400,
                child: Text(
                  mhs.nama[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                mhs.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(mhs.nim),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
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

// Halaman Detail Mahasiswa menggunakan PageView
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
      appBar: AppBar(title: const Text("Detail Mahasiswa"), elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              children: [
                _buildProfilPage(),
                _buildJadwalPage(),
                _buildNilaiPage(),
              ],
            ),
          ),
          // Page Indicator (Tantangan Bonus)
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => _buildIndicator(index)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Halaman profil mahasiswa
  Widget _buildProfilPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person, size: 80, color: Colors.blue),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.mahasiswa.nama,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "NIM: ${widget.mahasiswa.nim}",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
          const SizedBox(height: 25),

          _buildInfoTile(
            Icons.info_outline,
            "Tentang Saya",
            widget.mahasiswa.profil,
          ),
          const Divider(indent: 70, endIndent: 20),
          _buildInfoTile(
            Icons.email_outlined,
            "Email Akademik",
            widget.mahasiswa.email,
          ),
          const Divider(indent: 70, endIndent: 20),
          _buildInfoTile(
            Icons.location_on_outlined,
            "Program Studi",
            "Sistem Informasi",
          ),
          const Divider(indent: 70, endIndent: 20),
          _buildInfoTile(Icons.school_outlined, "Fakultas", "Ilmu Komputer"),

          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Fitur edit profil belum tersedia"),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profil Mahasiswa"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Halaman jadwal kuliah mahasiswa
  Widget _buildJadwalPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Icon(Icons.calendar_month, size: 70, color: Colors.green),
          const SizedBox(height: 15),
          const Text(
            "Jadwal Kuliah",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: widget.mahasiswa.jadwal
                  .map(
                    (j) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 0,
                      color: Colors.green.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.access_time,
                          color: Colors.green,
                        ),
                        title: Text(
                          j,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Halaman nilai mahasiswa
  Widget _buildNilaiPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Icon(Icons.grade_rounded, size: 70, color: Colors.orange),
          const SizedBox(height: 15),
          const Text(
            "Hasil Studi",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Colors.grey.shade300),
                ),
                columnWidths: const {1: FixedColumnWidth(80)},
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.orange.shade50),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Mata Kuliah",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Nilai",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ...widget.mahasiswa.nilai.entries.map((e) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(e.key),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            e.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
