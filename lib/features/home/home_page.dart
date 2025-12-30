import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../materi/materi_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> riwayatBelajar = [];
  int streakHariIni = 0;

  @override
  void initState() {
    super.initState();
    loadRiwayat();
  }

  Future<void> loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('riwayatBelajar') ?? [];

    data.sort();
    setState(() {
      riwayatBelajar = data;
      streakHariIni = hitungStreak(data);
    });
  }

  Future<void> tandaiBelajarHariIni() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (!riwayatBelajar.contains(today)) {
      riwayatBelajar.add(today);
      riwayatBelajar.sort();
      await prefs.setStringList('riwayatBelajar', riwayatBelajar);
    }

    setState(() {
      streakHariIni = hitungStreak(riwayatBelajar);
    });
  }

  int hitungStreak(List<String> data) {
    if (data.isEmpty) return 0;

    final dates = data
        .map((e) => DateTime.parse(e))
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime check = DateTime.now();

    for (final d in dates) {
      if (d.year == check.year &&
          d.month == check.month &&
          d.day == check.day) {
        streak++;
        check = check.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Halo 👋',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Siap Belajar IPA?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '🔥 Streak: $streakHariIni hari',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.green),
                  ),
                ],
              ),
            ),

            // ===== BANNER =====
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Belajar Hari Ini ✨',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tandai belajarmu agar streak bertambah',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: tandaiBelajarHariIni,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                    ),
                    child: const Text('Mulai'),
                  )
                ],
              ),
            ),

            // ===== SECTION TITLE =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Materi IPA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ===== GRID MATERI =====
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                MateriCard(
                  title: 'Makhluk Hidup',
                  description: 'Ciri dan kebutuhan',
                  icon: Icons.pets,
                  color: Colors.green,
                ),
                MateriCard(
                  title: 'Tumbuhan',
                  description: 'Bagian dan fungsi',
                  icon: Icons.local_florist,
                  color: Colors.lightGreen,
                ),
                MateriCard(
                  title: 'Tubuh Manusia',
                  description: 'Organ dan fungsi',
                  icon: Icons.accessibility_new,
                  color: Colors.orange,
                ),
                MateriCard(
                  title: 'Lingkungan',
                  description: 'Menjaga alam',
                  icon: Icons.public,
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// ===============================
/// CARD MATERI
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
            builder: (_) => MateriPage(
              title: title,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withAlpha(40),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
