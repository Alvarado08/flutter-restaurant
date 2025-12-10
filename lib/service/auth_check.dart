import 'package:flutter/material.dart';
import 'package:flutter_restaurant/pages/auth/login_screen.dart';
import 'package:flutter_restaurant/pages/home/onboarding_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheck extends StatelessWidget {
  AuthCheck({super.key});

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          // User is logged in
          return OnboardingScreen();
        } else {
          // User is not logged in
          return LogInScreen();
        }
      },
    );
  }
}
