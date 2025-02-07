import 'package:gofund/models/custom_auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  final _supabase = Supabase.instance.client;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
      },
    );
  }

  Future<void> logInAsGuest() async {
    await _supabase.auth.signInAnonymously();
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  CustomAuthUser? getUser() {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    return CustomAuthUser(
      id: user.aud,
      name: user.userMetadata?['name'] ?? 'Guest',
      email: (user.email == '') ? 'None' : user.email ?? 'None',
      isGuest: user.isAnonymous,
    );
  }

  Future<void> logOut() async {
    await _supabase.auth.signOut();
  }
}
