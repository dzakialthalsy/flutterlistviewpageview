import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(home: HalamanDaftar(), debugShowCheckedModeBanner: false),
);

// model data
class Mahasiswa {
  final String nama, nim, email, profil;
  final List<String> jadwal;
  final List<String> nilai;

  Mahasiswa({
    required this.nama,
    required this.nim,
    required this.email,
    required this.profil,
    required this.jadwal,
    required this.nilai,
  });
}

final List<Mahasiswa> daftarMahasiswa = [
  Mahasiswa(
    nama: "Dzaki Althalsyah",
    nim: "245150407111071",
    email: "dz4ic7@student.ub.ac.id",
    profil:
        "Mahasiswa Sistem Informasi angkatan 2024 yang memiliki ketertarikan mendalam pada pengembangan aplikasi mobile menggunakan Flutter.",
    jadwal: [
      "Senin: Pengembangan Aplikasi Multiplatform",
      "Selasa: Arsitektur Perusahaan",
      "Kamis: Administrasi Basis Data",
    ],
    nilai: [
      "Pemrograman Mobile: A",
      "Analisis Sistem: A",
      "Desain Antarmuka: A-",
      "Basis Data Terdistribusi: B+",
    ],
  ),
  Mahasiswa(
    nama: "Budi",
    nim: "245150407111080",
    email: "budi@student.ub.ac.id",
    profil:
        "Seorang tech-enthusiast yang berfokus pada sisi Backend Engineering.",
    jadwal: [
      "Senin: Keamanan Informasi",
      "Rabu: Statistik Dasar",
      "Jumat: Pemrograman Web",
    ],
    nilai: ["Jaringan Komputer: B+", "Struktur Data: A", "Statistik Dasar: B"],
  ),
  Mahasiswa(
    nama: "Grace",
    nim: "245150407111099",
    email: "grace@student.ub.ac.id",
    profil: "Mahasiswa berprestasi yang fokus pada bidang Data Science.",
    jadwal: [
      "Selasa: Kecerdasan Buatan",
      "Rabu: Algoritma & Pemrograman",
      "Kamis: Etika Profesi",
    ],
    nilai: ["Kalkulus: A", "Statistik Komputasi: A", "Machine Learning: B+"],
  ),
];

// halaman daftar mahasiswa
class HalamanDaftar extends StatelessWidget {
  const HalamanDaftar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Mahasiswa",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: daftarMahasiswa.length,
        itemBuilder: (context, index) {
          final mhs = daftarMahasiswa[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
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
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => HalamanDetail(mhs: mhs)),
              ),
            ),
          );
        },
      ),
    );
  }
}

// halaman detail mahasiswa
class HalamanDetail extends StatelessWidget {
  final Mahasiswa mhs;
  const HalamanDetail({super.key, required this.mhs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Mahasiswa",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView(
        children: [
          // profil mahasiswa
          _buatHalaman(
            "Profil Mahasiswa",
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  mhs.nama,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(mhs.nim, style: const TextStyle(color: Colors.grey)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(mhs.profil, textAlign: TextAlign.center),
                ),
              ],
            ),
            Colors.white,
          ),
          // jadwal mahasiswa
          _buatHalaman(
            "Jadwal Kuliah",
            ListView.builder(
              shrinkWrap: true,
              itemCount: mhs.jadwal.length,
              itemBuilder: (c, i) => ListTile(
                leading: const Icon(Icons.schedule, color: Colors.green),
                title: Text(mhs.jadwal[i]),
              ),
            ),
            Colors.green.shade50,
          ),
          // nilai mahasiswa
          _buatHalaman(
            "Hasil Studi",
            ListView.builder(
              shrinkWrap: true,
              itemCount: mhs.nilai.length,
              itemBuilder: (c, i) => ListTile(
                leading: const Icon(Icons.star, color: Colors.orange),
                title: Text(mhs.nilai[i]),
              ),
            ),
            Colors.orange.shade50,
          ),
        ],
      ),
    );
  }

  // widget untuk membuat halaman di listview
  Widget _buatHalaman(String judul, Widget isi, Color warnaBg) {
    return Container(
      color: warnaBg,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              judul,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(child: isi),
          const Text(
            "Geser horizontal untuk info lain",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
