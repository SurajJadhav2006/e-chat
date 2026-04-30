import 'package:e_chat/Utils/text_constants.dart';
import 'package:flutter/material.dart';

import '../Dashboard_Pages/home_screen.dart';
import '../Utils/common_color.dart';
import '../Utils/common_widget.dart';
import '../Utils/image_constants.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          topSection(),
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 20, right: 20,bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name Group",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,

                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Name Group",
                    hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onInverseSurface.withOpacity(0.4),
                    ),

                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 4.1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff7A7D9C),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Members",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffECF9FF)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(CI.add,color: CC.primary,width: 36,),
                      SizedBox(width: 8,),
                      Text("Add members to group",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CC.primary),)
                    ],
                  ),
                ),
                Spacer(),
                CW().commonButton(title: "Create Group", onTap: (){}, context: context)
              ],
            ),
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
                "Create Group",
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
