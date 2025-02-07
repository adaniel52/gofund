import 'package:gofund/models/database_user.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  UserService._();
  static final instance = UserService._();

  final _db = Supabase.instance.client.from('users');

  Future<DatabaseUser> getDatabaseUser() async {
    final userId = AuthService.instance.getUser()!.id;
    final response = await _db.select().eq('id', userId).single();
    return DatabaseUser.fromJson(response);
  }
}
