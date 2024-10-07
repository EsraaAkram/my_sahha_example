import 'package:flutter/material.dart';
import 'package:my_sahha_example/screens/MainScreen.dart';
import 'package:sahha_flutter/sahha_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthScreen.dart';
import 'ProfileScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // // Use default values
    // SahhaFlutter.configure(
    //   environment: SahhaEnvironment.sandbox,
    // )
    //     .then((success) => {debugPrint(success.toString())})
    //     .catchError((error, stackTrace) => {debugPrint(error.toString())});

/*
    // Android only
    var notificationSettings = {
      'icon': 'Custom Icon',
      'title': 'Custom Title',
      'shortDescription': 'Custom Description'
    };

    // Use custom values
    SahhaFlutter.configure(
            environment: SahhaEnvironment.production,
            sensors: [SahhaSensor.device],
            notificationSettings: notificationSettings)
        .then((success) => {debugPrint(success.toString())})
        .catchError((error, stackTrace) => {debugPrint(error.toString())});
        */

    // Check if the user is authenticated
    SahhaFlutter.isAuthenticated().then((isAuthenticated) async {
      if (isAuthenticated) {
        final prefs = await SharedPreferences.getInstance();

        if (prefs.getString('age') == null ||
            prefs.getString('gender') == null) {
          //GO TO EDIT PROFILE
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else {
          // If authenticated, navigate to HomeView
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      } else {
        // If not authenticated, navigate to Authentication
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    }).catchError((error) {
      debugPrint(error.toString());
      // In case of error, navigate to Authentication
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
