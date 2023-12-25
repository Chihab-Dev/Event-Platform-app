import 'package:event_platform_app/presentation/resources/color_manager.dart';
import 'package:event_platform_app/presentation/resources/strings_manager.dart';
import 'package:event_platform_app/presentation/resources/styles_manager.dart';
import 'package:event_platform_app/presentation/resources/values_manager.dart';
import 'package:event_platform_app/presentation/resources/widgets.dart';
import 'package:event_platform_app/presentation/screens/login/cubit/login_cubit.dart';
import 'package:event_platform_app/presentation/screens/login/cubit/login_state.dart';
import 'package:event_platform_app/presentation/screens/main/view/main_view.dart';
import 'package:event_platform_app/presentation/screens/register/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainView(),
                ),
                (route) => false);
          }
          if (state is LoginErrorState) {
            errorToast(state.error).show(context);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p20.sp),
                child: SingleChildScrollView(
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
                        AppStrings.welcome,
                        style: getlargeStyle(color: ColorManager.blue),
                      ),
                      SizedBox(
                        height: AppSize.s50.sp,
                      ),
                      customFormField(
                        textEditingcontroller: cubit.emailTextEditingcontroller,
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
                        textEditingcontroller: cubit.passwordTextEditingcontroller,
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
                      state is LoginLoadingState
                          ? CircularProgressIndicator(
                              color: ColorManager.blue,
                            )
                          : customElevatodButton(
                              AppStrings.login,
                              (cubit.isEmailValid && cubit.isPasswordValid)
                                  ? () {
                                      cubit.loginWithEmailAndPassowrd();
                                    }
                                  : null,
                            ),
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
                                  ));
                            },
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
