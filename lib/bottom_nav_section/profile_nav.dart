import 'package:flutter/material.dart';

import '../Utils/common_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 110,
                    color: CC.appBar,
                  ),
                ),


                Positioned.fill(
                    left: 0,
                    right: 0,
                    top: 20,
                    child: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),

                          gradient: LinearGradient(
                              colors: [CC.background.withOpacity(0),CC.background.withOpacity(0.2),
                              ])
                      ),
                    ))
              ]  ),
        ),),

    );
  }
}
