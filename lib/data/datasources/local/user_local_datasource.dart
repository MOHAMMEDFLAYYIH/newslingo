import 'dart:convert';
import 'package:hive/hive.dart';

class UserLocalDataSource {
  static const String _box = 'user_data';

  Future<void> saveProfile(Map<String, dynamic> profile) async {
    final box = await Hive.openBox<String>(_box);
    await box.put('profile', jsonEncode(profile));
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final box = await Hive.openBox<String>(_box);
    final data = box.get('profile');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final box = await Hive.openBox<String>(_box);
    await box.put('settings', jsonEncode(settings));
  }

  Future<Map<String, dynamic>?> getSettings() async {
    final box = await Hive.openBox<String>(_box);
    final data = box.get('settings');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  Future<void> markOnboardingComplete() async {
    final box = await Hive.openBox<String>(_box);
    await box.put('onboarding_complete', 'true');
  }

  Future<bool> isOnboardingComplete() async {
    final box = await Hive.openBox<String>(_box);
    return box.get('onboarding_complete') == 'true';
  }

  Future<void> saveAuthToken(String token) async {
    final box = await Hive.openBox<String>(_box);
    await box.put('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    final box = await Hive.openBox<String>(_box);
    return box.get('auth_token');
  }

  Future<void> clearAuth() async {
    final box = await Hive.openBox<String>(_box);
    await box.delete('auth_token');
  }

  Future<void> saveLocale(String locale) async {
    final box = await Hive.openBox<String>(_box);
    await box.put('locale', locale);
  }

  Future<String?> getLocale() async {
    final box = await Hive.openBox<String>(_box);
    return box.get('locale');
  }

  Future<void> saveOnboardingLevel(String level) async {
    final box = await Hive.openBox<String>(_box);
    await box.put('onboarding_level', level);
  }

  Future<String?> getOnboardingLevel() async {
    final box = await Hive.openBox<String>(_box);
    return box.get('onboarding_level');
  }

  Future<void> saveOnboardingInterests(List<String> interests) async {
    final box = await Hive.openBox<String>(_box);
    await box.put('onboarding_interests', jsonEncode(interests));
  }

  Future<List<String>?> getOnboardingInterests() async {
    final box = await Hive.openBox<String>(_box);
    final data = box.get('onboarding_interests');
    if (data == null) return null;
    return (jsonDecode(data) as List).cast<String>();
  }

  Future<void> clearOnboardingSelections() async {
    final box = await Hive.openBox<String>(_box);
    await box.delete('onboarding_level');
    await box.delete('onboarding_interests');
  }
}
