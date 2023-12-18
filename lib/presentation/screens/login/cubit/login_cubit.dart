import 'package:event_platform_app/core/services/app_preferences.dart';
import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/domain/usecases/login_usecase.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final LoginUsecase _loginUsecase = LoginUsecase(getIt());
  final AppPrefrences _appPrefrences = AppPrefrences(getIt());

  TextEditingController emailTextEditingcontroller = TextEditingController();
  TextEditingController passwordTextEditingcontroller = TextEditingController();

  void loginWithEmailAndPassowrd() async {
    emit(LoginLoadingState());
    (await _loginUsecase.execute(emailTextEditingcontroller.text, passwordTextEditingcontroller.text)).fold(
      (failure) {
        print('🛑 loginWithEmailAndPassowrd');
        emit(LoginErrorState(failure.errorDesc));
      },
      (userId) {
        print('✅ loginWithEmailAndPassowrd');
        print(userId);
        _appPrefrences.setUserId(userId);
        _appPrefrences.setUserLoggedIn();

        emit(LoginSuccessState());
      },
    );
  }

  bool isEmailValid = false;
  String? emailErrorMessage;

  void isEmailValidCubitfun() {
    isEmailValid = isEmailValidFun(emailTextEditingcontroller.text);
    if (isEmailValid) {
      emailErrorMessage = null;
    } else {
      emailErrorMessage = AppStrings.emailNotValidMsg;
    }
    emit(LoginIsEmailValidState());
  }

  bool isPasswordValid = false;
  String? passwordErrorMessage;

  void isPasswordValidCubitFun() {
    if (passwordTextEditingcontroller.text.length >= 7 &&
        passwordTextEditingcontroller.text.length <= 15 &&
        passwordTextEditingcontroller.text.startsWith(" ") == false &&
        passwordTextEditingcontroller.text.endsWith(" ") == false &&
        passwordTextEditingcontroller.text.contains("  ") == false) {
      isPasswordValid = true;
    } else {
      isPasswordValid = false;
    }
    emit(LoginIsPasswordValidState());
  }

  void passwordErrorMessageFun() {
    if (passwordTextEditingcontroller.text.length < 7) passwordErrorMessage = AppStrings.nameErrorTooShort;
    if (passwordTextEditingcontroller.text.length > 15) passwordErrorMessage = AppStrings.nameErrorTooLong;
    if (passwordTextEditingcontroller.text.startsWith(" ") ||
        passwordTextEditingcontroller.text.endsWith(" ") ||
        passwordTextEditingcontroller.text.contains("  ")) {
      passwordErrorMessage = AppStrings.nameErrorContainSpaces;
    } else {
      passwordErrorMessage = null;
    }
    emit(LoginIsPasswordValidState());
  }


}
