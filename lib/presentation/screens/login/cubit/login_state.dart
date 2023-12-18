abstract class LoginStates {}

final class LoginInitState extends LoginStates {}

final class LoginLoadingState extends LoginStates {}

final class LoginSuccessState extends LoginStates {}

final class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

final class LoginIsEmailValidState extends LoginStates {}

final class LoginIsPasswordValidState extends LoginStates {}
