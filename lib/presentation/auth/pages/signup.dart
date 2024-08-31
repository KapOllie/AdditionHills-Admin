import 'package:barangay_adittion_hills_app/common/services/database_service.dart';
import 'package:barangay_adittion_hills_app/models/admin/admin.dart';
import 'package:barangay_adittion_hills_app/models/user/user_web.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/log_in_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/utils/firebase_auth_services.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/utils/signup_validation_utils.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/signup_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_number_text_input_formatter/phone_number_text_input_formatter.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final DatabaseService _databaseService = DatabaseService();

  TextEditingController _lastName = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _rePassword = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _birthday = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _dispose() async {
    _lastName.clear();
    _firstName.clear();
    _email.clear();
    _password.clear();
    _rePassword.clear();
    _address.clear();
    _phoneNumber.clear();
    _birthday.clear();
  }

  void _signUp(BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _rePassword.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        AdminModel newUser = AdminModel(
            name: "${_lastName.text}, ${_firstName.text}",
            email: _email.text,
            birthday: _birthday.text,
            address: _address.text,
            contact: '+639${_phoneNumber.text}',
            userType: "admin");

        bool success = await _databaseService.addUsers(newUser, _email.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success
                ? 'User: ${user.email} added successfully!'
                : 'Failed to add user.'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );

        if (success) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login');
          _dispose();
        }
      }
    } catch (e) {
      String errorMessage = _getFirebaseAuthErrorMessage(e as Exception);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  String _getFirebaseAuthErrorMessage(Exception e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'operation-not-allowed':
          return 'Signing in with this method is not allowed.';
        case 'weak-password':
          return 'The password provided is too weak.';
        default:
          return 'An unknown error occurred.';
      }
    } else {
      return 'An unknown error occurred.';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.inputOnly,
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
      backgroundColor: Color(0xfff0ebf8),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width / 1.5,
          height: MediaQuery.sizeOf(context).height / 1.25,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 16, top: 36, right: 16, bottom: 16),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Color(0xff1B2533)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: Color(0xff1B2533),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: labelTextfield('Last Name'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: SignupTextField(
                                        controller: _lastName,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r"^[a-zA-Z\s]+$")),
                                        ],
                                        isNotPasswordField: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Last name is a required field";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: labelTextfield('First Name'),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, right: 16),
                                      child: SignupTextField(
                                        controller: _firstName,
                                        inputFormatter: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r"^[a-zA-Z\s]+$"))
                                        ],
                                        isNotPasswordField: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Last name is a required field";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: labelTextfield('Email'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 0, right: 16),
                            child: SignupTextField(
                              controller: _email,
                              isNotPasswordField: true,
                              validator: (value) => validateEmail(value),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: labelTextfield('Password'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0, right: 16),
                            child: SignupTextField(
                              controller: _password,
                              isNotPasswordField: false,
                              suffixIcon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Color(0XFF8E99AA),
                              ),
                              helperText:
                                  'Password must be at least 8 characters long and include numbers and special characters',
                              validator: (value) => validatePassword(value),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: labelTextfield('Confirm Password'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 0, right: 16),
                            child: SignupTextField(
                              controller: _rePassword,
                              isNotPasswordField: false,
                              helperText: '',
                              validator: (value) =>
                                  validateConfirmPassword(value, _password),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: labelTextfield('Address'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 0, right: 16),
                            child: SignupTextField(
                              controller: _address,
                              helperText:
                                  'The address should be formatted as: Street, Barangay, City, Province',
                              isNotPasswordField: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Address is a required field";
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: labelTextfield('Birthday'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: TextFormField(
                                        controller: _birthday,
                                        readOnly: true,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff1B2533),
                                          ),
                                        ),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _selectDate(context);
                                            },
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: Color(0XFF8E99AA),
                                            ),
                                          ),
                                          helperText:
                                              'Birthday must be formatted as: YYYY-MM-DD',
                                          helperStyle: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                              fontSize: 10,
                                              color: Color(0XFF8E99AA),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Color(0XFF8E99AA),
                                                width: 1),
                                          ),
                                          hoverColor: Colors.transparent,
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Color(0xffE45D3A),
                                                width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Color(0XFF8E99AA),
                                                width: 1.75),
                                          ),
                                        ),
                                        validator: (value) =>
                                            validateBirthday(value),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: labelTextfield('Phone Number'),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 0, right: 16),
                                      child: SignupTextField(
                                        controller: _phoneNumber,
                                        prefixText: '(+63)',
                                        inputFormatter: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9,+]')),
                                          NationalPhoneNumberTextInputFormatter(
                                            groups: [
                                              (
                                                length: 4,
                                                leading: ' ',
                                                trailing: '-'
                                              ),
                                              (
                                                length: 3,
                                                leading: '',
                                                trailing: '-'
                                              ),
                                              (
                                                length: 3,
                                                leading: '',
                                                trailing: ' '
                                              ),
                                            ],
                                          )
                                        ],
                                        helperText: '',
                                        isNotPasswordField: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Phone number is a required field";
                                          } else if (value.length == 10) {
                                            return "Enter a valid phone number";
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _signUp(context);
                                }
                              },
                              child: Container(
                                height: 56,
                                decoration:
                                    BoxDecoration(color: Color(0xff017EF3)),
                                child: Center(
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget labelTextfield(String labelText) {
  return Text(
    labelText,
    style: GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: 14,
        color: Color(0xff1B2533),
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
