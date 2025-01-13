import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/bank_info.dart';
import 'package:gofund/utils/show_snack_bar.dart';
import 'package:gofund/widgets/scaffold_body_wrapper.dart';

class BankInfoDetailsScreen extends StatelessWidget {
  final BankInfo bankInfo;
  const BankInfoDetailsScreen({
    super.key,
    required this.bankInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
      ),
      body: ScaffoldBodyWrapper(
        children: [
          Card.filled(
            child: Padding(
              padding: AppSpacing.smallPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BankInfoRow('Account Name', bankInfo.accountName),
                  const Divider(),
                  BankInfoRow('Account Number', bankInfo.accountNumber),
                  const Divider(),
                  BankInfoRow('Bank Name', bankInfo.bankName),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BankInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const BankInfoRow(
    this.label,
    this.value, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
          ),
        ),
        SizedBox.square(
          dimension: 20,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            iconSize: 15,
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: value),
              );
              showSnackBar(
                context: context,
                text: 'Copied to clipboard!',
              );
            },
            icon: const Icon(Icons.copy),
          ),
        ),
      ],
    );
  }
}
