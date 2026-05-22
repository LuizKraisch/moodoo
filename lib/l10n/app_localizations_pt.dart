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
  String get loginWithApple => 'continuar com Apple';

  @override
  String hiUser(String name) {
    return 'oi, $name!';
  }

  @override
  String get moodOverview => 'aqui está o seu resumo';

  @override
  String get today => 'hoje';

  @override
  String get noMoodToday => 'sem mood hoje';

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
  String get areYouSureReauth =>
      'tem certeza? você precisará entrar novamente para confirmar';

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
  String get averageMood => 'média';

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
  String get dangerZone => 'zona de perigo';

  @override
  String get deleteAllMoods => 'excluir todos os moods';

  @override
  String get deleteAllMoodsDescription =>
      'isso excluirá permanentemente todos os seus registros de humor. esta ação não pode ser desfeita.';

  @override
  String get deleteAccount => 'excluir conta';

  @override
  String get deleteAccountDescription =>
      'isso excluirá permanentemente todos os seus moods e sua conta. esta ação não pode ser desfeita.';

  @override
  String formatDateTime(String month, int day, int year, String time) {
    return '$day de $month de $year às $time';
  }

  @override
  String formatCreatedAt(String month, int day, int year, String time) {
    return 'adicionado em $day de $month de $year às $time';
  }

  @override
  String get ok => 'ok';

  @override
  String get errorTitle => 'ops!';

  @override
  String get errorRecentLogin =>
      'por favor, entre novamente antes de fazer esta alteração.';

  @override
  String get errorNetworkFailed =>
      'sem conexão com a internet. tente novamente.';

  @override
  String get errorTooManyRequests =>
      'muitas tentativas. tente novamente mais tarde.';

  @override
  String get errorUserNotFound => 'conta não encontrada.';

  @override
  String get errorUserDisabled => 'esta conta foi desativada.';

  @override
  String get errorInvalidCredential => 'autenticação falhou. entre novamente.';

  @override
  String get errorSignInCancelled => 'o login foi cancelado.';

  @override
  String get errorPermissionDenied => 'você não tem permissão para fazer isso.';

  @override
  String get errorServiceUnavailable =>
      'serviço indisponível. verifique sua conexão e tente novamente.';

  @override
  String get errorNotFound => 'os dados solicitados não foram encontrados.';

  @override
  String get errorDeadlineExceeded =>
      'o tempo da solicitação expirou. tente novamente.';

  @override
  String get errorResourceExhausted =>
      'muitas solicitações. tente novamente mais tarde.';

  @override
  String get errorGeneric => 'algo deu errado. tente novamente.';

  @override
  String get notifications => 'notificações';

  @override
  String get dailyReminder => 'lembrete diário';

  @override
  String get reminderTime => 'horário do lembrete';

  @override
  String get notificationTitle => 'lembrete de mood';

  @override
  String get notificationBody => 'lembre-se de registrar seu mood do dia';

  @override
  String get notificationDescription =>
      'você receberá uma notificação todos os dias no horário selecionado para lembrar de registrar seu mood.';

  @override
  String get skip => 'pular';

  @override
  String get back => 'voltar';

  @override
  String get next => 'próximo';

  @override
  String get done => 'feito';

  @override
  String get onboardingPage1Title => 'boas-vindas ao moodoo';

  @override
  String get onboardingPage1Description =>
      'avalie seus dias de S a F e adicione notas para capturar os momentos que moldaram como você se sentiu.';

  @override
  String get onboardingPage2Title => 'crie seu próprio calendário de moods';

  @override
  String get onboardingPage2Description =>
      'veja o calendário para acompanhar todos os seus moods por mês e dia.';

  @override
  String get onboardingPage3Title =>
      'ative o lembrete e nunca esqueça de registrar seu mood';

  @override
  String get onboardingPage3Description =>
      'nas configurações você pode facilmente configurar um lembrete diário para registrar seu mood e manter seu calendário sempre atualizado.';

  @override
  String get legal => 'legal';

  @override
  String get privacyPolicy => 'política de privacidade';

  @override
  String get externalPrivacyPolicy => 'ver online';

  @override
  String get support => 'suporte';

  @override
  String get getSupport => 'obter suporte';
}
