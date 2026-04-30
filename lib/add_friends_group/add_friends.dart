import 'dart:io';

import 'package:e_chat/bottom_nav_section/home_screen.dart';
import 'package:e_chat/Utils/firebase_firestore/firebase_helper.dart';
import 'package:flutter/material.dart';

import '../Utils/common_color.dart';
import '../Utils/common_widget.dart';
import '../Utils/firebase_firestore/firebase_key/firebase_key.dart';
import '../Utils/image_constants.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  TextEditingController nuController = TextEditingController();
  List numbers = [];
  bool isImage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          topSection(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 120, left: 18, right: 18),
                child: CW.commonTFFU(
                  context: context,
                  hintText: "Enter Phone Number",
                  controller: nuController,
                  isBorder: false,
                  onChanged: (p0) async {
                    var a = await FirebaseHelper.searchUsersByNumber(
                      controller: nuController,
                    );
                    numbers.clear();
                    numbers.addAll(a);
                    setState(() {});
                  },
                ),
              ),

              if (numbers.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: 18,
                  ),
                  child: Image.asset(CI.cardSearch),
                ),

              Expanded(
                child: ListView.builder(
                  itemCount: numbers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 60,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: CC.primary),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child:
                              numbers[index][FirebaseKey.image] != null &&
                                  (!numbers[index][FirebaseKey.image]
                                      .toString()
                                      .contains("assets"))
                              ? Image.file(
                                  File(numbers[index][FirebaseKey.image]),
                                  width: 30,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  numbers[index][FirebaseKey.image],
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      title: Text(
                        numbers[index][FirebaseKey.name],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      subtitle: Text(
                        numbers[index][FirebaseKey.phoneNumber],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: CCDark.textIcon,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: CC.background.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Image.asset(
                            CI.aUser,
                            color: CC.primary,
                            width: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget topSection() {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 55),
              color: CC.appBar,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 55),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                gradient: LinearGradient(
                  colors: [
                    CC.background.withOpacity(0),
                    CC.background.withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ),

          Positioned(child: appBarSection()),
        ],
      ),
    );
  }

  Widget appBarSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: CC.background.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Image.asset(CI.backAL, width: 26)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Add Friend",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: CC.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
