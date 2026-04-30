import 'package:flutter/material.dart';

import '../Utils/common_color.dart';
import '../Utils/image_constants.dart';
import '../add_friends_group/add_friends.dart';
import '../add_friends_group/create_group.dart';

class GroupsNav extends StatefulWidget {
  const GroupsNav({super.key});

  @override
  State<GroupsNav> createState() => _GroupsNavState();
}

class _GroupsNavState extends State<GroupsNav> {
  bool isSearch = false;
  bool isOpened = true;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [
          topSection()
        ],
      ) ,
    );
  }


  Widget topSection() {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            child: Container(

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
          isSearch ? SizedBox() : Image.asset(CI.appLogoDark, width: 92.26),
          Expanded(
            child: isSearch
                ? Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 43,
                child: TextFormField(
                  controller: searchController,
                  cursorColor: Theme.of(context).colorScheme.background,
                  cursorHeight: 20,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: CC.surface.withOpacity(0.3),fontSize: 16,fontWeight: FontWeight.w400,),
                    filled: true,
                    fillColor: CC.background,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            )
                : SizedBox(),
          ),

          if (!isSearch)
            InkWell(
              onTap: () {
                setState(() {
                  isSearch = true;
                });
              },
              child: Image.asset(CI.search, width: 24),
            ),
          SizedBox(width: 16),
          isSearch ?
          InkWell(
            onTap: () {
              setState(() {
                isSearch = false;
                searchController.clear();
              });
            },
            child: Image.asset(CI.cancelCon),
          ) :
          popUp(),


        ],
      ),
    );
  }
  Widget popUp() {
    return PopupMenuButton(
      onOpened: () {
        setState(() {
          isOpened = !isOpened;
        });
      },
      onCanceled: () {
        setState(() {
          isOpened = !isOpened;
        });
      },
      constraints: BoxConstraints.tightFor(width: 250),

      icon: Image.asset(
        isOpened ? CI.add : CI.cancelCon,
        width: isOpened ? 30 : 40,
      ),
      offset: Offset(-20, 50),

      itemBuilder: (context) {
        return <PopupMenuEntry<dynamic>>[
          PopupMenuItem(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddFriends()),
              );
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/addUserl.png",
                  width: 24,
                  color: CC.icon,
                ),
                SizedBox(width: 16),
                Text(
                  "Add Friend",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),

          PopupMenuItem(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CreateGroup()));
            },
            child: Row(
              children: [
                Image.asset(CI.cGroup, width: 24),
                SizedBox(width: 16),
                Text(
                  "Create Group",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
