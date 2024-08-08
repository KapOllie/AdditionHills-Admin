import 'package:barangay_adittion_hills_app/presentation/accounts/pages/accounts_page.dart';
import 'package:barangay_adittion_hills_app/presentation/dashboard/pages/admin_dashboard_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/sidemenu.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/pages/documents_page.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/equipment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/admin_menu_item_blocs.dart';
import '../bloc/admin_menu_item_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE6E6E6),
      body: SafeArea(
        child: Row(
          children: [
            const Flexible(
              flex: 1,
              child: AdminSidemenu(),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<AdminMenuItemBlocs, AdminMenuItemState>(
                builder: (context, state) {
                  switch (state.index) {
                    case 0:
                      return const AdminDashboard();
                    case 1:
                      return const AccountsPage();
                    case 2:
                      return const DocumentsPage();
                    case 4:
                      return const EventEquipmentPage();
                    default:
                      return const Center(child: Text('Page not found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
