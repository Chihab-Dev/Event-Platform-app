import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isEmailValidFun(String email) {
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  return emailRegex.hasMatch(email);
}

bool isPasswordValidFun(String password) {
  RegExp passwordRegex = RegExp(r"^(?!\s)(?!.*\s$)(?!.*\s\s)[\s\S]{7,20}$");

  return passwordRegex.hasMatch(password);
}

Widget customFormField({
  required TextEditingController textEditingcontroller,
  required String textLabel,
  required String? errorLabel,
  required TextInputType textInputType,
  required Function(String) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textLabel,
        style: getMeduimStyle(
          color: ColorManager.dark,
          fontSize: AppSize.s20,
        ),
        // textAlign: TextAlign.start,
      ),
      const SizedBox(
        height: AppSize.s10,
      ),
      TextFormField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          filled: true,
          fillColor: ColorManager.whiteGrey,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppPadding.p18.sp),
            borderSide: BorderSide.none,
          ),
          errorText: errorLabel,
        ),
        controller: textEditingcontroller,
        style: getMeduimStyle(color: ColorManager.dark),
        keyboardType: textInputType,
        onChanged: onChanged,
      ),
    ],
  );
}
