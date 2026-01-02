import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Set<String> riwayatBelajar = {};

  @override
  void initState() {
    super.initState();
    loadRiwayat();
  }

  Future<void> loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('riwayatBelajar') ?? [];
    setState(() {
      riwayatBelajar = data.toSet();
    });
  }

  Future<void> tandaiHariIni() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    riwayatBelajar.add(today);
    await prefs.setStringList('riwayatBelajar', riwayatBelajar.toList());

    setState(() {});
  }

  bool isLearned(DateTime day) {
    final key = day.toIso8601String().substring(0, 10);
    return riwayatBelajar.contains(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender Belajar'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'id_ID',
            firstDay: DateTime.utc(2022),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) =>
                isSameDay(_selectedDay, day),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },

            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (isLearned(day)) {
                  return const Positioned(
                    bottom: 4,
                    child: Icon(Icons.local_fire_department,
                        color: Colors.orange, size: 16),
                  );
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: tandaiHariIni,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Tandai Belajar Hari Ini'),
          ),
        ],
      ),
    );
  }
}
