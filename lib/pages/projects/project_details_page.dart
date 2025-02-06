import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/project.dart';
import 'package:gofund/services/payment_service.dart';
import 'package:gofund/utils/dialogs/show_error_dialog.dart';
import 'package:gofund/widgets/custom_column.dart';
import 'package:gofund/widgets/custom_list_view.dart';

class ProjectDetailsPage extends StatelessWidget {
  final Project project;
  const ProjectDetailsPage({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = AppSpacing.large;
    final width = MediaQuery.of(context).size.width;
    if (width > 400 + AppSpacing.large) horizontalPadding = (width - 400) / 2;

    final progressValue = project.collectedAmount / project.goalAmount;
    final currentAmount = project.collectedAmount.toStringAsFixed(2);
    final targetAmount = project.goalAmount.toStringAsFixed(2);
    final percent = '${(progressValue * 100).toStringAsFixed(2)}%';
    final subtitle = 'RM $currentAmount / $targetAmount ($percent)';

    Future<void> payOnline() async {
      try {
        final text = await showDialog<String?>(
          context: context,
          builder: (context) {
            final formKey = GlobalKey<FormState>();
            final controller = TextEditingController();

            return AlertDialog(
              icon: const Icon(Icons.credit_card),
              title: const Text('Online Payment'),
              content: Form(
                key: formKey,
                child: CustomColumn(
                  children: [
                    const Text('Enter the amount in the RM currency:'),
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: 'RM 10'),
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
        await PaymentService().makePayment(amount);
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.check),
              title: const Text('Success'),
              content: Text(
                'RM${amount.toStringAsFixed(2)} has been funded into project ${project.name}. Thank you!',
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
      } on StripeException catch (e) {
        if (!context.mounted) return;
        showErrorDialog(
          context,
          message: e.error.message!,
          errorCode: e.error.code.toString(),
        );
      } catch (e) {
        if (!context.mounted) return;
        showErrorDialog(
          context,
          message: e.toString(),
        );
      }
    }

    final children = [
      if (project.imageUrl != null) ...[
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: AppRadius.largeRadius,
          ),
          clipBehavior: Clip.hardEdge,
          child: Image(
            fit: BoxFit.cover,
            image: NetworkImage(project.imageUrl!),
          ),
        ),
        const Divider(),
      ],
      Text(
        project.name,
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
      Row(
        spacing: AppSpacing.small,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: payOnline,
            child: const Text('Online Payment'),
          ),
          FilledButton.tonal(
            onPressed: () {},
            child: const Text('Manual Transfer'),
          ),
        ],
      )
    ];

    return Scaffold(
      appBar: AppBar(),
      body: CustomListView(
        padding: EdgeInsets.symmetric(
          vertical: AppSpacing.large,
          horizontal: horizontalPadding,
        ),
        children: children,
      ),
    );
  }
}
