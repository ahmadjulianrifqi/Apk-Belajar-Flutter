import 'package:flutter/material.dart';
import '../materi/materi_page.dart';
import '../quiz/quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('IPA SD'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Belajar IPA Jadi Seru 🌱',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih materi untuk mulai belajar',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: const [
                  MateriCard(
                    title: 'Makhluk Hidup',
                    description:
                        'Belajar tentang ciri-ciri dan kebutuhan makhluk hidup.',
                    icon: Icons.pets,
                    color: Colors.green,
                  ),
                  MateriCard(
                    title: 'Tumbuhan',
                    description:
                        'Mengenal bagian tumbuhan dan fungsinya.',
                    icon: Icons.local_florist,
                    color: Colors.lightGreen,
                  ),
                  MateriCard(
                    title: 'Tubuh Manusia',
                    description:
                        'Mengenal bagian tubuh manusia dan kegunaannya.',
                    icon: Icons.accessibility_new,
                    color: Colors.orange,
                  ),
                  MateriCard(
                    title: 'Lingkungan',
                    description:
                        'Menjaga kebersihan dan kelestarian lingkungan.',
                    icon: Icons.public,
                    color: Colors.blue,
                  ),
                ],
              ),
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
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
