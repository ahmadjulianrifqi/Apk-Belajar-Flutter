import 'package:flutter/material.dart';
import '../quiz/quiz_page.dart';
class MateriPage extends StatelessWidget {
  final String title;
  final String description;

  const MateriPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// JUDUL
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// DESKRIPSI SINGKAT
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            /// SUB JUDUL
            const Text(
              'Penjelasan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            /// ISI MATERI (DUMMY DULU)
            const Text(
              'Makhluk hidup adalah semua yang dapat bernapas, tumbuh, '
              'bergerak, dan berkembang biak. Contohnya adalah manusia, '
              'hewan, dan tumbuhan.\n\n'
              'Makhluk hidup membutuhkan makanan, air, dan udara untuk '
              'bertahan hidup.',
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 32),

            /// BUTTON NEXT (NANTI KE QUIZ)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizPage(),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Latihan Soal',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
