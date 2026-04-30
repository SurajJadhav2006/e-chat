import 'package:e_chat/Login_Pages/login_otp.dart';
import 'package:e_chat/Login_Pages/signup_page.dart';
import 'package:e_chat/Utils/firebase_firestore/firebase_key/firebase_key.dart';
import 'package:e_chat/Utils/text_constants.dart';
import 'package:e_chat/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/common_widget.dart';
import '../Utils/image_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool typeStart = false;
  bool isClick = true;
  String? saveNumber;
  bool isRequested = false;
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  Future<void> checkLogin() async {
    try {
      print("checkLoginMethod called");

      SharedPreferences pref = await SharedPreferences.getInstance();
      var data = await firebaseHelper.getData();
      setState(() {
        isRequested = true;
      });

      if (data!.exists) {

        setState(() {
          saveNumber = data[FirebaseKey.phoneNumber];
        });
        print("FirebaseSave Number::::::::::::::::::::::$saveNumber");
        print("UserNumber::::::::::::::::::::::${phoneController.text}",);

        if (saveNumber == phoneController.text) {

          pref.setBool("isLogin", true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(phoneNumber: phoneController.text),
            ),
          );
        }
        else {
          CW.showToast(context: context, msg: "Please register first");
        }
      } else {
        CW.showToast(context: context, msg: "Please register first");
      }
    } catch (e) {
      print("Exception in checkLogin Method $e");
    } finally {
      isRequested = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: globalKey,
        child: Column(
          children: [
            Stack(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Image.asset(
                    Theme.of(context).brightness == Brightness.light
                        ? (typeStart ? CI.loginBGClickL : CI.loginBGUnL)
                        : (typeStart ? CI.loginBGDark : CI.loginBGUnDark),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 16,
                  right: 16,
                  child: headerSection(),
                ),
              ],
            ),
            SizedBox(height: 48),
            SizedBox(child: formSection()),
          ],
        ),
      ),
    );
  }

  // Form section
  Widget formSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: [
          Text(
            "You will get a code via sms.",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
          ),
          SizedBox(height: 24),
          CW.commonTFFU(
            context: context,
            isTyping: (typeStarts) {
              setState(() {
                typeStart = typeStarts;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your number";
              }
              return null;
            },
            controller: phoneController,
            hintText: '00 0000 0000',
          ),
          SizedBox(height: 24),
          _bottomRow(),
        ],
      ),
    );
  }

  // ==== BOTTOM ROW ====
  Widget _bottomRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isClick = !isClick;
            });
          },
          child: isClick
              ? Image.asset(CI.checkB, width: 24)
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                ),
        ),
        SizedBox(width: 12),
        Text(
          "Remember me",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),

        Spacer(),
        CW.commonEBEn(
          context: context,
          typing: typeStart,

          requested: isRequested,
          onTap: () {
            print("Button clicked");
            if (globalKey.currentState?.validate() ?? false) {
              checkLogin();
            }
          },
        ),
      ],
    );
  }

  Widget headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              TextConstant.login,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                letterSpacing: 2,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SignupPage()),
                );
              },
              child: Container(
                width: 112,
                height: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Text(
          "Enter your\nmobile phone",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            letterSpacing: 2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
