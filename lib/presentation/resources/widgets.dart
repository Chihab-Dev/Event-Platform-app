import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:event_platform_app/domain/entities/event.dart';
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

Widget loadingScreen() {
  return Scaffold(
    backgroundColor: ColorManager.white,
    appBar: AppBar(
      backgroundColor: ColorManager.blue,
      title: Text(
        'Events',
        style: getlargeStyle(color: ColorManager.white),
      ),
    ),
    body: Center(
      child: CircularProgressIndicator(
        color: ColorManager.blue,
      ),
    ),
  );
}

Widget customElevatodButton(String label, Function()? onPressed) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPadding.p18.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p20.sp,
          horizontal: AppPadding.p30.sp,
        ),
        child: Text(
          label.toUpperCase(),
          style: getRegularStyle(color: ColorManager.white),
        ),
      ));
}

Widget eventContainer(Event event, Function()? onTap) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppPadding.p20.sp),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p18.sp),
          color: ColorManager.whiteGrey,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: AppSize.s200.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppPadding.p18.sp),
                  color: ColorManager.red,
                  image: DecorationImage(
                    image: NetworkImage(event.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: AppSize.s14.sp),
              Text(
                event.name,
                style: getlargeStyle(color: ColorManager.blue),
              ),
              SizedBox(height: AppSize.s8.sp),
              Text(
                event.desc,
                style: getMeduimStyle(color: ColorManager.blue),
              ),
              SizedBox(height: AppSize.s8.sp),
              Row(
                children: [
                  const Icon(Icons.developer_board),
                  const SizedBox(width: AppSize.s10),
                  Text(
                    event.category,
                    style: getMeduimStyle(color: ColorManager.greenBlue),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s8.sp),
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: ColorManager.blue,
                  ),
                  const SizedBox(width: AppSize.s10),
                  Text(
                    event.dateBegin,
                    style: getMeduimStyle(color: ColorManager.greenBlue),
                  ),
                  const SizedBox(width: AppSize.s10),
                  Text(
                    event.dateEnd,
                    style: getMeduimStyle(color: ColorManager.greenBlue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Widget datePicker(String label, AdminCubit cubit, Function()? onTap, String? date, BuildContext context) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: getRegularStyle(color: ColorManager.blue),
//       ),
//       SizedBox(height: AppPadding.p14.sp),
//       InkWell(
//         onTap: onTap,
//         child: Container(
//           height: AppSize.s50.sp,
//           width: AppSize.s140.sp,
//           decoration: BoxDecoration(
//             color: ColorManager.whiteGrey,
//             borderRadius: BorderRadius.circular(AppPadding.p16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(AppPadding.p8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   date == null ? 'date' : date.toString(),
//                   style: getMeduimStyle(color: ColorManager.dark),
//                 ),
//                 const Icon(
//                   Icons.date_range,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }

// Toasts ::

CherryToast errorToast(String msg) {
  return CherryToast.error(
    title: Text(msg, style: TextStyle(color: ColorManager.red)),
    backgroundColor: ColorManager.whiteGrey,
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

CherryToast successToast(String msg) {
  return CherryToast.success(
    title: Text(msg, style: TextStyle(color: ColorManager.blue)),
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}
