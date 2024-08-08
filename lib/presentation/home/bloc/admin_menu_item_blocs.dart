import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_event.dart';
import 'package:barangay_adittion_hills_app/presentation/home/bloc/admin_menu_item_state.dart';
import 'package:bloc/bloc.dart';

class AdminMenuItemBlocs extends Bloc<AdminMenuItemEvent, AdminMenuItemState> {
  AdminMenuItemBlocs() : super(const AdminMenuItemState(index: 0)) {
    on<NavigateToEvent>((event, emit) {
      emit(AdminMenuItemState(index: event.selectedIndex));
    });
  }
}
