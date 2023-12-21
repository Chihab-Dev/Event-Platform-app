import 'package:event_platform_app/core/services/app_preferences.dart';
import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/domain/entities/member.dart';
import 'package:event_platform_app/domain/usecases/add_new_user_toFiresbase_usecase.dart';
import 'package:event_platform_app/domain/usecases/register_usecase.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final RegisterUsecase _registerUsecase = RegisterUsecase(getIt());
  final AddNewUserToFiresbaseUsecase _addNewUserToFiresbaseUsecase = AddNewUserToFiresbaseUsecase(getIt());

  final AppPrefrences _appPrefrences = AppPrefrences(getIt());

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  void registerWithEmailAndPassowrd() async {
    emit(RegisterLoadingState());
    (await _registerUsecase.execute(emailTextEditingController.text, passwordTextEditingController.text)).fold(
      (failure) {
        print('🛑 RegisterWithEmailAndPassowrd');
        emit(RegisterErrorState(failure.messageError));
      },
      (data) async {
        print('✅ registerWithEmailAndPassowrd');
        print(data);
        _appPrefrences.setUserId(data);
        _appPrefrences.setUserLoggedIn();
        emit(RegisterSuccessState());
        (await _addNewUserToFiresbaseUsecase.execute(
          Member(
            id: data,
            fullName: nameTextEditingController.text,
            email: emailTextEditingController.text,
          ),
        ))
            .fold(
          (failure) {
            print('🛑 AddNewUserToFiresbaseUsecase');
            emit(RegisterAddNewUserErrorState(failure.messageError));
          },
          (data) {
            print('✅ registerWithEmailAndPassowrd');
            print(data);
            emit(RegisterAddNewUserSuccessState());
          },
        );
      },
    );
  }

  bool isNameValid = false;
  String? nameErrorMessage;

  void isNameValidCubitFun() {
    if (nameTextEditingController.text.length >= 7 &&
        nameTextEditingController.text.length <= 15 &&
        nameTextEditingController.text.startsWith(" ") == false &&
        nameTextEditingController.text.endsWith(" ") == false &&
        nameTextEditingController.text.contains("  ") == false) {
      isNameValid = true;
    } else {
      isNameValid = false;
    }
    emit(RegisterIsNameValidState());
  }

  void nameErrorMessageFun() {
    if (nameTextEditingController.text.length < 7) nameErrorMessage = AppStrings.nameErrorTooShort;
    if (nameTextEditingController.text.length > 15) nameErrorMessage = AppStrings.nameErrorTooLong;
    if (nameTextEditingController.text.startsWith(" ") ||
        nameTextEditingController.text.endsWith(" ") ||
        nameTextEditingController.text.contains("  ")) {
      nameErrorMessage = AppStrings.nameErrorContainSpaces;
    } else {
      nameErrorMessage = null;
    }
    emit(RegisterIsNameValidState());
  }

  bool isEmailValid = false;
  String? emailErrorMessage;

  void isEmailValidCubitfun() {
    isEmailValid = isEmailValidFun(emailTextEditingController.text);
    if (isEmailValid) {
      emailErrorMessage = null;
    } else {
      emailErrorMessage = AppStrings.emailNotValidMsg;
    }
    emit(RegisterIsEmailValidState());
  }

  bool isPasswordValid = false;
  String? passwordErrorMessage;

  void isPasswordValidCubitFun() {
    if (passwordTextEditingController.text.length >= 7 &&
        passwordTextEditingController.text.length <= 15 &&
        passwordTextEditingController.text.startsWith(" ") == false &&
        passwordTextEditingController.text.endsWith(" ") == false &&
        passwordTextEditingController.text.contains("  ") == false) {
      isPasswordValid = true;
    } else {
      isPasswordValid = false;
    }
    emit(RegisterIsPasswordValidState());
  }

  void passwordErrorMessageFun() {
    if (passwordTextEditingController.text.length < 7) passwordErrorMessage = AppStrings.nameErrorTooShort;
    if (passwordTextEditingController.text.length > 15) passwordErrorMessage = AppStrings.nameErrorTooLong;
    if (passwordTextEditingController.text.startsWith(" ") ||
        passwordTextEditingController.text.endsWith(" ") ||
        passwordTextEditingController.text.contains("  ")) {
      passwordErrorMessage = AppStrings.nameErrorContainSpaces;
    } else {
      passwordErrorMessage = null;
    }
    emit(RegisterIsPasswordValidState());
  }
}
