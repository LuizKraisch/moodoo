// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get loginSubtitle =>
      'verfolge deine tage, erstelle deinen eigenen stimmungskalender';

  @override
  String get loginWithGoogle => 'mit google anmelden';

  @override
  String hiUser(String name) {
    return 'hallo, $name!';
  }

  @override
  String get moodOverview => 'hier ist deine stimmungsübersicht';

  @override
  String get today => 'heute';

  @override
  String get noMoodToday => 'du hast deine stimmung heute nicht hinzugefügt';

  @override
  String get addMood => 'stimmung hinzufügen';

  @override
  String get editMood => 'stimmung bearbeiten';

  @override
  String get settings => 'einstellungen';

  @override
  String get signOut => 'abmelden';

  @override
  String get areYouSure => 'bist du sicher?';

  @override
  String get areYouSureReauth =>
      'bist du sicher? du wirst gebeten, dich zur bestätigung erneut anzumelden';

  @override
  String get cancel => 'abbrechen';

  @override
  String get theme => 'thema';

  @override
  String get light => 'hell';

  @override
  String get dark => 'dunkel';

  @override
  String get language => 'sprache';

  @override
  String get changeLanguage => 'sprache ändern';

  @override
  String get english => 'englisch';

  @override
  String get portuguese => 'portugiesisch';

  @override
  String get french => 'französisch';

  @override
  String get german => 'deutsch';

  @override
  String get spanish => 'spanisch';

  @override
  String loggedAs(String email) {
    return 'angemeldet als $email';
  }

  @override
  String get averageMood => 'durchschnittliche stimmung';

  @override
  String get howAreYouFeelingToday => 'wie fühlst du dich heute?';

  @override
  String get howDidYouFeelThatDay => 'wie hast du dich an diesem tag gefühlt?';

  @override
  String get writeNotes => 'schreibe etwas darüber... (optional)';

  @override
  String get saveChanges => 'änderungen speichern';

  @override
  String get saveMood => 'stimmung speichern';

  @override
  String get deleteMood => 'stimmung löschen';

  @override
  String get monthJanuary => 'januar';

  @override
  String get monthFebruary => 'februar';

  @override
  String get monthMarch => 'märz';

  @override
  String get monthApril => 'april';

  @override
  String get monthMay => 'mai';

  @override
  String get monthJune => 'juni';

  @override
  String get monthJuly => 'juli';

  @override
  String get monthAugust => 'august';

  @override
  String get monthSeptember => 'september';

  @override
  String get monthOctober => 'oktober';

  @override
  String get monthNovember => 'november';

  @override
  String get monthDecember => 'dezember';

  @override
  String get weekdayMonday => 'montag';

  @override
  String get weekdayTuesday => 'dienstag';

  @override
  String get weekdayWednesday => 'mittwoch';

  @override
  String get weekdayThursday => 'donnerstag';

  @override
  String get weekdayFriday => 'freitag';

  @override
  String get weekdaySaturday => 'samstag';

  @override
  String get weekdaySunday => 'sonntag';

  @override
  String formatDayHeader(String weekday, String month, int day) {
    return '$weekday, $day. $month';
  }

  @override
  String formatDateLabel(String month, int day, int year) {
    return '$day. $month $year';
  }

  @override
  String get addedOn => 'hinzugefügt am:';

  @override
  String get dangerZone => 'gefahrenzone';

  @override
  String get deleteAllMoods => 'alle stimmungen löschen';

  @override
  String get deleteAllMoodsDescription =>
      'dies löscht dauerhaft alle deine stimmungseinträge. diese aktion kann nicht rückgängig gemacht werden.';

  @override
  String get deleteAccount => 'konto löschen';

  @override
  String get deleteAccountDescription =>
      'dies löscht dauerhaft alle deine stimmungen und dein konto. diese aktion kann nicht rückgängig gemacht werden.';

  @override
  String formatDateTime(String month, int day, int year, String time) {
    return '$day. $month $year um $time';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'hinzugefügt am $day. $month $year um $time';
  }
}
