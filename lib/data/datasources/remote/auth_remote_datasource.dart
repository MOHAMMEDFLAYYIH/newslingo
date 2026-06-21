import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSource(this._client);

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    final user = response.user;
    if (user == null) throw Exception('فشل إنشاء الحساب');
    await _client.from('profiles').upsert({
      'id': user.id,
      'name': name,
      'email': email,
    });
    return {
      'user': user,
      'session': response.session,
    };
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) throw Exception('فشل تسجيل الدخول');
    return {
      'user': user,
      'session': response.session,
    };
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> deleteAccount() async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    try {
      await _client.rpc('delete_user_account');
    } catch (_) {}
    await _client.auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  Session? get currentSession => _client.auth.currentSession;
  User? get currentUser => _client.auth.currentUser;

  Future<Map<String, dynamic>?> getProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final data = await _client
        .from('profiles')
        .select('*')
        .eq('id', user.id)
        .single();
    return data;
  }

  Future<void> updateProfile(Map<String, dynamic> profile) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('المستخدم غير مسجل');
    await _client.from('profiles').update(profile).eq('id', user.id);
  }

  Future<Map<String, dynamic>?> getProgress() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final data = await _client
        .from('user_progress')
        .select('*')
        .eq('user_id', user.id)
        .single();
    return data;
  }

  Future<void> updateProgress(Map<String, dynamic> progress) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('المستخدم غير مسجل');
    await _client
        .from('user_progress')
        .upsert({'user_id': user.id, ...progress});
  }

  Future<Map<String, dynamic>?> getSettings() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final data = await _client
        .from('user_settings')
        .select('*')
        .eq('user_id', user.id)
        .single();
    return data;
  }

  Future<void> updateSettings(Map<String, dynamic> settings) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('المستخدم غير مسجل');
    await _client
        .from('user_settings')
        .upsert({'user_id': user.id, ...settings});
  }

  Future<void> saveWord(Map<String, dynamic> word) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('المستخدم غير مسجل');
    await _client.from('saved_words').upsert({
      'user_id': user.id,
      ...word,
    });
  }

  Future<List<Map<String, dynamic>>> getSavedWords() async {
    final user = _client.auth.currentUser;
    if (user == null) return [];
    final data = await _client
        .from('saved_words')
        .select('*')
        .eq('user_id', user.id)
        .order('saved_at', ascending: false);
    return data;
  }

  Future<void> deleteSavedWord(String word) async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    await _client
        .from('saved_words')
        .delete()
        .eq('user_id', user.id)
        .eq('word', word);
  }

  Future<void> bookmarkArticle(String articleId) async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    await _client.from('bookmarks').upsert({
      'user_id': user.id,
      'article_id': articleId,
    });
  }

  Future<void> unbookmarkArticle(String articleId) async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    await _client
        .from('bookmarks')
        .delete()
        .eq('user_id', user.id)
        .eq('article_id', articleId);
  }

  Future<bool> isArticleBookmarked(String articleId) async {
    final user = _client.auth.currentUser;
    if (user == null) return false;
    final data = await _client
        .from('bookmarks')
        .select('*')
        .eq('user_id', user.id)
        .eq('article_id', articleId)
        .maybeSingle();
    return data != null;
  }

  Future<List<String>> getBookmarkedArticleIds() async {
    final user = _client.auth.currentUser;
    if (user == null) return [];
    final data = await _client
        .from('bookmarks')
        .select('article_id')
        .eq('user_id', user.id);
    return data.map((e) => e['article_id'] as String).toList();
  }

  Future<void> markOnboardingComplete() async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    await _client
        .from('profiles')
        .update({'onboarding_complete': true})
        .eq('id', user.id);
  }

  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    final data = await _client
        .from('user_progress')
        .select('*, profiles!inner(name, email)')
        .order('streak', ascending: false)
        .limit(50);
    return data;
  }
}
