import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
  {
    'question': 'Makhluk hidup membutuhkan apa untuk bertahan hidup?',
    'options': ['Mainan', 'Makanan', 'Uang', 'Baju'],
    'answer': 'Makanan',
    'explanation': 'Makanan dibutuhkan untuk mendapatkan energi.',
  },
  {
    'question': 'Contoh makhluk hidup adalah?',
    'options': ['Meja', 'Kursi', 'Kucing', 'Buku'],
    'answer': 'Kucing',
    'explanation': 'Kucing bisa bernapas dan berkembang biak.',
  },
  {
    'question': 'Tumbuhan memerlukan apa untuk membuat makanan?',
    'options': ['Air', 'Cahaya Matahari', 'Tanah', 'Semua benar'],
    'answer': 'Semua benar',
    'explanation':
        'Tumbuhan memerlukan air, tanah, dan cahaya matahari.',
  },
  {
    'question': 'Manusia bernapas menggunakan?',
    'options': ['Kulit', 'Hidung', 'Telinga', 'Mata'],
    'answer': 'Hidung',
    'explanation': 'Hidung membantu manusia bernapas.',
  },
  {
    'question': 'Makhluk hidup berkembang biak artinya?',
    'options': [
      'Bertambah jumlah',
      'Berpindah tempat',
      'Berubah warna',
      'Tidur'
    ],
    'answer': 'Bertambah jumlah',
    'explanation':
        'Berkembang biak berarti menghasilkan keturunan.',
  },
];


  void answerQuestion(String selectedAnswer) {
  final correctAnswer =
      questions[currentQuestion]['answer'];
  final explanation =
      questions[currentQuestion]['explanation'];

  final bool isCorrect =
      selectedAnswer == correctAnswer;

  if (isCorrect) {
    score++;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text(
        isCorrect ? 'Benar ✅' : 'Salah ❌',
        style: TextStyle(
          color: isCorrect ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jawaban benar: $correctAnswer',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(explanation),
          const SizedBox(height: 16),
          Text(
            'Skor sementara: $score',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);

            if (currentQuestion <
                questions.length - 1) {
              setState(() {
                currentQuestion++;
              });
            } else {
              showResult();
            }
          },
          child: const Text('Lanjut'),
        ),
      ],
    ),
  );
}

void showResult() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Quiz Selesai 🎉'),
      content: Text(
        'Nilai kamu: $score / ${questions.length}',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              currentQuestion = 0;
              score = 0;
            });
          },
          child: const Text('Ulangi'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text('Kembali'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz IPA'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soal ${currentQuestion + 1} dari ${questions.length}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              question['question'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            ...question['options'].map<Widget>((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () => answerQuestion(option),
                  child: Text(option),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
