import 'dart:async';
import 'dart:math';

import 'package:e_chat/Login_Pages/login_page.dart';
import 'package:e_chat/Login_Pages/user_information.dart';
import 'package:flutter/material.dart';
import '../Utils/common_widget.dart';

import '../Utils/firebase_firestore/firebase_key/firebase_key.dart';
import '../Utils/image_constants.dart';
import '../Utils/text_constants.dart';
import '../main.dart';

class UserSignUpOtp extends StatefulWidget {

  String phoneNumber;
  UserSignUpOtp({super.key,required this.phoneNumber});

  @override
  State<UserSignUpOtp> createState() => _UserSignUpOtpState();
}

class _UserSignUpOtpState extends State<UserSignUpOtp> {
  TextEditingController otpController = TextEditingController();

  int countDown = 30;
  String? savedOtp;
  bool isRequested = false;
  bool typeStart =false;




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

    Future.delayed(Duration(milliseconds: 200), ()
    {
      CW.showToast(
        msg: otp.toString(),
        context: context,
      );
    });



    print("RandomOtp::::::::::::::::${otp.toString()}");

    return otp.toString();
  }


  Future<void> checkOtp()
  async{
    try{
      setState(() {
        isRequested = true;
      });
     var data = await firebaseHelper.getData();

     setState(() {
       savedOtp = data![FirebaseKey.otp];
       

     });
     print("FirebaseOTP::::::::::::::::::::::$savedOtp");
     print("UserOtp::::::::::::::::::::::${otpController.text}");

     if(savedOtp == otpController.text)
       {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserInformation()));
       }
     else
       {
         CW.showToast(msg: "Invalid otp", context: context,);
       }
    }
    catch(e)
    {
       print("Exception in SignUp Otp Page - checkOtp ::::$e");
    }
    finally{
      isRequested =false;
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
      body: Column(
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
         CW.commonPCF(context: context,controller: otpController, isTyping: (typeStarts) {
           setState(() {
             typeStart = typeStarts;
           });
         },),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CW.commonEBEn(
                context: context,
                requested: isRequested,
                onTap: () {
                  checkOtp();
                  },
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget timerSection()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(CI.timerWatch,height: 20,color: Theme.of(context).colorScheme.onSecondary,),
          SizedBox(width: 5,),

      Text('00:${countDown.toString().padLeft(2,'0')}',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
                ),
          SizedBox(width: 12,),
          TextButton(
            onPressed:()
            {
              startTimer();

            }
            ,
            child: countDown > 0 ? Text("Resend Code",style:
            Theme.of(context).textTheme.headlineLarge?.copyWith(decorationColor: Theme.of(context).colorScheme.onSecondary,decoration: TextDecoration.underline,decorationThickness: 2,fontSize: 16,color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4)),)
                :Text("Resend Code",style:
            Theme.of(context).textTheme.headlineLarge?.copyWith(decorationColor: Theme.of(context).colorScheme.onSecondary,decoration: TextDecoration.underline,fontSize: 16,color: Theme.of(context).colorScheme.onSecondary) ,
            ),)
        ],
      ),
    );

  }



  Widget headerSection(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              InkWell(
                onTap:()
               {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
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
                      Image.asset(CI.leftARB, width: 24,color: Theme.of(context).colorScheme.onPrimary,),
                      SizedBox(width: 14),
                      Text(
                        TextConstant.login,
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Text(
                TextConstant.register,
                style:Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface,letterSpacing: 2),
              ),
            ],
          ),
          SizedBox(height: 24),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Enter OTP Code",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(letterSpacing: 2,color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Sent to : (${CW.dialCode})",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 20,color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.phoneNumber,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(letterSpacing: 2,color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              )

            ],
          ),


        ],
      ),
    );
  }
}
