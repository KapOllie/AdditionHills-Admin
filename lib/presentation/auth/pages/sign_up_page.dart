import 'package:barangay_adittion_hills_app/presentation/auth/utils/signup_validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barangay_adittion_hills_app/common/widgets/appbar/app_bar.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/log_in_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/field_label_text.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/signup_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = true;
  final _lastName = TextEditingController();
  final _firstName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _birthday = TextEditingController();
  final _address = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _birthday.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 700,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xff0a0a0a),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LabelField(
                              labelText: 'Last Name',
                            ),
                            TextFormField(
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Color(0xff818A91),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal)),
                              controller: _lastName,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24))),
                                fillColor: Color(0xffE3F2FC),
                                filled: true,
                              ),
                              validator: (value) => validateName(value),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelField(
                            labelText: 'First Name',
                          ),
                          SignupField(
                            controller: _firstName,
                            validator: (value) => validateName(value),
                          ),
                        ],
                      ))
                    ],
                  ),
                  const LabelField(
                    labelText: 'Email',
                  ),
                  SignupField(
                    controller: _email,
                    validator: (value) => validateEmail(value),
                  ),
                  const LabelField(
                    labelText: 'Password',
                  ),
                  SignupField(
                    obscuringText: '•',
                    obscuredText: !_isPasswordVisible,
                    controller: _password,
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
                    validator: (value) => validatePassword(value),
                  ),
                  const LabelField(
                    labelText: 'Confirm Password',
                  ),
                  SignupField(
                      obscuringText: '•',
                      obscuredText: !_isPasswordVisible,
                      controller: _confirmPassword,
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
                      validator: (value) =>
                          validateConfirmPassword(value, _password)),
                  const LabelField(
                    labelText: 'Birthday',
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                        child: SignupField(
                      controller: _birthday,
                      iconButton: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xff818A91),
                          ),
                          onPressed: () {}),
                      validator: (value) => validateBirthday(value),
                    )),
                  ),
                  const LabelField(
                    labelText: 'Address',
                  ),
                  SignupField(
                    controller: _address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF7F50),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2294F2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                          ),
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Handle successful sign up
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Signing up...')),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
