import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/models/database_user.dart';
import 'package:gofund/pages/main_page.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/services/database/user_service.dart';
import 'package:gofund/utils/dialogs/show_error_dialog.dart';
import 'package:gofund/utils/dialogs/show_loading_dialog.dart';
import 'package:gofund/widgets/custom_column.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final authService = AuthService.instance;
  final userService = UserService.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) return;
    showLoadingDialog(context);
    try {
      await authService.signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      final userId = authService.getUser()!.id;
      await userService.createDatabaseUser(
        DatabaseUser(id: userId),
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
        (route) => false,
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      showErrorDialog(
        context,
        message: e.message,
        statusCode: e.statusCode,
        errorCode: e.code,
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      showErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = AppSpacing.large;
    final width = MediaQuery.of(context).size.width;
    if (width > 400 + AppSpacing.large) horizontalPadding = (width - 400) / 2;

    final children = [
      Text(
        'Sign Up',
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.center,
      ),
      const Divider(),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
        controller: _nameController,
        validator: (value) {
          if (value == '') return 'Can\'t be empty';
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Email',
        ),
        controller: _emailController,
        validator: (value) {
          if (value == '') return 'Can\'t be empty';
          if (!value!.contains('@') || !value.contains('.')) {
            return 'Invalid email';
          }
          return null;
        },
      ),
      TextFormField(
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
        controller: _passwordController,
        validator: (value) {
          if (value == '') return 'Can\'t be empty';
          return null;
        },
      ),
      const Divider(),
      FilledButton(
        onPressed: signup,
        child: const Text('Sign Up'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Center(
          child: CustomColumn(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacing.large,
              horizontal: horizontalPadding,
            ),
            children: children,
          ),
        ),
      ),
    );
  }
}
