import 'dart:math';

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

  Future<Project> getProjectById(int id) async {
    final response = await _db.select().eq('id', id).single();

    return Project.fromJson(response);
  }

  Future<Project> getRandomProject() async {
    final projects = await getProjects();
    final ongoingProjects = projects.where((e) => !e.isFinished).toList();
    final randomIndex = Random().nextInt(ongoingProjects.length);
    return ongoingProjects[randomIndex];
  }

  Future<void> updateProject(Project project) async {
    await _db.update(project.toJson()).eq('id', project.id);
  }
}
