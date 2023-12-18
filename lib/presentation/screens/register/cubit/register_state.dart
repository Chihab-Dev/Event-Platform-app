abstract class RegisterState {}

final class RegisterInitState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

final class RegisterIsNameValidState extends RegisterState {}

final class RegisterIsEmailValidState extends RegisterState {}

final class RegisterIsPasswordValidState extends RegisterState {}

final class RegisterAddNewUserLoadingState extends RegisterState {}

final class RegisterAddNewUserSuccessState extends RegisterState {}

final class RegisterAddNewUserErrorState extends RegisterState {
  final String error;

  RegisterAddNewUserErrorState(this.error);
}
