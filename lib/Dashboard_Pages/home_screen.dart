import 'package:e_chat/add_friends_group/add_friends.dart';
import 'package:flutter/material.dart';

import '../Utils/common_color.dart';
import '../Utils/image_constants.dart';
import '../add_friends_group/create_group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  bool isOpened = true;
  bool isSearch = false;
  List<UserChats> userList = [
    UserChats(
      image: "assets/images/User.png",
      title: "David Wayne",
      subTitle: "Thanks a bunch! Have a great day! 😊",
      date: "",
      time: "10.25",
      msgCount: "5",
    ),
    UserChats(
      image: "assets/images/User.png",
      title: "Edward Davidson",
      subTitle: "Great, thanks so much! 💫",
      date: "09/05",
      time: "22:20",
      msgCount: "12",
    ),
    UserChats(
      image: "assets/images/User.png",
      title: "Angela Kelly",
      subTitle: "Appreciate it! See you soon! 🚀",
      date: "08/05",
      time: "10:45",
      msgCount: "3",
    ),
    UserChats(
      image: "assets/images/User.png",
      title: "Jean Dare",
      subTitle: "Hooray! 🎉",
      date: "05/05",
      time: "20:10",
      msgCount: "",
    ),
    UserChats(
      image: "assets/images/User.png",
      title: "Dennis Borer",
      subTitle: "Your order has been successfully delivered",
      date: "05/05",
      time: "17:02",
      msgCount: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return userData(userList: userList[index], context: context);
              },
            ),
          ),
          topSection(),
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

  Widget userData({
    required UserChats userList,
    required BuildContext context,
  }) {
    return ListTile(
      leading: ClipOval(child: Image.asset(userList.image!)),
      title: Text(
        userList.title!,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      subtitle: Text(
        userList.subTitle!,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: CCDark.textIcon, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${userList.time!} ${userList.date!}",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 12,
              color: CCDark.textIcon,
            ),
          ),
          SizedBox(height: 10),

          if (userList.msgCount?.isNotEmpty ?? false)
            Container(
              width: 16,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: CC.primary,
              ),
              child: Center(
                child: Text(
                  userList.msgCount.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class UserChats {
  String? image;
  String? title;
  String? subTitle;
  String? date;
  String? time;
  String? msgCount;

  UserChats({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.time,
    required this.msgCount,
  });
}

//
