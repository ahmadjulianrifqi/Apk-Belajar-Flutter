import 'package:flutter/material.dart';
import '../../core/storage/streak_storage.dart';
import '../materi/materi_page.dart';
import '../../widgets/materi_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int streak = 0;

  @override
  void initState() {
    super.initState();
    loadStreak();
  }

  Future<void> loadStreak() async {
    final value = await StreakStorage.getStreak();
    setState(() => streak = value);
  }

  Future<void> markToday() async {
    await StreakStorage.markToday();
    loadStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
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
                      const Text('Halo 👋',
                          style: TextStyle(color: Colors.white70)),
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
                        '🔥 Streak: $streak hari',
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
                    onPressed: markToday,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                    ),
                    child: const Text('Mulai'),
                  )
                ],
              ),
            ),

            // ===== MATERI =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Materi IPA',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                MateriCard(
                  title: 'Makhluk Hidup',
                  description: 'Ciri dan kebutuhan',
                  icon: Icons.pets,
                  color: Colors.green,
                  onTap: () => _openMateri(
                    context,
                    'Makhluk Hidup',
                    'Ciri dan kebutuhan makhluk hidup',
                  ),
                ),
                MateriCard(
                  title: 'Tumbuhan',
                  description: 'Bagian dan fungsi',
                  icon: Icons.local_florist,
                  color: Colors.lightGreen,
                  onTap: () => _openMateri(
                    context,
                    'Tumbuhan',
                    'Bagian dan fungsi tumbuhan',
                  ),
                ),
                MateriCard(
                  title: 'Tubuh Manusia',
                  description: 'Organ dan fungsi',
                  icon: Icons.accessibility_new,
                  color: Colors.orange,
                  onTap: () => _openMateri(
                    context,
                    'Tubuh Manusia',
                    'Organ tubuh dan fungsinya',
                  ),
                ),
                MateriCard(
                  title: 'Lingkungan',
                  description: 'Menjaga alam',
                  icon: Icons.public,
                  color: Colors.blue,
                  onTap: () => _openMateri(
                    context,
                    'Lingkungan',
                    'Cara menjaga lingkungan',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openMateri(
    BuildContext context,
    String title,
    String description,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MateriPage(
          title: title,
          description: description,
        ),
      ),
    );
  }
}
