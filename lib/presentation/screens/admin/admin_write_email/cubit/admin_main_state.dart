abstract class AdminStates {}

final class AdminMainInitState extends AdminStates {}

final class AdminIsEventNameValidState extends AdminStates {}

final class AdminIsEventDescValidState extends AdminStates {}

final class AdminPickDateState extends AdminStates {}

final class AdminSendEmailLoadingState extends AdminStates {}

final class AdminSendEmailSuccessState extends AdminStates {}

final class AdminSendEmailErrorState extends AdminStates {
  final String error;

  AdminSendEmailErrorState(this.error);
}
