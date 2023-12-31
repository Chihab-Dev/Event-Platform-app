import 'package:event_platform_app/core/services/app_preferences.dart';
import 'package:event_platform_app/core/services/services_locator.dart';
import 'package:event_platform_app/presentation/screens/login/view/login_view.dart';
import 'package:event_platform_app/presentation/screens/main/view/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await ServicesLocator().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppPrefrences appPrefrences = AppPrefrences(getIt());
    bool isUserLoggedIn = appPrefrences.isUserLoggedIn();

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isUserLoggedIn ? const MainView() : const LoginView(),
      ),
    );
  }
}
