import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/bank_info.dart';
import 'package:gofund/screens/bank_info_details_screen.dart';
import 'package:gofund/services/navigation_service.dart';
import 'package:gofund/widgets/clickable_card.dart';
import 'package:gofund/widgets/custom_button.dart';
import 'package:gofund/widgets/scaffold_body_wrapper.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BankInfo> bankAccounts = [
      BankInfo(
        accountName:
            'Koperasi Sekolah Menengah Yayasan Terengganu Kuala Berang Berhad',
        accountNumber: '513032503116',
        bankName: 'Maybank',
        bankIconUrl:
            'https://scontent.fkul8-5.fna.fbcdn.net/v/t39.30808-6/360158138_597613615812746_5490363463367686453_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=jQFl0SxfSsgQ7kNvgFX237e&_nc_zt=23&_nc_ht=scontent.fkul8-5.fna&_nc_gid=A4HAYQZFrYvt8XpUSH-2KQu&oh=00_AYCmPxvRxzuonr9SIxV-dbZUsUtRDBfL7yG1e9UZdkxIfw&oe=678A886C',
      ),
      BankInfo(
        accountName: 'AKAUN TABUNG KEBAJIKAN SEK MEN IMTIAZ K.BERANG',
        accountNumber: '563037080612',
        bankName: 'Maybank',
        bankIconUrl:
            'https://scontent.fkul8-5.fna.fbcdn.net/v/t39.30808-6/360158138_597613615812746_5490363463367686453_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=jQFl0SxfSsgQ7kNvgFX237e&_nc_zt=23&_nc_ht=scontent.fkul8-5.fna&_nc_gid=A4HAYQZFrYvt8XpUSH-2KQu&oh=00_AYCmPxvRxzuonr9SIxV-dbZUsUtRDBfL7yG1e9UZdkxIfw&oe=678A886C',
      ),
      BankInfo(
          accountName: 'SURAU AL FURQAN SM IMTIAZ YT KUALA BERANG',
          accountNumber: '1101854648',
          bankName: 'Bank Rakyat',
          bankIconUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbWCl7yNd1FcdeiiF5lJyggPkPc5sGJbpH9g&s'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
      ),
      body: ScaffoldBodyWrapper(
        children: [
          const Text(
            'Online Payment',
            style: AppTextStyles.subtitle,
          ),
          const Text('Insert amount of money (MYR):'),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: AppRadius.mediumRadius,
              ),
            ),
          ),
          CustomButton(
            text: 'Donate',
            onPressed: () {},
          ),
          const Text(
            'Powered by Stripe',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
          const Divider(),
          const Text(
            'Manual Payment',
            style: AppTextStyles.subtitle,
          ),
          const Text('You can use these school\'s bank accounts information:'),
          ...bankAccounts.map(
            (e) => BankInfoCard(bankInfo: e),
          ),
        ],
      ),
    );
  }
}

class BankInfoCard extends StatelessWidget {
  final BankInfo bankInfo;
  const BankInfoCard({
    super.key,
    required this.bankInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      onPressed: () => NavigationService.instance.navigateTo(
        BankInfoDetailsScreen(bankInfo: bankInfo),
      ),
      hasImage: true,
      leading: Image(
        image: NetworkImage(bankInfo.bankIconUrl),
      ),
      title: Text(
        bankInfo.accountName,
        style: const TextStyle(
          height: 0,
        ),
      ),
      subtitle: Text(bankInfo.accountNumber),
    );
  }
}
