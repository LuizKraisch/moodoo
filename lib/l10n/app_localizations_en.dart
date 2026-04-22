// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginSubtitle => 'track your days, create your own mood calendar';

  @override
  String get loginWithGoogle => 'log in with Google';

  @override
  String hiUser(String name) {
    return 'hi, $name!';
  }

  @override
  String get moodOverview => 'here\'s your mood overview';

  @override
  String get today => 'today';

  @override
  String get noMoodToday => 'you didn\'t add your mood for today';

  @override
  String get addMood => 'add mood';

  @override
  String get editMood => 'edit mood';

  @override
  String get settings => 'settings';

  @override
  String get signOut => 'sign out';

  @override
  String get areYouSure => 'are you sure?';

  @override
  String get cancel => 'cancel';

  @override
  String get theme => 'theme';

  @override
  String get light => 'light';

  @override
  String get dark => 'dark';

  @override
  String get language => 'language';

  @override
  String get english => 'english';

  @override
  String get portuguese => 'portuguese';

  @override
  String get french => 'french';

  @override
  String get german => 'german';

  @override
  String get spanish => 'spanish';

  @override
  String loggedAs(String email) {
    return 'logged in as $email';
  }

  @override
  String get averageMood => 'average mood';

  @override
  String get howAreYouFeelingToday => 'how are you feeling today?';

  @override
  String get howDidYouFeelThatDay => 'how did you feel that day?';

  @override
  String get writeNotes => 'write something about it... (optional)';

  @override
  String get saveChanges => 'save changes';

  @override
  String get saveMood => 'save mood';

  @override
  String get deleteMood => 'delete mood';

  @override
  String get monthJanuary => 'january';

  @override
  String get monthFebruary => 'february';

  @override
  String get monthMarch => 'march';

  @override
  String get monthApril => 'april';

  @override
  String get monthMay => 'may';

  @override
  String get monthJune => 'june';

  @override
  String get monthJuly => 'july';

  @override
  String get monthAugust => 'august';

  @override
  String get monthSeptember => 'september';

  @override
  String get monthOctober => 'october';

  @override
  String get monthNovember => 'november';

  @override
  String get monthDecember => 'december';

  @override
  String get weekdayMonday => 'monday';

  @override
  String get weekdayTuesday => 'tuesday';

  @override
  String get weekdayWednesday => 'wednesday';

  @override
  String get weekdayThursday => 'thursday';

  @override
  String get weekdayFriday => 'friday';

  @override
  String get weekdaySaturday => 'saturday';

  @override
  String get weekdaySunday => 'sunday';

  @override
  String formatDayHeader(String weekday, String month, int day) {
    return '$weekday, $month $day';
  }

  @override
  String formatDateLabel(String month, int day, int year) {
    return '$month $day, $year';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'added on $month $day, $year at $time';
  }
}
