import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/donation.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/services/database/bank_service.dart';
import 'package:gofund/services/database/donation_service.dart';
import 'package:gofund/services/database/project_service.dart';
import 'package:gofund/services/payment_service.dart';
import 'package:gofund/utils/dialogs/show_error_dialog.dart';
import 'package:gofund/utils/dialogs/show_succcess_dialog.dart';
import 'package:gofund/widgets/custom_column.dart';
import 'package:gofund/widgets/custom_list_view.dart';
import 'package:gofund/widgets/settings/copy_tile.dart';

class ProjectDetailsPage extends StatefulWidget {
  final Project project;
  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final paymentService = PaymentService.instance;
  final authService = AuthService.instance;
  final donationService = DonationService.instance;
  final projectService = ProjectService.instance;

  bool _shouldUpdate = false;
  late Project _project;

  @override
  void initState() {
    super.initState();
    _project = widget.project;
  }

  Future<void> payOnline() async {
    try {
      final text = await showDialog<String?>(
        context: context,
        builder: (context) {
          final formKey = GlobalKey<FormState>();
          final controller = TextEditingController();

          return AlertDialog(
            icon: const Icon(Icons.credit_card),
            title: const Text('Pay via Stripe'),
            content: Form(
              key: formKey,
              child: CustomColumn(
                children: [
                  const Text('Enter the amount in the RM currency:'),
                  TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'e.g. 10'),
                    validator: (value) {
                      final num = double.tryParse(value!);
                      if (num == null) return 'Not a valid number';
                      if (num < 2) return 'Number is too small';
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  Navigator.of(context).pop(controller.text);
                },
                child: const Text('Next'),
              ),
            ],
          );
        },
      );

      if (text == null) return;

      final amount = double.parse(
        double.parse(text).toStringAsFixed(2),
      );
      final paymentIntent = await paymentService.makePayment(amount);

      final userId = authService.getUser()!.id;
      final donation = Donation(
        id: paymentIntent.id,
        userId: userId,
        projectId: _project.id,
        amount: amount,
        createdAt: DateTime.now(),
      );
      await donationService.createDonation(donation);

      final updatedProject = _project.copyWith(
        collectedAmount: _project.collectedAmount + amount,
      );
      await projectService.updateProject(updatedProject);
      setState(() {
        _shouldUpdate = true;
        _project = updatedProject;
      });

      if (!mounted) return;
      showSuccessDialog(
        context,
        message:
            'RM${amount.toStringAsFixed(2)} has been funded into project ${_project.name}. Thank you!',
      );
    } on StripeException catch (e) {
      showErrorDialog(
        context,
        message: e.error.message!,
        errorCode: e.error.code.toString(),
      );
    } catch (e) {
      showErrorDialog(
        context,
        message: e.toString(),
      );
    }
  }

  Future<void> transferBank() async {
    final bank = await BankService().getBank(_project);
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(Icons.account_balance_wallet),
          title: const Text('Bank Transfer'),
          content: CustomColumn(
            children: [
              const Text('You can use this school\'s bank account:'),
              CopyTile(
                title: 'Account Name',
                label: bank.accountName,
              ),
              CopyTile(
                title: 'Account Number',
                label: bank.accountNumber,
              ),
              CopyTile(
                trailing: (bank.bankImageUrl == null)
                    ? null
                    : Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          borderRadius: AppRadius.smallRadius,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image(image: NetworkImage(bank.bankImageUrl!)),
                      ),
                title: 'Bank Name',
                label: bank.bankName,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = AppSpacing.large;
    final width = MediaQuery.of(context).size.width;
    if (width > 400 + AppSpacing.large) horizontalPadding = (width - 400) / 2;

    final progressValue = _project.collectedAmount / _project.goalAmount;
    final currentAmount = _project.collectedAmount.toStringAsFixed(2);
    final targetAmount = _project.goalAmount.toStringAsFixed(2);
    final percent = '${(progressValue * 100).toStringAsFixed(2)}%';
    final subtitle = 'RM $currentAmount / $targetAmount ($percent)';

    final children = [
      if (_project.imageUrl != null) ...[
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.largeRadius,
          ),
          clipBehavior: Clip.hardEdge,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(_project.imageUrl!),
          ),
        ),
        const Divider(),
      ],
      Text(
        _project.name,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      FractionallySizedBox(
        widthFactor: 0.75,
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: AppRadius.smallRadius,
          value: progressValue,
        ),
      ),
      const Divider(),
      Text(
        'Choose your preferred donation method:',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      Column(
        children: [
          FilledButton.icon(
            onPressed: payOnline,
            icon: const Icon(Icons.credit_card),
            label: const Text('Pay via Stripe'),
          ),
          FilledButton.tonalIcon(
            onPressed: transferBank,
            icon: const Icon(Icons.account_balance_wallet),
            label: const Text('Bank Transfer'),
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop(_shouldUpdate);
          },
        ),
      ),
      body: SafeArea(
        child: CustomListView(
          padding: EdgeInsets.symmetric(
            vertical: AppSpacing.large,
            horizontal: horizontalPadding,
          ),
          children: children,
        ),
      ),
    );
  }
}
