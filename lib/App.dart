import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_sahha_example/screens/MainScreen.dart';
import 'package:my_sahha_example/screens/SplashScreen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            primarySwatch: Colors.blue,
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.black,
              cursorColor: Colors.black,
              selectionHandleColor: Colors.black,
            ),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
      // child: const MainScreen(),
    );
  }
}
