import 'package:e_chat/bottom_nav_section/home_screen.dart';
import 'package:e_chat/bottom_nav_section/profile_nav.dart';
import 'package:flutter/material.dart';

import '../Utils/common_color.dart';
import '../Utils/image_constants.dart';
import 'more_nav.dart';
import 'groups_nav.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  bool selectedStyle = true;

  final List<Widget> screens =  [
    HomePage(),
    GroupsNav(),
    ProfileScreen(),
    MoreScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: screens[selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
           elevation: 0,
         fixedColor: Colors.transparent,
         type: BottomNavigationBarType.fixed,
         unselectedLabelStyle: TextStyle(fontSize: 12,color: CC.background),
         selectedLabelStyle: TextStyle(fontSize: 12,color: CC.background),
         currentIndex: selectedIndex,
           onTap: (index){
            setState(() {
                 selectedIndex = index;
            });
           },

           items: [
             BottomNavigationBarItem(
               activeIcon: Padding(
                 padding:  EdgeInsets.only(top: 10,left: 11),
                 child: Container(
                   width: 76,
                   height: 70,
                   decoration: BoxDecoration(
                     gradient: LinearGradient(colors: [CC.primary,CC.secondary]),
                     borderRadius: BorderRadius.circular(12)
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(CI.bChat,width: 24,),
                       SizedBox(height: 11,),
                       Text("Chats",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.background),)
                     ],
                   ),
                 ),
               ),

                 ///inactive Icon and text
                 icon: Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(CI.bChatIn,width: 24,color: CC.textSecondary,),
                       SizedBox(height: 11,),
                       Text("Chats",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.textSecondary),)
                     ],
                   ),
                 ),
                 label: ""
             ),


             BottomNavigationBarItem(
                 icon: Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(CI.cGroup,width: 24,color: CC.textSecondary,),
                       SizedBox(height: 11,),
                       Text("Groups",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.textSecondary))
                     ],
                   ),
                 ),
                 label: "",
               activeIcon:
                 Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Container(
                     width: 76,
                     height: 70,
                     decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [CC.primary,CC.secondary]),
                         borderRadius: BorderRadius.circular(12)
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset(CI.cGroup,width: 24,color: CC.background,),
                         SizedBox(height: 11,),
                         Text("Groups",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.background))
                       ],
                     ),
                   ),
                 )

             ),

             BottomNavigationBarItem(
                 icon: Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(CI.bProfile,width: 24,color: CC.textSecondary,),
                       SizedBox(height: 11,),
                       Text("Profile",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.textSecondary))
                     ],
                   ),
                 ),
                 label: "",
                 activeIcon:
                 Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Container(
                     width: 76,
                     height: 70,
                     decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [CC.primary,CC.secondary]),
                         borderRadius: BorderRadius.circular(12)
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset(CI.bProfile,width: 24,color: CC.background,),
                         SizedBox(height: 11,),
                         Text("Profile",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.background))
                       ],
                     ),
                   ),
                 )

             ),

             BottomNavigationBarItem(
                 icon: Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset(CI.bMore,width: 24,color: CC.textSecondary,),
                       SizedBox(height: 11,),
                       Text("More",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.textSecondary))
                     ],
                   ),
                 ),
                 label: "",
                 activeIcon:
                 Padding(
                   padding:  EdgeInsets.only(top: 10,left: 11),
                   child: Container(
                     width: 76,
                     height: 70,
                     decoration: BoxDecoration(
                         gradient: LinearGradient(colors: [CC.primary,CC.secondary]),
                         borderRadius: BorderRadius.circular(12)
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Image.asset(CI.bMore,width: 24,color: CC.background,),
                         SizedBox(height: 11,),
                         Text("More",style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 12,color: CC.background))
                       ],
                     ),
                   ),
                 )

             ),

           ]

       ),
    );
  }
}