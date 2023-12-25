import 'package:event_platform_app/domain/entities/event.dart';
import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/admin/admin_write_email/cubit/admin_main_cubit.dart';
import 'package:event_platform_app/presentation/screens/admin/admin_write_email/cubit/admin_main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminWriteEmailView extends StatelessWidget {
  AdminWriteEmailView({required this.event, super.key});

  Event event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {
          if (state is AdminSendEmailErrorState) {
            errorToast(state.error).show(context);
          }
          if (state is AdminSendEmailSuccessState) {
            successToast('sending emails successfully').show(context);
          }
        },
        builder: (context, state) {
          var cubit = AdminCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: ColorManager.blue,
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p18.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customFormField(
                          textEditingcontroller: cubit.eventNameController,
                          textLabel: AppStrings.eventName,
                          errorLabel: cubit.eventNameErrorMessage,
                          textInputType: TextInputType.name,
                          onChanged: (input) {
                            cubit.isNameValidCubitFun();
                            cubit.nameErrorMessageFun();
                          },
                        ),
                        SizedBox(height: AppPadding.p20.sp),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.emailDesc,
                              style: getMeduimStyle(
                                color: ColorManager.dark,
                                fontSize: AppSize.s20,
                              ),
                              // textAlign: TextAlign.start,
                            ),
                            SizedBox(height: AppSize.s10.sp),
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
                                errorText: cubit.eventDescErrorMessage,
                              ),
                              controller: cubit.eventDescController,
                              style: getMeduimStyle(color: ColorManager.dark),
                              keyboardType: TextInputType.text,
                              maxLength: 500,
                              maxLines: 13,
                              onChanged: (input) {
                                cubit.isDescValidCubitFun();
                                cubit.descErrorMessageFun();
                              },
                            ),
                            SizedBox(height: AppSize.s50.sp),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p30),
                    child: state is AdminSendEmailLoadingState
                        ? CircularProgressIndicator(color: ColorManager.blue)
                        : customElevatodButton(
                            AppStrings.sentEmail,
                            (cubit.isEventNameValid && cubit.isEventDescValid)
                                ? () {
                                    cubit.sentEmail(event);
                                  }
                                : null,
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
