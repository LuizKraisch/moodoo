// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get loginSubtitle =>
      'suivez vos jours, créez votre propre calendrier d\'humeur';

  @override
  String get loginWithGoogle => 'se connecter avec Google';

  @override
  String hiUser(String name) {
    return 'salut, $name!';
  }

  @override
  String get moodOverview => 'voici votre aperçu d\'humeur';

  @override
  String get today => 'aujourd\'hui';

  @override
  String get noMoodToday => 'vous n\'avez pas ajouté votre humeur aujourd\'hui';

  @override
  String get addMood => 'ajouter humeur';

  @override
  String get editMood => 'modifier humeur';

  @override
  String get settings => 'paramètres';

  @override
  String get signOut => 'se déconnecter';

  @override
  String get areYouSure => 'êtes-vous sûr?';

  @override
  String get cancel => 'annuler';

  @override
  String get theme => 'thème';

  @override
  String get light => 'clair';

  @override
  String get dark => 'sombre';

  @override
  String get language => 'langue';

  @override
  String get english => 'anglais';

  @override
  String get portuguese => 'portugais';

  @override
  String get french => 'français';

  @override
  String get german => 'allemand';

  @override
  String get spanish => 'espagnol';

  @override
  String loggedAs(String email) {
    return 'connecté en tant que $email';
  }

  @override
  String get averageMood => 'humeur moyenne';

  @override
  String get howAreYouFeelingToday => 'comment vous sentez-vous aujourd\'hui?';

  @override
  String get howDidYouFeelThatDay => 'comment vous sentiez-vous ce jour-là?';

  @override
  String get writeNotes => 'écrivez quelque chose... (optionnel)';

  @override
  String get saveChanges => 'sauvegarder les modifications';

  @override
  String get saveMood => 'sauvegarder l\'humeur';

  @override
  String get deleteMood => 'supprimer l\'humeur';

  @override
  String get monthJanuary => 'janvier';

  @override
  String get monthFebruary => 'février';

  @override
  String get monthMarch => 'mars';

  @override
  String get monthApril => 'avril';

  @override
  String get monthMay => 'mai';

  @override
  String get monthJune => 'juin';

  @override
  String get monthJuly => 'juillet';

  @override
  String get monthAugust => 'août';

  @override
  String get monthSeptember => 'septembre';

  @override
  String get monthOctober => 'octobre';

  @override
  String get monthNovember => 'novembre';

  @override
  String get monthDecember => 'décembre';

  @override
  String get weekdayMonday => 'lundi';

  @override
  String get weekdayTuesday => 'mardi';

  @override
  String get weekdayWednesday => 'mercredi';

  @override
  String get weekdayThursday => 'jeudi';

  @override
  String get weekdayFriday => 'vendredi';

  @override
  String get weekdaySaturday => 'samedi';

  @override
  String get weekdaySunday => 'dimanche';

  @override
  String formatDayHeader(String weekday, String month, int day) {
    return '$weekday, $day $month';
  }

  @override
  String formatDateLabel(String month, int day, int year) {
    return '$day $month $year';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'ajouté le $day $month $year à $time';
  }
}
