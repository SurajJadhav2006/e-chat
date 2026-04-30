
import 'package:e_chat/Login_Pages/login_page.dart';

import 'package:e_chat/Set_Security_Dir/set_pin_security.dart';
import 'package:e_chat/Utils/firebase_firestore/firebase_key/firebase_key.dart';
import 'package:e_chat/Utils/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/image_constants.dart';
import '../main.dart';
import 'onboarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? isPin;

  @override
  void initState() {
    super.initState();
      navigate();
  }

  Future<void> navigate() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool isOnBoarding = pref.getBool(FirebaseKey.onBoarding) ?? false;
      var data = await firebaseHelper.getData();
      bool isLogin = pref.getBool(FirebaseKey.login) ?? false;

      if (data != null && (data.data()?.isNotEmpty ?? false)) {
        setState(() {
          isPin = data[FirebaseKey.pin]; //// OR cast data as a Map to access the field
          // isPin = data.get(FirebaseKey.pin);     //// Use the .get() method to extract a specific field
        });
      }
      await Future.delayed(const Duration(seconds: 2));

      if(isLogin)
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SetPinSecurity(comingFrom: TextConstant.splash),
          ),
        );
      } else if (!isLogin && isOnBoarding) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OnboardingPage()),
        );
      }
    } catch (e) {
      print("Exception in Navigate Method  $e");
    }
  }

  Future<void> changeThemeModes(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", mode.name);
    themeNotifier.value = mode;
    print("Change ThemeMode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
            //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? CI.appLogoDark
                      : CI.appLogo,
                  width: 235.21,
                ),
              Spacer(),
                Image.asset(
                  Theme.of(context).brightness == Brightness.light
                      ? CI.slashL
                      : CI.slashD,
                  width: 268,
                ),
                Spacer(),

                /// VERSION TEXT
                Text(
                  "Version 2.1.0",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
