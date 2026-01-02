import 'package:shared_preferences/shared_preferences.dart';

class StreakStorage {
  static const String _key = 'riwayatBelajar';

  /// Ambil semua tanggal belajar
  static Future<List<String>> getRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    data.sort();
    return data;
  }

  /// Tandai belajar hari ini
  static Future<void> markToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    final data = prefs.getStringList(_key) ?? [];

    if (!data.contains(today)) {
      data.add(today);
      data.sort();
      await prefs.setStringList(_key, data);
    }
  }

  /// Hitung streak berturut-turut
  static Future<int> getStreak() async {
    final data = await getRiwayat();
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
}
