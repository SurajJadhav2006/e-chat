import 'package:flutter/material.dart';
import '../Utils/common_color.dart';

class AppTextStyle
{

  static TextStyle titleLarge(Color color, { String? fontFamily})
  {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize:35,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,

    );
  }

  static TextStyle titleMedium(Color color, {String? fontFamily})
  {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 32,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,

    );

  }

  static TextStyle titleSmall(Color color, {String? fontFamily})
  {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      inherit: true,
      color: color,
      fontFamily: fontFamily,
      decoration: TextDecoration.none,
    );

  }

  static TextStyle headLineMedium(Color color, {String? fontFamily})
  {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 25,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );

  }
  
  
  static TextStyle headLineLarge(Color color, {String? fontFamily})
  {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );

  }
  static TextStyle headLineSmall(Color color, { String? fontFamily})
  {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      inherit: true,
      color: color,
      decoration: TextDecoration.none,
    );

  }

}


class ThemeDataLight
{
  static TextTheme  textTheme(Color color , String? fontFamily)
   {
     return TextTheme(
       titleLarge: AppTextStyle.titleLarge(CC.textIcon,fontFamily: fontFamily),
       titleMedium: AppTextStyle.titleMedium(CC.textIcon,fontFamily: fontFamily),
       titleSmall: AppTextStyle.titleSmall(CC.textIcon,fontFamily: fontFamily),

     );

   }


}



class ThemeDataDark
{
  static TextTheme textTheme(Color color , String? fontFamily)
  {
    return TextTheme(
      titleLarge: AppTextStyle.titleLarge(CCDark.primary,fontFamily: fontFamily),
      titleMedium: AppTextStyle.titleMedium(CCDark.primary,fontFamily: fontFamily),
      titleSmall: AppTextStyle.titleSmall(CCDark.primary,fontFamily: fontFamily),

    );

  }


}