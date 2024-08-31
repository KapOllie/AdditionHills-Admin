import 'package:barangay_adittion_hills_app/core/configs/theme/app_theme.dart';
import 'package:barangay_adittion_hills_app/firebase_options.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/log_in_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/signup.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/signup_page.dart';
import 'package:barangay_adittion_hills_app/presentation/dashboard/pages/admin_dashboard_page.dart';
import 'package:barangay_adittion_hills_app/presentation/home/pages/home_page.dart';
import 'package:barangay_adittion_hills_app/try.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_blocs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => AdminMenuItemBlocs(),
      child: MaterialApp(
        title: 'RequEase',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: AuthHandler(),
        routes: {
          '/home': (context) => const HomePage(email: ''),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
        },
      ),
    );
  }
}

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the auth state to load
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // User is logged in
          return HomePage(email: snapshot.data?.email ?? '');
        } else {
          // User is not logged in
          return LoginPage();
        }
      },
    );
  }
}
