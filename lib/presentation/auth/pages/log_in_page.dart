import 'package:barangay_adittion_hills_app/presentation/auth/pages/signup.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/utils/firebase_auth_services.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/login_field.dart';
import 'package:barangay_adittion_hills_app/presentation/home/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barangay_adittion_hills_app/common/widgets/appbar/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

final _formKey = GlobalKey<FormState>();

class _LoginPage extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool _isPasswordVisible =
      true; // Variable to keep track of password visibility
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _welcomeText(),
            _welcomeSubText(),
            const SizedBox(height: 100),
            Form(
                key: _formKey,
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Column(
                    children: [
                      LoginField(
                        controller: _emailController,
                        prefixIcon: const Icon(
                          Icons.email_rounded,
                          color: Color(0xff2294F2),
                        ),
                      ),
                      const SizedBox(height: 24),
                      LoginField(
                        controller: _passwordController,
                        obscuredText: _isPasswordVisible, obscuringText: '•',
                        iconButton: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color(0xff818A91),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            }),
                        // validator: (value) =>
                        //     validateConfirmPassword(value, _password)
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 360,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            _logIn();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2294F2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              color: Color(0xff0a0a0a),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: 'Sign up',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              color: Color(0xff2294F2),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/signup');
                              }),
                      ]))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void _logIn() async {
    User? user = await _auth.signInWithEmailAndPassword(
        _emailController.text, _passwordController.text);

    if (user != null) {
      const CircularProgressIndicator();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    email: user.email!,
                  )));
    } else {
      debugPrint("User not found");
    }
  }
}

Widget _welcomeText() {
  return Text(
    textAlign: TextAlign.center,
    'Welcome',
    style: GoogleFonts.inter(
      textStyle: const TextStyle(
        color: Color(0xff0a0a0a),
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _welcomeSubText() {
  return Text(
    textAlign: TextAlign.center,
    'We\'ve missed you!',
    style: GoogleFonts.inter(
      textStyle: const TextStyle(
        color: Color(0xff0a0a0a),
        fontSize: 24,
      ),
    ),
  );
}
