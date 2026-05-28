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
  String get loginWithApple => 'continue with Apple';

  @override
  String hiUser(String name) {
    return 'hi, $name!';
  }

  @override
  String get moodOverview => 'here\'s your mood overview';

  @override
  String get today => 'today';

  @override
  String get noMoodToday => 'no mood today';

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
  String get areYouSureReauth =>
      'are you sure? you\'ll be asked to sign in again to confirm';

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
  String get changeLanguage => 'change language';

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
  String get averageMood => 'average';

  @override
  String get howAreYouFeelingToday => 'how are you feeling today?';

  @override
  String get howDidYouFeelThatDay => 'how did you feel that day?';

  @override
  String get addPhoto => 'add photo';

  @override
  String get takePhoto => 'take photo';

  @override
  String get chooseFromGallery => 'choose from gallery';

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
  String get addedOn => 'added on:';

  @override
  String get dangerZone => 'danger zone';

  @override
  String get deleteAllMoods => 'delete all moods';

  @override
  String get deleteAllMoodsDescription =>
      'this will permanently delete all your mood entries. this action cannot be undone.';

  @override
  String get deleteAccount => 'delete account';

  @override
  String get deleteAccountDescription =>
      'this will permanently delete all your moods and your account. this action cannot be undone.';

  @override
  String formatDateTime(String month, int day, int year, String time) {
    return '$month $day, $year at $time';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'added on $month $day, $year at $time';
  }

  @override
  String get ok => 'ok';

  @override
  String get errorTitle => 'oops!';

  @override
  String get errorRecentLogin =>
      'please sign in again before making this change.';

  @override
  String get errorNetworkFailed => 'no internet connection. please try again.';

  @override
  String get errorTooManyRequests =>
      'too many attempts. please try again later.';

  @override
  String get errorUserNotFound => 'account not found.';

  @override
  String get errorUserDisabled => 'this account has been disabled.';

  @override
  String get errorInvalidCredential =>
      'authentication failed. please sign in again.';

  @override
  String get errorSignInCancelled => 'sign-in was cancelled.';

  @override
  String get errorPermissionDenied => 'you don\'t have permission to do this.';

  @override
  String get errorServiceUnavailable =>
      'service unavailable. check your connection and try again.';

  @override
  String get errorNotFound => 'the requested data was not found.';

  @override
  String get errorDeadlineExceeded =>
      'the request timed out. please try again.';

  @override
  String get errorResourceExhausted =>
      'too many requests. please try again later.';

  @override
  String get errorGeneric => 'something went wrong. please try again.';

  @override
  String get errorInvalidImageFormat =>
      'invalid image format, please try again.';

  @override
  String get notifications => 'notifications';

  @override
  String get dailyReminder => 'daily reminder';

  @override
  String get reminderTime => 'reminder time';

  @override
  String get notificationTitle => 'mood reminder';

  @override
  String get notificationBody => 'remember to add your mood for the day';

  @override
  String get notificationDescription =>
      'you\'ll receive a push notification everyday at the selected time to remind you to log your mood.';

  @override
  String get skip => 'skip';

  @override
  String get back => 'back';

  @override
  String get next => 'next';

  @override
  String get done => 'done';

  @override
  String get onboardingPage1Title => 'welcome to moodoo';

  @override
  String get onboardingPage1Description =>
      'rate your days from S to F and add notes to capture the moments that shaped how you felt.';

  @override
  String get onboardingPage2Title => 'build your own mood calendar';

  @override
  String get onboardingPage2Description =>
      'check the calendar to see all your moods per month and day.';

  @override
  String get onboardingPage3Title =>
      'activate the reminder and never forget to log your mood';

  @override
  String get onboardingPage3Description =>
      'in settings you can easily set up a daily reminder to log your mood and keep your mood calendar up to date.';

  @override
  String get legal => 'legal';

  @override
  String get privacyPolicy => 'privacy policy';

  @override
  String get externalPrivacyPolicy => 'view online';

  @override
  String get support => 'support';

  @override
  String get getSupport => 'get support';
}
