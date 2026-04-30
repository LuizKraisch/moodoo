// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get loginSubtitle =>
      'registre seus dias, crie seu próprio calendário de moods';

  @override
  String get loginWithGoogle => 'entrar com Google';

  @override
  String hiUser(String name) {
    return 'oi, $name!';
  }

  @override
  String get moodOverview => 'aqui está o seu resumo';

  @override
  String get today => 'hoje';

  @override
  String get noMoodToday => 'você não registrou seu mood hoje';

  @override
  String get addMood => 'registrar mood';

  @override
  String get editMood => 'editar mood';

  @override
  String get settings => 'configurações';

  @override
  String get signOut => 'sair';

  @override
  String get areYouSure => 'tem certeza?';

  @override
  String get cancel => 'cancelar';

  @override
  String get theme => 'tema';

  @override
  String get light => 'claro';

  @override
  String get dark => 'escuro';

  @override
  String get language => 'idioma';

  @override
  String get changeLanguage => 'alterar idioma';

  @override
  String get english => 'inglês';

  @override
  String get portuguese => 'português';

  @override
  String get french => 'francês';

  @override
  String get german => 'alemão';

  @override
  String get spanish => 'espanhol';

  @override
  String loggedAs(String email) {
    return 'conectado como $email';
  }

  @override
  String get averageMood => 'média do mês';

  @override
  String get howAreYouFeelingToday => 'como você está se sentindo hoje?';

  @override
  String get howDidYouFeelThatDay => 'como você se sentiu neste dia?';

  @override
  String get writeNotes => 'escreva algo sobre... (opcional)';

  @override
  String get saveChanges => 'salvar alterações';

  @override
  String get saveMood => 'salvar mood';

  @override
  String get deleteMood => 'excluir mood';

  @override
  String get monthJanuary => 'janeiro';

  @override
  String get monthFebruary => 'fevereiro';

  @override
  String get monthMarch => 'março';

  @override
  String get monthApril => 'abril';

  @override
  String get monthMay => 'maio';

  @override
  String get monthJune => 'junho';

  @override
  String get monthJuly => 'julho';

  @override
  String get monthAugust => 'agosto';

  @override
  String get monthSeptember => 'setembro';

  @override
  String get monthOctober => 'outubro';

  @override
  String get monthNovember => 'novembro';

  @override
  String get monthDecember => 'dezembro';

  @override
  String get weekdayMonday => 'segunda-feira';

  @override
  String get weekdayTuesday => 'terça-feira';

  @override
  String get weekdayWednesday => 'quarta-feira';

  @override
  String get weekdayThursday => 'quinta-feira';

  @override
  String get weekdayFriday => 'sexta-feira';

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
  String get addedOn => 'adicionado em:';

  @override
  String formatDateTime(String month, int day, int year, String time) {
    return '$day de $month de $year às $time';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'adicionado em $day de $month de $year às $time';
  }
}
