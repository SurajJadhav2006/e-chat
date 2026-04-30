import 'dart:async';
import 'dart:math';

import 'package:e_chat/Dashboard_Pages/home_screen.dart';
import 'package:e_chat/Login_Pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Set_Security_Dir/set_pin_security.dart';
import '../Utils/common_widget.dart';
import '../Utils/firebase_firestore/firebase_key/firebase_key.dart';
import '../Utils/image_constants.dart';
import '../Utils/text_constants.dart';
import '../main.dart';

class OtpPage extends StatefulWidget {
  String phoneNumber;

   OtpPage({super.key, required this.phoneNumber});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  bool typeStart = false;
  int countDown = 30;
  bool isRequested =false;
  String? savedOtp;
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    startTimer();
    generate4DigitOtp();
  }

  Future<String> generate4DigitOtp()
  async {
    final random = Random();
    int otp = 1000 + random.nextInt(9000);

    firebaseHelper.updateData(data: {
      FirebaseKey.otp : otp.toString()
    });
    Future.delayed(Duration(milliseconds: 200),()
        {
          CW.showToast(msg: otp.toString(), context: context);
        });

    print("RandomOtp::::::::::::::::${otp.toString()}");

    return otp.toString();
  }



  Future<void> checkOtp()async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool  isLogin =  pref.getBool("isLogin") ?? false;


    try{
      var data = await firebaseHelper.getData();
      setState(() {

        isRequested = false;
        savedOtp = data!.data()?[FirebaseKey.otp];
      });

      print("FirebaseOTP::::::::::::::::::::::$savedOtp");
      print("UserOtp::::::::::::::::::::::${otpController.text}");

        if(savedOtp == otpController.text)
        {
          if (isLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => SetPinSecurity(comingFrom: "login",)),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          }
        }
      else
        {
           CW.showToast(msg: "Invalid otp", context: context,);
        }


    }
    catch(e)
    {
      print("Exception in checkOtp Method $e");

    }

  }






  void startTimer()
  {
   setState(() {
      countDown = 30;
    });
    Timer.periodic(const Duration(seconds: 1), (timer)
    {
     if(countDown > 0)
       {
         setState(() {
           countDown--;
         });
       }
     else
       {
         setState(() {
           countDown = 0 ;
         });
         timer.cancel();
       }


    });
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
                Positioned(
                  child:  Image.asset(Theme.of(context).brightness == Brightness.light ? CI.loginBGClickL : CI.loginBGDark,),
                ),

                Positioned(top: 50, left: 0, right: 0, child: headerSection()),


              ],
            ),
            SizedBox(height: 51,),
            timerSection(),

            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  typeStart = false;
                });
              },
              child: CW.commonPCF(

                context: context,
                controller: otpController,
                isTyping: (typeStarts) {
                  setState(() {
                    typeStart = typeStarts;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CW.commonEBEn(
                  context: context,
                  typing: typeStart,
                  onTap: () {
                    if(globalKey.currentState?.validate() ?? false)
                      {
                        checkOtp();
                      }



                  },
                ),


              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget timerSection()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(CI.timerWatch, height: 20,color: Theme.of(context).colorScheme.onSecondary,),
          SizedBox(width: 5),

          Text('00:${countDown.toString().padLeft(2,'0')}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          SizedBox(width: 12),

          TextButton(
            onPressed:()
              {
                setState(() {
                 if (countDown == 0) {
                   generate4DigitOtp();
                   startTimer();
                 }
               });

              }
               ,
            child: countDown > 0 ? Text("Resend Code",style:
            Theme.of(context).textTheme.headlineLarge?.copyWith(decoration: TextDecoration.underline,decorationColor: Theme.of(context).colorScheme.onSecondary,decorationThickness: 2,fontSize: 16,color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4)),)
                :Text("Resend Code",style:
            Theme.of(context).textTheme.headlineLarge?.copyWith(decorationColor: Theme.of(context).colorScheme.onSecondary,decoration: TextDecoration.underline,fontSize: 16,color: Theme.of(context).colorScheme.onSecondary,) ,
          ),)
        ],
      ),
    );
  }

  Widget headerSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                TextConstant.login,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(letterSpacing: 2,color: Theme.of(context).colorScheme.onSurface),
              ),
              Spacer(),
              InkWell(
                onTap: (){

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignupPage()));
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
                     TextConstant.register,
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
            "Enter OTP Code",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(letterSpacing: 2,color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Sent to : (${CW.dialCode})",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontSize: 18,color: Theme.of(context).colorScheme.onSurface),
              ),
              SizedBox(width: 10),
              Text(
                widget.phoneNumber,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(letterSpacing: 2,color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
