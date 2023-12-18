import 'package:event_platform_app/core/services/app_preferences.dart';
import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/login/cubit/login_cubit.dart';
import 'package:event_platform_app/presentation/screens/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    AppPrefrences appPrefrences = AppPrefrences(getIt());

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print(appPrefrences.getUserId());
          print(appPrefrences.isUserLoggedIn());
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p20.sp),
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: AppSize.s250.sp,
                      width: AppSize.s250.sp,
                      child: const Image(
                        image: AssetImage('assets/gdgLogo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      AppStrings.welcome,
                      style: getlargeStyle(color: ColorManager.blue),
                    ),
                    SizedBox(
                      height: AppSize.s50.sp,
                    ),
                    customFormField(
                      emailTextEditingcontroller: cubit.emailTextEditingcontroller,
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
                      emailTextEditingcontroller: cubit.passwordTextEditingcontroller,
                      textLabel: AppStrings.passwordLabel,
                      errorLabel: cubit.passwordErrorMessage,
                      textInputType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        cubit.passwordErrorMessageFun();
                        cubit.isPasswordValidCubitFun();
                      },
                    ),
                    SizedBox(
                      height: AppSize.s50.sp,
                    ),
                    ElevatedButton(
                        onPressed: (cubit.isEmailValid && cubit.isPasswordValid)
                            ? () {
                                cubit.loginWithEmailAndPassowrd();
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
                            AppStrings.login.toUpperCase(),
                            style: getRegularStyle(color: ColorManager.white),
                          ),
                        )),
                    SizedBox(
                      height: AppSize.s20.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.alreadyHaveAnAcounte,
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppStrings.register,
                            style: getMeduimStyle(color: ColorManager.blue),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppSize.s40.sp,
                    ),
                    const Spacer(),
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
