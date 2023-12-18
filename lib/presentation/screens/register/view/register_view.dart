import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/register/cubit/register_cubit.dart';
import 'package:event_platform_app/presentation/screens/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p20.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppSize.s250.sp,
                      width: AppSize.s250.sp,
                      child: const Image(
                        image: AssetImage('assets/gdgLogo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      AppStrings.registerInGdg,
                      style: getlargeStyle(color: ColorManager.blue),
                    ),
                    SizedBox(
                      height: AppSize.s50.sp,
                    ),
                    customFormField(
                      textEditingcontroller: cubit.nameTextEditingController,
                      textLabel: AppStrings.fullName,
                      errorLabel: cubit.nameErrorMessage,
                      textInputType: TextInputType.name,
                      onChanged: (value) {
                        cubit.isNameValidCubitFun();
                        cubit.nameErrorMessageFun();
                      },
                    ),
                    SizedBox(
                      height: AppSize.s20.sp,
                    ),
                    customFormField(
                      textEditingcontroller: cubit.emailTextEditingController,
                      textLabel: AppStrings.emailLabel,
                      errorLabel: cubit.emailErrorMessage,
                      textInputType: TextInputType.emailAddress,
                      onChanged: (value) {
                        cubit.isEmailValidCubitfun();
                      },
                    ),
                    SizedBox(
                      height: AppSize.s20.sp,
                    ),
                    customFormField(
                      textEditingcontroller: cubit.passwordTextEditingController,
                      textLabel: AppStrings.passwordLabel,
                      errorLabel: cubit.passwordErrorMessage,
                      textInputType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        cubit.isPasswordValidCubitFun();
                        cubit.passwordErrorMessageFun();
                      },
                    ),
                    SizedBox(
                      height: AppSize.s50.sp,
                    ),
                    state is RegisterLoadingState
                        ? CircularProgressIndicator(
                            color: ColorManager.blue,
                          )
                        : ElevatedButton(
                            onPressed: (cubit.isNameValid && cubit.isEmailValid && cubit.isPasswordValid)
                                ? () {
                                    cubit.registerWithEmailAndPassowrd();
                                  }
                                : null,
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
                                AppStrings.register.toUpperCase(),
                                style: getRegularStyle(color: ColorManager.white),
                              ),
                            )),
                    SizedBox(
                      height: AppSize.s50.sp,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
