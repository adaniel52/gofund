import 'package:flutter/material.dart';
import 'package:gofund/pages/auth/login_page.dart';
import 'package:gofund/pages/main_page.dart';
import 'package:gofund/services/auth_service.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final user = AuthService().getUser();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                (user == null) ? const LoginPage() : const MainPage(),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
