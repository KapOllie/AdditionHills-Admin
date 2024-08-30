import 'package:barangay_adittion_hills_app/core/configs/theme/app_theme.dart';
import 'package:barangay_adittion_hills_app/firebase_options.dart';
import 'package:barangay_adittion_hills_app/pickaboo.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/log_in_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/signup.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/signup_page.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/equipment_page.dart';
import 'package:barangay_adittion_hills_app/presentation/events_place/event_place.dart';
import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_blocs.dart';
import 'package:barangay_adittion_hills_app/presentation/home/pages/home_page.dart';
import 'package:barangay_adittion_hills_app/presentation/requests/document_requests/pages/document_request.dart';
import 'package:barangay_adittion_hills_app/presentation/venue_requests.dart/venue_requests.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
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
        home: HomePage(
          email: '',
        ),
        theme: AppTheme.lightTheme,
        routes: {
          '/home': (context) => const HomePage(
                email: '',
              ),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage()
        },
      ),
    );
  }
}
