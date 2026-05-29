import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/widgets/headers/moodoo_header.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          const SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 140), _TermsOfUseContent()],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MoodooHeader(title: l10n.termsOfUse),
          ),
        ],
      ),
    );
  }
}

class _TermsOfUseContent extends StatelessWidget {
  const _TermsOfUseContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          title: 'Last updated: May 29, 2025',
          body:
              'Please read these Terms of Use ("Terms") carefully before using the Moodoo app operated by LoeSoft ("we", "us", "our"). By accessing or using the app, you agree to be bound by these Terms.',
        ),
        _Section(
          title: 'Acceptance of Terms',
          body:
              'By creating an account or using Moodoo, you confirm that you are at least 13 years old and agree to these Terms and our Privacy Policy. If you do not agree, please do not use the app.',
        ),
        _Section(
          title: 'Use of the App',
          body:
              'Moodoo is a personal mood tracking application. You may use the app solely for personal, non-commercial purposes. You agree not to:\n\n'
              '• Use the app for any unlawful purpose.\n\n'
              '• Attempt to gain unauthorized access to any part of the app or its servers.\n\n'
              '• Reverse engineer, decompile, or disassemble any part of the app.\n\n'
              '• Interfere with or disrupt the app\'s functionality or connected services.',
        ),
        _Section(
          title: 'User Accounts',
          body:
              'You are responsible for maintaining the confidentiality of your account credentials. You are responsible for all activity that occurs under your account. Notify us immediately at loesoft.support@gmail.com if you suspect unauthorized use of your account.',
        ),
        _Section(
          title: 'User Content',
          body:
              'You retain ownership of any content you enter in the app, such as mood entries and notes. By using the app, you grant LoeSoft a limited license to store and process your content solely to provide the service. We do not use your personal mood data for advertising or share it with third parties.',
        ),
        _Section(
          title: 'Privacy',
          body:
              'Your use of the app is also governed by our Privacy Policy, which is incorporated into these Terms by reference. Please review our Privacy Policy to understand our practices.',
        ),
        _Section(
          title: 'Intellectual Property',
          body:
              'The app and its original content, features, and functionality are and will remain the exclusive property of LoeSoft. You may not copy, modify, distribute, or create derivative works based on the app without our express written permission.',
        ),
        _Section(
          title: 'Disclaimer of Warranties',
          body:
              'The app is provided on an "AS IS" and "AS AVAILABLE" basis without warranties of any kind, either express or implied. We do not warrant that the app will be uninterrupted, error-free, or free of viruses or other harmful components.',
        ),
        _Section(
          title: 'Limitation of Liability',
          body:
              'To the fullest extent permitted by law, LoeSoft shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of or inability to use the app.',
        ),
        _Section(
          title: 'Termination',
          body:
              'We reserve the right to suspend or terminate your account at our sole discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users, us, or third parties. You may delete your account at any time from Settings → Danger Zone.',
        ),
        _Section(
          title: 'Changes to These Terms',
          body:
              'We may update these Terms from time to time. We will notify you of significant changes by updating the date at the top of this page. Continued use of the app after changes constitutes acceptance of the updated Terms.',
        ),
        _Section(
          title: 'Governing Law',
          body:
              'These Terms are governed by and construed in accordance with applicable laws. Any disputes arising under these Terms shall be resolved through good-faith negotiation.',
        ),
        _Section(
          title: 'Contact',
          body:
              'For questions about these Terms, contact us at: loesoft.support@gmail.com',
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoodooText(title, variant: MoodooTextVariant.headlineSmall),
          const SizedBox(height: 6),
          MoodooText(
            body,
            variant: MoodooTextVariant.titleMedium,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
