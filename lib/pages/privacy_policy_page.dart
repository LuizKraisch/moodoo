import 'package:flutter/material.dart';
import 'package:moodoo/l10n/app_localizations.dart';
import 'package:moodoo/widgets/headers/moodoo_header.dart';
import 'package:moodoo/widgets/shared/moodoo_text.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
              children: [SizedBox(height: 140), _PrivacyPolicyContent()],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MoodooHeader(title: l10n.privacyPolicy),
          ),
        ],
      ),
    );
  }
}

class _PrivacyPolicyContent extends StatelessWidget {
  const _PrivacyPolicyContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          title: 'Last updated: May 13, 2025',
          body:
              'LoeSoft ("we", "us", "our") is committed to protecting your privacy. This policy explains what information we collect, how we use it, and your rights regarding your personal data.',
        ),
        _Section(
          title: 'Information We Collect',
          body:
              '• Account information: When you sign in with Google, we receive your name and email address from that provider.\n\n'
              '• Mood data: The mood scores (S–F) and optional notes you enter in the app.\n\n'
              'We do not collect device identifiers, precise location, health data, or any information beyond what is described above.',
        ),
        _Section(
          title: 'How We Use Your Information',
          body:
              '• To provide and sync your mood calendar across devices.\n\n'
              '• To identify your account and associate your mood entries with it.\n\n'
              'We do not sell, rent, or share your personal information with third parties for advertising or marketing purposes.',
        ),
        _Section(
          title: 'Data Storage',
          body:
              'Your data is stored securely using Google Firebase (Cloud Firestore). Firebase complies with major privacy and security standards including GDPR, CCPA, ISO 27001, and SOC 2/3. Data is encrypted in transit and at rest.',
        ),
        _Section(
          title: 'Data Deletion',
          body:
              'You can delete all your mood entries or your entire account at any time from Settings → Danger Zone. Deletion is permanent and cannot be undone. Upon account deletion, all associated data is permanently removed from our systems.',
        ),
        _Section(
          title: 'Third-Party Services',
          body:
              'Moodoo uses the following third-party services, each governed by their own privacy policies:\n\n'
              '• Google Sign-In — policies.google.com/privacy\n'
              '• Google Firebase — firebase.google.com/support/privacy',
        ),
        _Section(
          title: "Children's Privacy",
          body:
              'Moodoo is not directed at children under the age of 13. We do not knowingly collect personal information from children. If you believe a child has provided us with personal information, please contact us so we can delete it.',
        ),
        _Section(
          title: 'Your Rights',
          body:
              'Depending on your location, you may have the right to access, correct, or delete your personal data. You can exercise these rights directly within the app (Settings → Danger Zone) or by contacting us.',
        ),
        _Section(
          title: 'Changes to This Policy',
          body:
              'We may update this privacy policy from time to time. We will notify you of significant changes by updating the date at the top of this page. Continued use of the app after changes constitutes acceptance of the updated policy.',
        ),
        _Section(
          title: 'Contact',
          body:
              'For privacy-related questions or requests, contact us at: loesoft.support@gmail.com',
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
