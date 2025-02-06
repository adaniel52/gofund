import 'package:gofund/models/bank.dart';
import 'package:gofund/models/project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankService {
  final _db = Supabase.instance.client.from('banks');

  Future<Bank> getBank(Project project) async {
    final response = await _db.select().eq('id', project.bankId).single();
    return Bank.fromJson(response);
  }
}
