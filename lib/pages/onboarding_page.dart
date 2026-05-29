import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/preferences/onboarding_preferences.dart';
import 'package:moodoo/services/api_service.dart';
import 'package:moodoo/theme/app_theme.dart' show darkTheme;
import 'package:moodoo/widgets/shared/moodoo_button.dart';
import 'package:moodoo/widgets/shared/moodoo_modal.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';
import 'package:moodoo/widgets/shared/reminder_settings_section.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _currentPage = 0;

  List<_PageData> _buildPages(AppLocalizations l10n, String imageSuffix) => [
    _PageData(
      imagePath: 'assets/images/onboarding-page-one-$imageSuffix.svg',
      title: l10n.onboardingPage1Title,
      description: l10n.onboardingPage1Description,
    ),
    _PageData(
      imagePath: 'assets/images/onboarding-page-two-$imageSuffix.svg',
      title: l10n.onboardingPage2Title,
      description: l10n.onboardingPage2Description,
    ),
    _PageData(
      imagePath: 'assets/images/onboarding-page-three-$imageSuffix.svg',
      title: l10n.onboardingPage3Title,
      description: l10n.onboardingPage3Description,
    ),
  ];

  Future<void> _finish() async {
    await saveOnboardingFinished();
    ApiService().updateAccount(onboardingCompleted: true).catchError((_) {});
  }

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final imageSuffix = locale.languageCode == 'pt' ? 'pt' : 'en';
    final pages = _buildPages(l10n, imageSuffix);
    final isFirst = _currentPage == 0;
    final isLast = _currentPage == pages.length - 1;
    final scheme = darkTheme.colorScheme;

    return Theme(
      data: darkTheme,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) =>
                      _OnboardingSlide(data: pages[index]),
                ),
              ),
              _DotsIndicator(
                count: pages.length,
                current: _currentPage,
                activeColor: scheme.onPrimary,
                inactiveColor: scheme.primary,
              ),
              const SizedBox(height: 24),
              ClipRect(
                child: AnimatedAlign(
                  alignment: Alignment.bottomCenter,
                  heightFactor: isLast ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    child: MoodooButton(
                      text: l10n.configureNow,
                      onTap: () => showMoodooModal<void>(
                        context,
                        title: l10n.notifications,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 40),
                          child: const ReminderSettingsSection(),
                        ),
                      ),
                      backgroundColor: scheme.onPrimary,
                      foregroundColor: scheme.onSurface,
                      bouncePeakScale: 1.08,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: isFirst
                          ? MoodooButton(
                              text: l10n.skip,
                              onTap: _finish,
                              bouncePeakScale: 1.08,
                            )
                          : MoodooButton(
                              text: l10n.back,
                              onTap: _back,
                              bouncePeakScale: 1.08,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: isLast
                          ? MoodooButton(
                              text: l10n.done,
                              onTap: _finish,
                              bouncePeakScale: 1.08,
                              backgroundColor: scheme.onPrimary,
                              foregroundColor: scheme.onSurface,
                            )
                          : MoodooButton(
                              text: l10n.next,
                              onTap: _next,
                              bouncePeakScale: 1.08,
                              backgroundColor: scheme.onPrimary,
                              foregroundColor: scheme.onSurface,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.data});

  final _PageData data;

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 90, 30, 0),
                child: SvgPicture.asset(data.imagePath, fit: BoxFit.contain),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [bgColor, bgColor.withValues(alpha: 0)],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [bgColor, bgColor.withValues(alpha: 0)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoodooText(data.title, variant: MoodooTextVariant.displayLarge),
              const SizedBox(height: 10),
              MoodooText(
                data.description,
                variant: MoodooTextVariant.headlineSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
    required this.count,
    required this.current,
    required this.activeColor,
    required this.inactiveColor,
  });

  final int count;
  final int current;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _PageData {
  const _PageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;
}
