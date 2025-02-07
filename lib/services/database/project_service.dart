import 'package:gofund/models/project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectService {
  ProjectService._();
  static final instance = ProjectService._();

  final _db = Supabase.instance.client.from('projects');

  Future<List<Project>> getProjects() async {
    final response = await _db.select();

    final projects = response.map(
      (e) {
        return Project.fromJson(e);
      },
    ).toList();

    return projects;
  }
}
