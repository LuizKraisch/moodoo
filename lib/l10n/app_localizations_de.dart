// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get loginSubtitle =>
      'verfolge deine Tage, erstelle deinen eigenen Stimmungskalender';

  @override
  String get loginWithGoogle => 'mit Google anmelden';

  @override
  String hiUser(String name) {
    return 'hallo, $name!';
  }

  @override
  String get moodOverview => 'hier ist deine Stimmungsübersicht';

  @override
  String get today => 'heute';

  @override
  String get noMoodToday => 'du hast deine Stimmung heute nicht hinzugefügt';

  @override
  String get addMood => 'Stimmung hinzufügen';

  @override
  String get editMood => 'Stimmung bearbeiten';

  @override
  String get settings => 'Einstellungen';

  @override
  String get signOut => 'abmelden';

  @override
  String get areYouSure => 'bist du sicher?';

  @override
  String get cancel => 'abbrechen';

  @override
  String get theme => 'Thema';

  @override
  String get light => 'hell';

  @override
  String get dark => 'dunkel';

  @override
  String get language => 'Sprache';

  @override
  String get english => 'Englisch';

  @override
  String get portuguese => 'Portugiesisch';

  @override
  String get french => 'Französisch';

  @override
  String get german => 'Deutsch';

  @override
  String get spanish => 'Spanisch';

  @override
  String loggedAs(String email) {
    return 'angemeldet als $email';
  }

  @override
  String get averageMood => 'durchschnittliche Stimmung';

  @override
  String get howAreYouFeelingToday => 'wie fühlst du dich heute?';

  @override
  String get howDidYouFeelThatDay => 'wie hast du dich an diesem Tag gefühlt?';

  @override
  String get writeNotes => 'schreibe etwas darüber... (optional)';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get saveMood => 'Stimmung speichern';

  @override
  String get deleteMood => 'Stimmung löschen';

  @override
  String get monthJanuary => 'Januar';

  @override
  String get monthFebruary => 'Februar';

  @override
  String get monthMarch => 'März';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJune => 'Juni';

  @override
  String get monthJuly => 'Juli';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'Oktober';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'Dezember';

  @override
  String get weekdayMonday => 'Montag';

  @override
  String get weekdayTuesday => 'Dienstag';

  @override
  String get weekdayWednesday => 'Mittwoch';

  @override
  String get weekdayThursday => 'Donnerstag';

  @override
  String get weekdayFriday => 'Freitag';

  @override
  String get weekdaySaturday => 'Samstag';

  @override
  String get weekdaySunday => 'Sonntag';

  @override
  String formatDayHeader(String weekday, String month, int day) {
    return '$weekday, $day. $month';
  }

  @override
  String formatDateLabel(String month, int day, int year) {
    return '$day. $month $year';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'hinzugefügt am $day. $month $year um $time';
  }
}
