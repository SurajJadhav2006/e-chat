import 'package:e_chat/Login_Pages/user_information.dart';
import 'package:e_chat/Set_Security_Dir/set_fingerprint_security.dart';
import 'package:e_chat/Utils/firebase_firestore/firebase_helper.dart';
import 'package:e_chat/Utils/firebase_firestore/firebase_key/firebase_key.dart';
import 'package:e_chat/Utils/text_constants.dart';
import 'package:e_chat/main.dart';
import 'package:flutter/material.dart';
import 'package:pin_code/pin_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard_Pages/dashboard_screen.dart';
import '../Utils/common_color.dart';
import '../Utils/common_widget.dart';
import '../Utils/image_constants.dart';

class SetPinSecurity extends StatefulWidget {
  String comingFrom;
   SetPinSecurity({super.key,required this.comingFrom});

  @override
  State<SetPinSecurity> createState() => _SetPinSecurityState();
}

class _SetPinSecurityState extends State<SetPinSecurity> {
  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String? savedPin; //store value and check
  bool showSkip = false; //btn skip
  bool isConformPin = true;
  String heading = "PIN Security";
  String? storedPin;
  bool isRequested = false;
  String? pin;



  @override
  void initState() {
    super.initState();
    checkPin();
  }
  Future<void> checkPin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
     pin = await pref.getString('user_pin');
    if (widget.comingFrom == TextConstant.register)
    {
      setState(() {
        showSkip = true;
      });
    } else {
      setState(() {
        showSkip = false;  //2 time false
      });
    }
  }

  Future<void> comingFrom()
  async {
    setState(() {
      isRequested =true;
    });
    try{
      if(widget.comingFrom == TextConstant.register )
      {
        print("SetPing Method Call");

        setNewPin();

      }
      else if(widget.comingFrom == TextConstant.splash)
      {
        verifyPin();
      }
      else
      {
        verifyPin();
      }
    }
    catch(e)
    {
      print("Exception in comintFrom Method");
    }
    finally{
      setState(() {
        isRequested =true;
      });
    }

  }


  Future<void> setNewPin() async {
    setState(() {
      isRequested =true;
    });
    try {
      print("SetNewPin Method Call");
      print("PIN:::::::::::::::::${pinController.text}");

      firebaseHelper.updateData(data: {FirebaseKey.pin: pinController.text});
      print("PIN:::::::::::::::::${pinController.text}");


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));

    } catch (e)
    {
      print("Exception in setNewPin Method");
    }
    finally{
      isRequested =false;
    }
  }

  Future<void> verifyPin() async {
    setState(() {
      isRequested =true;
    });
    try {
      print("Verify Method Call");
      String newPin = pinController.text;
      if(newPin.isEmpty) return ;
      var data = await FirebaseHelper().getData();
      setState(() {
        storedPin = data![FirebaseKey.pin];
      });
      if (newPin == storedPin)
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
      } else
      {
        CW.showToast(msg: "Wrong PIN", context: context);
      }
    } catch (e)
    {
      print("Exception in verify Method $e");
    }
    finally{
      setState(() {
        isRequested =false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SafeArea(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                headerSection(),
                SizedBox(height: 32),
                Text(
                  "Protect your account with a secure PIN",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 32),
                bioMetricPin(),
                Spacer(),
                Row(
                  children: [
                    if (showSkip)
                      Expanded(
                        child: CW().commonButton(
                          isRequested: isRequested,
                          context: context,
                          isContinue: false,
                          title: "Skip",
                          textColor: Color(0xff3AB2E8),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DashboardScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    if (showSkip)
                      SizedBox(width: 16),
                    Expanded(
                      child: CW().commonButton(
                        context: context,
                        title: "Continue",
                        onTap: ()   {
                                       if (globalKey.currentState!.validate()) {
                                         comingFrom();
                                       }

                                     },
                        isRequested: isRequested,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bioMetricPin() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: PinCode(
        onCompleted: (event) async {
          SharedPreferences pref = await SharedPreferences.getInstance();

           if(pin != null)
             {
               print("Verify Method Call:::");
               verifyPin();
             }
       else if (isConformPin)
          {
            print("SetNewPin Method Call:::::");
            if (pinController.text.length == 4 && savedPin == null) {
              setState(() {
                heading = "Conform Pin";
                savedPin = pinController.text;
                pinController.clear();
              });
            } else {
              if (savedPin == pinController.text) {
                await pref.setString('user_pin', pinController.text);

                  setNewPin();

              } else {
                CW.showToast(msg: "PIN does not match", context: context);
                pinController.clear(); // kabhi match nhi hua to clear karo
              }
            }
          }

        },
        controller: pinController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter PIN";
          }
          if (value.length != 4)
          {
            return "Enter 4 digit PIN";
          }
          return null;
        },
        appContext: context,
        length: 4,
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onTertiary,
          fontSize: 39,
        ),
        showCursor: false,
        pinTheme: PinCodeTheme(
          fieldHeight: 60,
          fieldWidth: 68,
          inactiveBorderWidth: 3,
          activeBorderWidth: 3,
          selectedBorderWidth: 3,
          inactiveColor: Theme.of(context).colorScheme.onTertiary,
          activeColor: Theme.of(context).colorScheme.onTertiary,
          selectedFillColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.2),
          errorBorderColor: Theme.of(context).colorScheme.error,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 24),
      ),
    );
  }


  //  HEADER
  Widget headerSection() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UserInformation()),
            );
          },

          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.1),
            ),
            child: Center(
              child: Image.asset(
                CI.leftARB,
                color: Theme.of(context).colorScheme.onSecondary,
                width: 16,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              heading,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ],
    );
  }
}
