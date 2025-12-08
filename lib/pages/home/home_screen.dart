import 'package:flutter/material.dart';
import 'package:flutter_restaurant/pages/auth/login_screen.dart';
import 'package:flutter_restaurant/service/auth_service.dart';
import 'package:flutter_restaurant/widgets/snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  void _logout() async {
    await _authService.logout(context);
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => LogInScreen()));
    showSnackBar(context, 'Logged out successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to the Home Screen!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(onPressed: _logout, icon: Icon(Icons.logout)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
