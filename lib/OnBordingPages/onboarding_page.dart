import 'package:e_chat/Login_Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/common_color.dart';
import '../Utils/common_widget.dart';
import '../Utils/image_constants.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  PageController controller = PageController();

  List<Data> data = [
    Data(
      caption: "Connect with multiple members in group chats.",
      title: "Group Chatting",
      image: "assets/images/group_chat.png",
    ),
    Data(
      caption: "Instantly connect via video and voice calls.",
      title: "Video and Voice Calls",
      image: "assets/images/video_voice_calls.png",
    ),
    Data(
      caption: "Ensure privacy with encrypted messages.",
      title: "Message Encryption",
      image: "assets/images/msg_encryption.png",
    ),
    Data(
      caption: "Access chats on any device seamlessly.",
      title: "Cross-Platform Compatibility",
      image: "assets/images/cross_platform_compatibility.png",
    ),

  ];

  Future<void> completeOnboarding() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("onboarding", true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Stack(
            children: [
              Positioned(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? CI.onBorDarkBG
                      : CI.onBorBG,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: onBoardingSection()),
            ],),
            SizedBox(height: 40,),
            CW.commonEBST(
                  context: context ,
                  text: "Get Started",
                  colorT:Theme.of(context).colorScheme.background,
                  onTap: (){
                    completeOnboarding();
                  }),
           Spacer(),
            bottomSection()
          ],
        )
    );
  }


Widget onBoardingSection()
{
  return  SafeArea(
    child: PageView.builder(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: data.length ,
    
        itemBuilder: (context,index)
        {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
            child: Column(
              children: [
                Image.asset(data[index].image,height: 200,),
                SizedBox(height: 74,),
                Text(data[index].title,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.w900),),
                SizedBox(height: 12,),
                Text(data[index].caption,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize:18,color: Theme.of(context).colorScheme.primary )),
              ],
            ),
          );
    
        }
    ),
  );
}

  Widget bottomSection()
  {

    return Padding(
      padding: const EdgeInsets.only(left: 24,right: 24,bottom: 45),
      child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                setState(() {
                  controller.animateToPage(data.length - 1, duration: Duration(milliseconds: 100), curve: Curves.ease);  //direct last indext pe swap
                });
              },
              child: Text("Skip",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500,  color: Color(0xff3AB2E8),))),

          Row(
            children: List.generate(data.length, (index)
            {
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: currentIndex == index
                      ? Border.all(color: Color(0xff7FD7FF), width: 2)
                      : null,
                  color: currentIndex == index ?CC.primary :Color(0xff7FD7FF),
                ),
              );
            }),
          ),

          InkWell(
            onTap: (){
              setState(() {
                if(currentIndex < data.length - 1)
                {
                  controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.ease);
                }
                else
                {
                  completeOnboarding();
                }
              });
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffA7E4FF),
              ),
              child: Center(
                child: Text('Next',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500, color: CC.textNextBtn)),
              )),
            ),

        ],
      ),
    );
  }


}

class  Data
{
  String caption ;
  String title;
  String image;
  Data({required this.caption,required this.title,required this.image});

}

