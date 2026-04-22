import 'package:moodoo/l10n/app_localizations.dart';
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

  static String monthName(AppLocalizations l10n, int month) {
    const names = [
      'january', 'february', 'march', 'april', 'may', 'june',
      'july', 'august', 'september', 'october', 'november', 'december',
    ];
    final key = names[month - 1];
    return _monthByKey(l10n, key);
  }

  static String weekdayName(AppLocalizations l10n, int weekday) {
    const names = [
      'monday', 'tuesday', 'wednesday', 'thursday',
      'friday', 'saturday', 'sunday',
    ];
    final key = names[weekday - 1];
    return _weekdayByKey(l10n, key);
  }

  static String formatDayHeader(AppLocalizations l10n, DateTime date) =>
      l10n.formatDayHeader(
        weekdayName(l10n, date.weekday),
        monthName(l10n, date.month),
        date.day,
      );

  static String formatDateLabel(AppLocalizations l10n, DateTime date) =>
      l10n.formatDateLabel(
        monthName(l10n, date.month),
        date.day,
        date.year,
      );

  static String formatCreatedAt(AppLocalizations l10n, DateTime datetime) {
    final hour = datetime.hour % 12 == 0 ? 12 : datetime.hour % 12;
    final ampm = datetime.hour >= 12 ? 'PM' : 'AM';
    final minute = datetime.minute.toString().padLeft(2, '0');
    return l10n.formatCreatedAt(
      monthName(l10n, datetime.month),
      datetime.day,
      datetime.year,
      '$hour:$minute $ampm',
    );
  }

  static String _monthByKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'january': return l10n.monthJanuary;
      case 'february': return l10n.monthFebruary;
      case 'march': return l10n.monthMarch;
      case 'april': return l10n.monthApril;
      case 'may': return l10n.monthMay;
      case 'june': return l10n.monthJune;
      case 'july': return l10n.monthJuly;
      case 'august': return l10n.monthAugust;
      case 'september': return l10n.monthSeptember;
      case 'october': return l10n.monthOctober;
      case 'november': return l10n.monthNovember;
      default: return l10n.monthDecember;
    }
  }

  static String _weekdayByKey(AppLocalizations l10n, String key) {
    switch (key) {
      case 'monday': return l10n.weekdayMonday;
      case 'tuesday': return l10n.weekdayTuesday;
      case 'wednesday': return l10n.weekdayWednesday;
      case 'thursday': return l10n.weekdayThursday;
      case 'friday': return l10n.weekdayFriday;
      case 'saturday': return l10n.weekdaySaturday;
      default: return l10n.weekdaySunday;
    }
  }
}
