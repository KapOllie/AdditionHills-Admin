import 'package:barangay_adittion_hills_app/core/configs/theme/app_theme.dart';
import 'package:barangay_adittion_hills_app/firebase_options.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/Sample.dart';
import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_blocs.dart';
import 'package:barangay_adittion_hills_app/presentation/home/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
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
        ));
  }
}
