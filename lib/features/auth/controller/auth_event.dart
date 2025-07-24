abstract class AuthEvent {
  AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String myCode;
  final String mosqueCode;

  LoginEvent({required this.myCode, required this.mosqueCode});
}