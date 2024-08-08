import 'package:barangay_adittion_hills_app/presentation/auth/bloc/auth_states.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthBloc, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthBloc>((event, emit) {
      // TODO: implement event handler
    });

    // Events must be registered here
  }
}
