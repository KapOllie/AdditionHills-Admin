import 'package:barangay_adittion_hills_app/core/configs/theme/app_theme.dart';
import 'package:barangay_adittion_hills_app/firebase_options.dart';
import 'package:barangay_adittion_hills_app/pickaboo.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/pages/log_in_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/login_field.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/Sample.dart';
import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_blocs.dart';
import 'package:barangay_adittion_hills_app/presentation/home/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCZpHx8ToGB5EYoknfXoquskpewHBIidjE',
    appId: '1:769077879759:web:78b9778286e08d1c7628ba',
    messagingSenderId: '769077879759',
    projectId: 'sampleproject1-2cb77',
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AdminMenuItemBlocs())],
        child: MaterialApp(
          title: 'Draft',
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          theme: AppTheme.lightTheme,
          routes: {'/home': (context) => const HomePage()},
        ));
  }
}
