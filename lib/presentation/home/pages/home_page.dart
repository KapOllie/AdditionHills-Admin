import 'package:barangay_adittion_hills_app/presentation/accounts/pages/accounts_page.dart';
import 'package:barangay_adittion_hills_app/presentation/admin_profile.dart/admin_profile.dart';
import 'package:barangay_adittion_hills_app/presentation/dashboard/pages/admin_dashboard_page.dart';
import 'package:barangay_adittion_hills_app/presentation/auth/widgets/sidemenu.dart';
import 'package:barangay_adittion_hills_app/presentation/documents/pages/documents_page.dart';
import 'package:barangay_adittion_hills_app/presentation/equipment/pages/equipment_page.dart';
import 'package:barangay_adittion_hills_app/presentation/events_place/event_place.dart';
import 'package:barangay_adittion_hills_app/presentation/requests/document_requests/pages/document_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/admin_menu_item_blocs.dart';
import '../bloc/admin_menu_item_state.dart';

class HomePage extends StatefulWidget {
  final String email;
  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0ebf8),
      body: SafeArea(
        child: Row(
          children: [
            const Flexible(
              flex: 2,
              child: AdminSidemenu(),
            ),
            Flexible(
              flex: 7,
              child: BlocBuilder<AdminMenuItemBlocs, AdminMenuItemState>(
                builder: (context, state) {
                  switch (state.index) {
                    case 0:
                      return const AdminDashboard();
                    case 1:
                      return const AccountsPage();
                    case 2:
                      return const DocumentsPage();
                    case 3:
                      return const EventEquipmentPage();
                    case 4:
                      return const EventPlacePage();
                    case 5:
                      return const DocumentRequestPage();
                    case 6:
                      return AdminProfilePage(
                        email: widget.email,
                      );
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
