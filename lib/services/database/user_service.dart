import 'package:gofund/models/database_user.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  UserService._();
  static final instance = UserService._();

  final _db = Supabase.instance.client.from('users');

  Future<void> createDatabaseUser(DatabaseUser databaseUser) async {
    await _db.insert(databaseUser.toJson());
  }

  Future<DatabaseUser> getDatabaseUser() async {
    final userId = AuthService.instance.getUser()!.id;
    final response = await _db.select().eq('id', userId).single();
    return DatabaseUser.fromJson(response);
  }

  Future<DatabaseUser> getDatabaseUserById(String id) async {
    final response = await _db.select().eq('id', id).single();
    return DatabaseUser.fromJson(response);
  }

  Future<List<DatabaseUser>> getTopDatabaseUsers() async {
    final response = await _db
        .select()
        .order(
          'total_donated',
          ascending: false,
        )
        .limit(5);
    final databaseUsers = response.map(
      (e) {
        return DatabaseUser.fromJson(e);
      },
    ).toList();
    return databaseUsers;
  }

  Future<void> updateDatabaseUser(DatabaseUser databaseUser) async {
    await _db.update(databaseUser.toJson()).eq('id', databaseUser.id);
  }
}
