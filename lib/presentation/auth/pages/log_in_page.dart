import 'package:barangay_adittion_hills_app/presentation/auth/pages/sign_up_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/login_field.dart';
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
  bool _isPasswordVisible =
      true; // Variable to keep track of password visibility
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                        obscuredText: !_isPasswordVisible, obscuringText: '•',
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
                          onPressed: () {},
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
                            style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xff0a0a0a),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: 'Sign up',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xff2294F2),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SignUpPage()));
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
}

Widget _welcomeText() {
  return Text(
    textAlign: TextAlign.center,
    'Welcome',
    style: GoogleFonts.poppins(
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
    style: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color(0xff0a0a0a),
        fontSize: 24,
      ),
    ),
  );
}
