// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginSubtitle =>
      'registra tus días, crea tu propio calendario de estado de ánimo';

  @override
  String get loginWithGoogle => 'iniciar sesión con Google';

  @override
  String hiUser(String name) {
    return 'hola, $name!';
  }

  @override
  String get moodOverview => 'aquí está tu resumen de estado de ánimo';

  @override
  String get today => 'hoy';

  @override
  String get noMoodToday => 'no agregaste tu estado de ánimo hoy';

  @override
  String get addMood => 'agregar estado de ánimo';

  @override
  String get editMood => 'editar estado de ánimo';

  @override
  String get settings => 'configuración';

  @override
  String get signOut => 'cerrar sesión';

  @override
  String get areYouSure => '¿estás seguro?';

  @override
  String get areYouSureReauth =>
      '¿estás seguro? tendrás que iniciar sesión de nuevo para confirmar';

  @override
  String get cancel => 'cancelar';

  @override
  String get theme => 'tema';

  @override
  String get light => 'claro';

  @override
  String get dark => 'oscuro';

  @override
  String get language => 'idioma';

  @override
  String get changeLanguage => 'cambiar idioma';

  @override
  String get english => 'inglés';

  @override
  String get portuguese => 'portugués';

  @override
  String get french => 'francés';

  @override
  String get german => 'alemán';

  @override
  String get spanish => 'español';

  @override
  String loggedAs(String email) {
    return 'conectado como $email';
  }

  @override
  String get averageMood => 'estado de ánimo promedio';

  @override
  String get howAreYouFeelingToday => '¿cómo te sientes hoy?';

  @override
  String get howDidYouFeelThatDay => '¿cómo te sentiste ese día?';

  @override
  String get writeNotes => 'escribe algo sobre ello... (opcional)';

  @override
  String get saveChanges => 'guardar cambios';

  @override
  String get saveMood => 'guardar estado de ánimo';

  @override
  String get deleteMood => 'eliminar estado de ánimo';

  @override
  String get monthJanuary => 'enero';

  @override
  String get monthFebruary => 'febrero';

  @override
  String get monthMarch => 'marzo';

  @override
  String get monthApril => 'abril';

  @override
  String get monthMay => 'mayo';

  @override
  String get monthJune => 'junio';

  @override
  String get monthJuly => 'julio';

  @override
  String get monthAugust => 'agosto';

  @override
  String get monthSeptember => 'septiembre';

  @override
  String get monthOctober => 'octubre';

  @override
  String get monthNovember => 'noviembre';

  @override
  String get monthDecember => 'diciembre';

  @override
  String get weekdayMonday => 'lunes';

  @override
  String get weekdayTuesday => 'martes';

  @override
  String get weekdayWednesday => 'miércoles';

  @override
  String get weekdayThursday => 'jueves';

  @override
  String get weekdayFriday => 'viernes';

  @override
  String get weekdaySaturday => 'sábado';

  @override
  String get weekdaySunday => 'domingo';

  @override
  String formatDayHeader(String weekday, String month, int day) {
    return '$weekday, $day de $month';
  }

  @override
  String formatDateLabel(String month, int day, int year) {
    return '$day de $month de $year';
  }

  @override
  String get addedOn => 'agregado el:';

  @override
  String get dangerZone => 'zona de peligro';

  @override
  String get deleteAllMoods => 'eliminar todos los estados de ánimo';

  @override
  String get deleteAllMoodsDescription =>
      'esto eliminará permanentemente todos tus registros de estado de ánimo. esta acción no se puede deshacer.';

  @override
  String get deleteAccount => 'eliminar cuenta';

  @override
  String get deleteAccountDescription =>
      'esto eliminará permanentemente todos tus estados de ánimo y tu cuenta. esta acción no se puede deshacer.';

  @override
  String formatDateTime(String month, int day, int year, String time) {
    return '$day de $month de $year a las $time';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'agregado el $day de $month de $year a las $time';
  }
}
