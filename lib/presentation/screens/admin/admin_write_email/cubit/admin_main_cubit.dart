import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/screens/admin/admin_write_email/cubit/admin_main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminMainInitState());

  static AdminCubit get(context) => BlocProvider.of(context);

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescController = TextEditingController();

  bool isEventNameValid = false;
  String? eventNameErrorMessage;

  void isNameValidCubitFun() {
    if (eventNameController.text.length >= 7 &&
        eventNameController.text.length <= 15 &&
        eventNameController.text.startsWith(" ") == false &&
        eventNameController.text.endsWith(" ") == false &&
        eventNameController.text.contains("  ") == false) {
      isEventNameValid = true;
    } else {
      isEventNameValid = false;
    }
    emit(AdminIsEventNameValidState());
  }

  void nameErrorMessageFun() {
    if (eventNameController.text.length < 7) eventNameErrorMessage = AppStrings.nameErrorTooShort;
    if (eventNameController.text.length > 15) eventNameErrorMessage = AppStrings.nameErrorTooLong;
    if (eventNameController.text.startsWith(" ") ||
        eventNameController.text.endsWith(" ") ||
        eventNameController.text.contains("  ")) {
      eventNameErrorMessage = AppStrings.nameErrorContainSpaces;
    } else {
      eventNameErrorMessage = null;
    }
    emit(AdminIsEventNameValidState());
  }

  bool isEventDescValid = false;
  String? eventDescErrorMessage;

  void isDescValidCubitFun() {
    if (eventDescController.text.length >= 10 &&
        eventDescController.text.startsWith(" ") == false &&
        eventDescController.text.endsWith(" ") == false) {
      isEventDescValid = true;
    } else {
      isEventDescValid = false;
    }
    emit(AdminIsEventDescValidState());
  }

  void descErrorMessageFun() {
    if (eventDescController.text.length < 10) eventDescErrorMessage = AppStrings.descErrorTooShort;
    if (eventDescController.text.startsWith(" ") || eventDescController.text.endsWith(" ")) {
      eventDescErrorMessage = AppStrings.descErrorContainSpaces;
    } else {
      eventDescErrorMessage = null;
    }
    emit(AdminIsEventDescValidState());
  }

  // String? dateBegin;
  // String? dateEnd;

  // void pickBeginDate(BuildContext context) async {
  //   var x = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2023),
  //     lastDate: DateTime(2024),
  //   );

  //   print(dateBegin);
  //   dateBegin = x.toString().substring(0, 10);
  //   emit(AdminPickDateState());
  // }

  // void pickEndDate(BuildContext context) async {
  //   var x = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2023),
  //     lastDate: DateTime(2024),
  //   );
  //   dateEnd = x.toString().substring(0, 10);

  //   emit(AdminPickDateState());
  // }

  // sent email program ::
  // EmailSender emailSender = EmailSender();

  void sentEmail(Event event) async {
    emit(AdminSendEmailLoadingState());
    GoogleAuthApi.signOut();
    final user = await GoogleAuthApi.signIn();

    if (user == null) {
      emit(AdminSendEmailErrorState('google error'));
      return;
    }

    final email = user.email;
    final auth = await user.authentication;
    final token = auth.accessToken;

    print('Authenticated: $email');

    // final smtpServer = gmail(username, password);
    final smtpServer = gmailSaslXoauth2(email, token!);
    final message = Message()
      ..subject = eventNameController.text
      ..text =
          "An email about ${event.name} \n from : ${event.dateBegin}     to :  ${event.dateEnd} \n  ${eventDescController.text}"
      ..from = Address(email, 'GDG TEAM')
      ..recipients = event.registeredUsers;

    try {
      await send(
        message,
        smtpServer,
      );

      print("sent email success");
      emit(AdminSendEmailSuccessState());
    } catch (e) {
      print("sent email error");
      print(e);
      emit(AdminSendEmailErrorState(e.toString()));
    }

    GoogleAuthApi.signOut();
  }
}

class GoogleAuthApi {
  static final googleSignin = GoogleSignIn(
    scopes: ['https://mail.google.com/'],
  );
  static Future<GoogleSignInAccount?> signIn() async {
    if (await googleSignin.isSignedIn()) {
      return googleSignin.currentUser;
    } else {
      return await googleSignin.signIn();
    }
  }

  static Future signOut() => googleSignin.signOut();
}
