import 'dart:io';

import 'package:e_chat/Login_Pages/login_page.dart';
import 'package:e_chat/Utils/text_constants.dart';
import 'package:e_chat/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Set_Security_Dir/set_pin_security.dart';
import '../Utils/common_color.dart';
import '../Utils/common_widget.dart';
import '../Utils/firebase_firestore/firebase_helper.dart';
import '../Utils/firebase_firestore/firebase_key/firebase_key.dart';
import '../Utils/image_constants.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool typeStart = false;
  final ImagePicker picker = ImagePicker();
  String pickedImage = "";
  bool isRequested = false;


  Future<void> checkInfo() async {
    setState(() {
      isRequested = true;
    });
    try {
      firebaseHelper.updateData(data: {FirebaseKey.docId: docId});
      setState(() {
        isRequested = true;
      });

      firebaseHelper.updateData(
        data: {
          FirebaseKey.image: pickedImage.isNotEmpty
              ? pickedImage
              : CI.userLogoW,
          FirebaseKey.name: nameController.text,
        },
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SetPinSecurity(comingFrom : TextConstant.register),)
      );
    } catch (e) {
      print("Exception in checkInfo Method");
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
                        ? (typeStart
                              ? CI.loginBGClickL
                              : "assets/images/unClickBgUILig.png")
                        : (typeStart
                              ? CI.loginBGDark
                              : "assets/images/unCUIBGDark.png"),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  right: 16,
                  child: headerSection(),
                ),
              ],
            ),
            textFFInfo(),
          ],
        ),
      ),
    );
  }

  Widget headerSection() {
    return SizedBox(
      height: 350,
      child: Stack(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Container(
                  width: 127,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Theme.of(context).colorScheme.background,
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
                        "Login",
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
                  fontSize: 25
                ),
              ),
            ],
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 12,horizontal: 120),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CC.background.withOpacity(0.5),
                  border: pickedImage.isNotEmpty ? Border.all(color: CC.background,width: 2) : null
                ),
                child:ClipOval(

                  child: pickedImage.isNotEmpty
                      ? Image.file(
                          File(pickedImage),
                          fit: BoxFit.contain,
                          width: 60,

                        )
                      : Center(child: Image.asset(CI.userLogoW, width: 70)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 85,
            right: 125,

            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor:  Theme.of(context).colorScheme.onSecondary,
                      title: Center(child: const Text("Select Profile Pic")),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            pickImageFromGallery();
                            Navigator.pop(context);
                          },
                          child: Text('Gallery'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pickImageFromCamera();
                            Navigator.pop(context);
                          },
                          child: Text('Camera'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [CC.subPrimary, CC.accent]),
                ),
                child: Center(child: Image.asset(CI.editIcon, height: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textFFInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 57),
      child: Column(
        children: [
          TextFormField(
            onTap: () {
              setState(() {
                typeStart = true;
              });
            },
            onTapOutside: (event) {
              typeStart = false;
            },

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field cannot be empty";
              }
              return null;
            },

            controller: nameController,
            cursorColor: Theme.of(context).colorScheme.onTertiary,
            cursorHeight: 20,
            keyboardType: TextInputType.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              hintText: "Your Name",

              hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(

                color: Theme.of(
                  context,
                ).colorScheme.onSecondary.withOpacity(0.4),
              ),
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
              ),

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onTertiary,
                  width: 3,
                ),
              ),
              filled: false,
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 2,
                ),
              ),

              prefixIcon: SizedBox(
                height: 25,
                width: 25,
                child: Center(
                  child: Image.asset(
                    CI.userLogoB,
                    height: 22,
                    width: 22,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CW.commonEBEn(
                requested: isRequested,
                context: context,
                typing: typeStart,

                onTap: () {
                  if (globalKey.currentState!.validate()) {
                    checkInfo();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image?.path != null && image?.path != "") {
      setState(() {
        pickedImage = image!.path;
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image?.path != null && image?.path != "") {
      setState(() {
        pickedImage = image!.path;
      });
    }
  }
}
