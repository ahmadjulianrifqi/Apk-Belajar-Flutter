import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../materi/materi_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> riwayatBelajar = [];
  DateTime currentMonth = DateTime.now();
  int streakHariIni = 0;

  @override
  void initState() {
    super.initState();
    loadRiwayat();
  }

  Future<void> loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tanggalBelajar = prefs.getStringList('riwayatBelajar') ?? [];
    tanggalBelajar.sort();
    setState(() {
      riwayatBelajar = tanggalBelajar;
      streakHariIni = hitungStreak(tanggalBelajar);
    });
  }

  Future<void> tandaiBelajarHariIni() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toString().substring(0, 10);

    if (!riwayatBelajar.contains(today)) {
      riwayatBelajar.add(today);
      riwayatBelajar.sort();
      await prefs.setStringList('riwayatBelajar', riwayatBelajar);
    }

    setState(() {
      streakHariIni = hitungStreak(riwayatBelajar);
    });
  }

  int hitungStreak(List<String> tanggalBelajar) {
    if (tanggalBelajar.isEmpty) return 0;

    final List<DateTime> dates = tanggalBelajar.map((e) => DateTime.parse(e)).toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime hariIni = DateTime.now();

    for (var date in dates) {
      if (date.year == hariIni.year &&
          date.month == hariIni.month &&
          date.day == hariIni.day) {
        streak++;
        hariIni = hariIni.subtract(const Duration(days: 1));
      } else if (date.isBefore(hariIni)) {
        break;
      }
    }
    return streak;
  }

  List<Widget> buildCalendar() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final totalDays = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday; // Senin=1 .. Minggu=7

    List<Widget> calendarCells = [];

    for (int i = 1; i < firstWeekday; i++) {
      calendarCells.add(const SizedBox());
    }

    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final dateString = date.toString().substring(0, 10);
      final isLearned = riwayatBelajar.contains(dateString);

      calendarCells.add(
        GestureDetector(
          onTap: () {
            if (dateString == DateTime.now().toString().substring(0, 10)) {
              tandaiBelajarHariIni();
            }
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isLearned ? Colors.green.withAlpha(50) : Colors.grey.withAlpha(30),
              border: isLearned ? Border.all(color: Colors.green, width: 2) : null,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isLearned ? Colors.green[800] : Colors.black),
                ),
                if (isLearned)
                  const Positioned(
                    bottom: 2,
                    right: 2,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return calendarCells;
  }

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat.MMMM('id').format(currentMonth);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('IPA SD'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Belajar IPA Jadi Seru 🌱',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Pilih materi untuk mulai belajar'),
            const SizedBox(height: 16),

            // ===== CALENDAR =====
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(38),
                    spreadRadius: 2,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$monthName ${currentMonth.year}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: buildCalendar(),
                  ),
                  const SizedBox(height: 8),
                  Text('Streak berturut-turut: $streakHariIni hari'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: tandaiBelajarHariIni,
                    child: const Text('Tandai Belajar Hari Ini'),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ===== GRID MATERI =====
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                MateriCard(
                  title: 'Makhluk Hidup',
                  description: 'Belajar tentang ciri-ciri dan kebutuhan makhluk hidup.',
                  icon: Icons.pets,
                  color: Colors.green,
                ),
                MateriCard(
                  title: 'Tumbuhan',
                  description: 'Mengenal bagian tumbuhan dan fungsinya.',
                  icon: Icons.local_florist,
                  color: Colors.lightGreen,
                ),
                MateriCard(
                  title: 'Tubuh Manusia',
                  description: 'Mengenal bagian tubuh manusia dan kegunaannya.',
                  icon: Icons.accessibility_new,
                  color: Colors.orange,
                ),
                MateriCard(
                  title: 'Lingkungan',
                  description: 'Menjaga kebersihan dan kelestarian lingkungan.',
                  icon: Icons.public,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================
/// WIDGET CARD MATERI
/// ===============================
class MateriCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const MateriCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MateriPage(
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(38),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
