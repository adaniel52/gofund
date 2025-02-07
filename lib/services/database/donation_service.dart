import 'package:gofund/models/donation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DonationService {
  DonationService._();
  static final instance = DonationService._();

  final _db = Supabase.instance.client.from('donations');

  Future<void> createDonation(Donation donation) async {
    await _db.insert(donation.toJson());
  }

  Future<List<Donation>> getRecentDonations() async {
    final response = await _db
        .select()
        .order(
          'created_at',
          ascending: false,
        )
        .limit(5);
    final donations = response.map(
      (e) {
        return Donation.fromJson(e);
      },
    ).toList();
    return donations;
  }
}
