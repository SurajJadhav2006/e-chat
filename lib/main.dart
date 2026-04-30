import 'package:device_preview/device_preview.dart';
import 'package:e_chat/App_Thems/app_them.dart';
import 'package:e_chat/OnBordingPages/slash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Utils/firebase_firestore/firebase_helper.dart';

 //ThemeMode mode =  ThemeMode.system;
 ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);
//final GlobalKey<MyAppState> appKey = GlobalKey<MyAppState>();

  FirebaseHelper firebaseHelper = FirebaseHelper();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
   docId = pref.getString('docId') ?? " ";
  runApp (
    DevicePreview(
    enabled: true,

    builder: (context) => const MyApp(),
  ),

  );

}

 class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

 class MyAppState extends State<MyApp> {

  @override
  void initState()
  {
    super.initState();
    loadTheme();
  }
  Future<void> loadTheme() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeMode = prefs.getString("theme");

    if (themeMode == "dark")
    {
      themeNotifier.value = ThemeMode.dark;
    }
    else if (themeMode == "light")
    {
      themeNotifier.value = ThemeMode.light;
    }
    else
    {
      themeNotifier.value = ThemeMode.system;
    }
  }


  @override

   Widget build(BuildContext context) {
     return  ValueListenableBuilder<ThemeMode>(
       valueListenable: themeNotifier,
         builder: (context , ThemeMode currentThemeMode,child) {
         return GestureDetector(
           onTap: ()
           {
             FocusScope.of(context).unfocus();
           },
           child: MaterialApp(
             title: 'E-Chat',
             debugShowCheckedModeBanner: false,
             builder: (context, child) {
               return MediaQuery(
                 data: MediaQuery.of(context).copyWith(
                   textScaler: const TextScaler.linear(1.0),
                 ),
                 child: child!,
               );
             },
             theme: AppThemes.lightTheme(fontFamily: "Roboto",),
             darkTheme: AppThemes.darkTheme(fontFamily: "Roboto"),
             themeMode: ThemeMode.system,
             home: SplashScreen(),
           ),
         );
       }
     );
   }


}



/*
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  ThemeMode themeModes = ThemeMode.light;


  @override
  void initState()
  {
    super.initState();
    checkTheme();
  }

  Future<void> changeThemeMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      //print("CHANGETHEME");

      setState(() {
        if(themeModes == ThemeMode.light)
        {
          themeModes = ThemeMode.dark;
          pref.setBool("isDark",true);
        }
        else
        {
          themeModes = ThemeMode.light;
        }
      });
    });
  }


  }
*/




