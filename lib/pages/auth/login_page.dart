import 'package:flutter/material.dart';
import 'package:gofund/constants/theme.dart';
import 'package:gofund/pages/auth/signup_page.dart';
import 'package:gofund/pages/main_page.dart';
import 'package:gofund/services/auth_service.dart';
import 'package:gofund/utils/dialogs/show_error_dialog.dart';
import 'package:gofund/utils/dialogs/show_loading_dialog.dart';
import 'package:gofund/widgets/custom_column.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final authService = AuthService.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login({required bool isGuest}) async {
    if (!isGuest && !_formKey.currentState!.validate()) return;
    showLoadingDialog(context);
    try {
      if (isGuest) {
        await authService.logInAsGuest();
      } else {
        await authService.logIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
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

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = AppSpacing.large;
    final width = MediaQuery.of(context).size.width;
    if (width > 400 + AppSpacing.large) horizontalPadding = (width - 400) / 2;

    final children = [
      Text(
        'Log In',
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.center,
      ),
      const Divider(),
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
        onPressed: () => login(isGuest: false),
        child: const Text('Log In'),
      ),
      Row(
        spacing: AppSpacing.small,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account?',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          TextButton(
            onPressed: navigateToSignup,
            child: const Text('Sign Up'),
          ),
          TextButton(
            onPressed: () => login(isGuest: true),
            child: const Text('Guest'),
          ),
        ],
      )
    ];

    return Scaffold(
      body: SafeArea(
        child: Form(
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
      ),
    );
  }
}
