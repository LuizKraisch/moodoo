import 'package:moodoo/models/mood.dart';

class MonthSummary {
  final int month;
  final int year;
  final String? averageScore;
  final List<Mood> moods;

  const MonthSummary({
    required this.month,
    required this.year,
    required this.averageScore,
    required this.moods,
  });
}

class MoodService {
  static const _monthNames = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  static const _weekdayNames = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  static const _gradeToValue = {'S': 5, 'A': 4, 'B': 3, 'C': 2, 'D': 1, 'F': 0};
  static const _valueToGrade = {5: 'S', 4: 'A', 3: 'B', 2: 'C', 1: 'D', 0: 'F'};

  static String? averageGrade(List<Mood> moods) {
    if (moods.isEmpty) return null;
    final values = moods
        .map((m) => _gradeToValue[m.score])
        .whereType<int>()
        .toList();
    if (values.isEmpty) return null;
    final avg = values.reduce((a, b) => a + b) / values.length;
    return _valueToGrade[avg.round()];
  }

  static List<MonthSummary> buildMonthSummaries(List<Mood> moods, int year) {
    return List.generate(12, (i) {
      final month = i + 1;
      final monthMoods = moods.where((m) {
        final d = m.day.toDate();
        return d.year == year && d.month == month;
      }).toList()..sort((a, b) => a.day.compareTo(b.day));
      return MonthSummary(
        month: month,
        year: year,
        averageScore: averageGrade(monthMoods),
        moods: monthMoods,
      );
    });
  }

  static String monthName(int month) => _monthNames[month - 1];

  static String weekdayName(int weekday) => _weekdayNames[weekday - 1];

  static String formatDayHeader(DateTime date) =>
      '${weekdayName(date.weekday)}, ${monthName(date.month)} ${date.day}';

  static String formatDateLabel(DateTime date) =>
      '${monthName(date.month)} ${date.day}, ${date.year}';

  static String formatCreatedAt(DateTime datetime) {
    final hour = datetime.hour % 12 == 0 ? 12 : datetime.hour % 12;
    final ampm = datetime.hour >= 12 ? 'PM' : 'AM';
    final minute = datetime.minute.toString().padLeft(2, '0');
    return 'added on ${monthName(datetime.month)} ${datetime.day}, ${datetime.year} at $hour:$minute $ampm';
  }
}
