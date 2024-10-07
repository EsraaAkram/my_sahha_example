import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_sahha_example/screens/ProfileScreen.dart';
import 'package:sahha_flutter/sahha_flutter.dart';

import '../Constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _externalIdController = TextEditingController(text: externalId);

  void _authenticate() {
    String externalId = _externalIdController.text;
    if (externalId.isNotEmpty) {
      onTapSave(context);
    } else {
      // Show an error if the externalId is empty
      print('ExternalId is empty.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   title: Text('Authentication'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _externalIdController,
              decoration: InputDecoration(
                labelText: 'External ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 45.h),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _externalIdController.dispose();
    super.dispose();
  }

  onTapSave(BuildContext context) {
    if (_externalIdController.text.isEmpty) {
      // showAlertDialog(
      //     context, 'MISSING INFO', "You need to input an EXTERNAL ID");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('MISSING INFO, You need to input an EXTERNAL ID'),
        ),
      );
    } else {
      SahhaFlutter.authenticate(
              appId: appId,
              appSecret: appSecret,
              externalId: _externalIdController.text)
          .then((success) {
        showAlertDialog(context, 'AUTHENTICATED', success.toString());

        //setPrefs();
      }).catchError((error, stackTrace) {
        debugPrint(error.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      });
    }
  }

  showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            SahhaFlutter.enableSensors([
              SahhaSensor.sleep,
              SahhaSensor.step_count,
              SahhaSensor.heart_rate
            ]).then((value) {
              debugPrint('Enable Some Sensors ' + value.toString());
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                  (Route<dynamic> route) => false);
            }).catchError((error) {
              debugPrint(error.toString());

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                ),
              );
            });
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
