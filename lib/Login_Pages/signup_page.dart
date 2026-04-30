

import 'package:e_chat/Login_Pages/signup_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/common_widget.dart';
import '../Utils/firebase_firestore/firebase_key/firebase_key.dart';
import '../Utils/image_constants.dart';
import '../Utils/text_constants.dart';
import '../main.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController phoneController = TextEditingController();
  bool isClick = true;
  bool isRequested = false;
  bool typeStart = false;
  bool? isSignUp;
  GlobalKey<FormState> globalKey = GlobalKey();

  Future<void> signup() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        isRequested = true;
      });

      isSignUp = await firebaseHelper.checkIfNumberExists(phoneController.text);

      if (isSignUp!)
      {
        firebaseHelper.createData(
          data: {FirebaseKey.phoneNumber: phoneController.text},
        );

        await Future.delayed(Duration(seconds: 2));
        pref.setBool(FirebaseKey.login, true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserSignUpOtp(phoneNumber: phoneController.text),
          ),
        );
        print("${phoneController.text} This number is create in firestore");
        print('SignUp SuccessFully');
      } else {
        CW.showToast(
          context: context,
          msg: "This Number is already registered",
        );
      }
    } catch (e) {
      print("Exception in SignUp Method ::::::::::::::: $e");
    } finally {
      setState(() {
        isRequested = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
              Positioned(left: 20, right: 15, child: headerSection()),
            ],
          ),
          formSection(),
        ],
      ),
    );
  }

  // Form section
  Widget formSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          SizedBox(height: 48),
          Text(
            "You will get a code via sms.",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
              if (value == null) {
                return "please Enter your Number";
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

  // == BOTTOM ROW ====
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
              ? Image.asset(
                  CI.checkB,
                  width: 24,
                  color: Theme.of(context).colorScheme.onTertiary,
                )
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
          requested: isRequested,
          context: context,
          typing: typeStart,
          onTap: () {
            signup();
          },
        ),
      ],
    );
  }

  //Header Section
  Widget headerSection() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Container(
                  width: 127,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        CI.leftARB,
                        width: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      SizedBox(width: 14),
                      Text(
                        TextConstant.login,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Register",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: 2,
                  fontSize: 25

                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Enter your\nmobile phone",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  letterSpacing: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 25
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
