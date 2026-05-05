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
  String get moodOverview => 'aquí está tu resumen';

  @override
  String get today => 'hoy';

  @override
  String get noMoodToday => 'sin mood hoy';

  @override
  String get addMood => 'agregar mood';

  @override
  String get editMood => 'editar mood';

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

  @override
  String get ok => 'ok';

  @override
  String get errorTitle => '¡vaya!';

  @override
  String get errorRecentLogin =>
      'por favor, inicia sesión de nuevo antes de realizar este cambio.';

  @override
  String get errorNetworkFailed =>
      'sin conexión a internet. por favor, inténtalo de nuevo.';

  @override
  String get errorTooManyRequests =>
      'demasiados intentos. por favor, inténtalo más tarde.';

  @override
  String get errorUserNotFound => 'cuenta no encontrada.';

  @override
  String get errorUserDisabled => 'esta cuenta ha sido desactivada.';

  @override
  String get errorInvalidCredential =>
      'autenticación fallida. por favor, inicia sesión de nuevo.';

  @override
  String get errorSignInCancelled => 'se canceló el inicio de sesión.';

  @override
  String get errorPermissionDenied => 'no tienes permiso para hacer esto.';

  @override
  String get errorServiceUnavailable =>
      'servicio no disponible. comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get errorNotFound => 'no se encontraron los datos solicitados.';

  @override
  String get errorDeadlineExceeded =>
      'la solicitud ha caducado. por favor, inténtalo de nuevo.';

  @override
  String get errorResourceExhausted =>
      'demasiadas solicitudes. por favor, inténtalo más tarde.';

  @override
  String get errorGeneric => 'algo salió mal. por favor, inténtalo de nuevo.';
}
