import 'package:flutter/material.dart';
import 'package:flutter_restaurant/pages/auth/login_screen.dart';
import 'package:flutter_restaurant/service/auth_service.dart';
import 'package:flutter_restaurant/widgets/snack_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    if (!email.contains('@') || !email.contains('.com')) {
      showSnackBar(context, "Please enter a valid email address.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    String? result = await _authService.signup(email, password);
    if (result == null) {
      // Sign up successful, navigate to login screen
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LogInScreen()),
      );
      showSnackBar(context, "Sign up successful! Please log in.");
    } else {
      // Show error message
      if (!mounted) return;
      showSnackBar(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/signup.svg',
              height:
                  150, // Only specify height, width will scale proportionally
              fit: BoxFit.contain,
            ),
            SizedBox(height: 30),
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: isPasswordHidden,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading ? null : _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LogInScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
