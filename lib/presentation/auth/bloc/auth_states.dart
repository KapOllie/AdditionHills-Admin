class AuthState {
  final String email;
  final String password;
  AuthState({required this.email, required this.password});
}

class AuthInitial extends AuthState {
  AuthInitial() : super(email: "", password: "");
}
