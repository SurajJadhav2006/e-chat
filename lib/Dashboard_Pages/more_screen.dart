import 'package:flutter/material.dart';

import '../Utils/common_color.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
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
