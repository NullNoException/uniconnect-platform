import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A simple settings provider for demonstration
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) {
    return SettingsNotifier();
  },
);

class SettingsState {
  final bool darkMode;
  final String language;
  final bool pushNotificationsEnabled;
  final bool emailNotificationsEnabled;
  final bool smsNotificationsEnabled;

  SettingsState({
    this.darkMode = false,
    this.language = 'English',
    this.pushNotificationsEnabled = true,
    this.emailNotificationsEnabled = true,
    this.smsNotificationsEnabled = false,
  });

  SettingsState copyWith({
    bool? darkMode,
    String? language,
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? smsNotificationsEnabled,
  }) {
    return SettingsState(
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      smsNotificationsEnabled:
          smsNotificationsEnabled ?? this.smsNotificationsEnabled,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  void toggleDarkMode(bool value) {
    state = state.copyWith(darkMode: value);
  }

  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }

  void togglePushNotifications(bool value) {
    state = state.copyWith(pushNotificationsEnabled: value);
  }

  void toggleEmailNotifications(bool value) {
    state = state.copyWith(emailNotificationsEnabled: value);
  }

  void toggleSmsNotifications(bool value) {
    state = state.copyWith(smsNotificationsEnabled: value);
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Display'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: settings.darkMode,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleDarkMode(value);
            },
          ),
          _buildDivider(),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(settings.language),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguagePicker(context, ref),
          ),
          _buildSectionHeader(context, 'Notifications'),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive push notifications'),
            value: settings.pushNotificationsEnabled,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .togglePushNotifications(value);
            },
          ),
          _buildDivider(),
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive email notifications'),
            value: settings.emailNotificationsEnabled,
            onChanged: (value) {
              ref
                  .read(settingsProvider.notifier)
                  .toggleEmailNotifications(value);
            },
          ),
          _buildDivider(),
          SwitchListTile(
            title: const Text('SMS Notifications'),
            subtitle: const Text('Receive SMS notifications'),
            value: settings.smsNotificationsEnabled,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).toggleSmsNotifications(value);
            },
          ),
          _buildSectionHeader(context, 'Privacy & Security'),
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to change password screen
            },
          ),
          _buildDivider(),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to privacy policy screen
            },
          ),
          _buildDivider(),
          ListTile(
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to terms of service screen
            },
          ),
          _buildSectionHeader(context, 'About'),
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),
          _buildDivider(),
          ListTile(
            title: const Text('Contact Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to contact support screen
            },
          ),
          _buildDivider(),
          ListTile(
            title: const Text('Rate the App'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Open app store rating
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, indent: 16);
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final languages = ['English', 'Arabic', 'Persian'];
    final currentLanguage = ref.read(settingsProvider).language;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  languages
                      .map(
                        (language) => RadioListTile<String>(
                          title: Text(language),
                          value: language,
                          groupValue: currentLanguage,
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(settingsProvider.notifier)
                                  .setLanguage(value);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      )
                      .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
