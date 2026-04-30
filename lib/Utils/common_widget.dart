import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code/pin_code.dart';

import 'common_color.dart';
import 'image_constants.dart';

class CW {
  static String dialCode = "+91";

  static Widget commonTFFU({
     FormFieldValidator? validator,
    required TextEditingController controller,
    required String hintText,
     bool isBorder = true,
     Function(bool)? isTyping,
    Function(String)? onChanged,
    required BuildContext context,
  }) {
    return TextFormField(
      onTap: () {
        isTyping!(true);
      },
      onTapOutside: (event) {
        isTyping!(false);
      },
      onChanged: onChanged ?? (value){},

      controller: controller,
      validator: validator,

      keyboardType: TextInputType.phone,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 24,
        color: Theme.of(context).colorScheme.onTertiary,
      ),
      decoration: InputDecoration(
        filled: false,
        contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 4, left: 4),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(
            context,
          ).colorScheme.onInverseSurface.withOpacity(0.4),
        ),
        border: UnderlineInputBorder(),
        focusedBorder: isBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 4.1,
                ),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    ),
                borderRadius: BorderRadius.circular(8),
              ),

        enabledBorder: isBorder
            ? UnderlineInputBorder(borderSide: BorderSide.none)
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff7A7D9C), width: 1,

                ),
                borderRadius: BorderRadius.circular(8),
              ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 4.1,
          ),
        ),

        prefixIcon: Padding(
          padding: isBorder ? EdgeInsets.zero : EdgeInsets.all(16),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CountryCodePicker(
                    onChanged: (country) {
                      setState(() => dialCode = country.dialCode ?? "");
                    },
                    initialSelection: 'IN',
                    favorite: ['IN', '+91'],
                    //  Shows only country name and flag
                    showCountryOnly: false,
                    //  popup is closed.   //with dialCode and flag
                    showOnlyCountryWhenClosed: false,
                    boxDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Theme.of(context).colorScheme.tertiary)
                    ),
                    searchStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onSecondary,fontWeight: FontWeight.w400),
                    searchPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                    searchDecoration: InputDecoration(
                      hintText: "Search",
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                      hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.background),

                    ),
                    textStyle: TextStyle(
                      fontSize: 24,
                      color: Theme.of(
                        context,
                      ).colorScheme.onBackground.withOpacity(0.6),
                    ),

                    builder:
                        (
                          country,
                        ) //Ye ek callback function hai = Isme country object milta hai (jo current selected country hoti hai)=Tum decide karte ho ki UI me kya dikhana hai
                        {
                          return Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  country!.flagUri!, //path
                                  package:
                                      'country_code_picker', //kis package ka use
                                  fit: BoxFit.contain,
                                  width: 40,
                                ),
                              ),
                              SizedBox(width: 4),
                              Image.asset(
                                CI.dropDC,
                                height: 30,
                                color: Theme.of(context).colorScheme.onTertiary,
                              ),
                            ],
                          );
                        },
                  ),
                  SizedBox(width: 16),
                  Text(
                    "($dialCode)",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                 // SizedBox(width: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget commonTFFO({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 8),

        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          cursorColor: Theme.of(context).colorScheme.primary,
          cursorHeight: 25,
          decoration: InputDecoration(
            hintText: hintText,
            constraints: BoxConstraints(minHeight: 56, minWidth: 345),
            hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onBackground.withOpacity(0.4),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget commonEBST({
    double opacity = 1,
    String? text,
    required VoidCallback onTap,
    double width = 345,
    Color? colorB,
    Color? colorT,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 60,
          //  width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ).withOpacity(opacity),
          ),

          child: Center(
            child: Text(
              text!,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.background,fontWeight: FontWeight.w900)
            ),
          ),
        ),
      ),
    );
  }

  static Widget commonEBEn({
    required VoidCallback onTap,
    Color? colorB,
    bool? typing,
    bool requested = false,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () {
          onTap();
        },

        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: typing == true
                  ? [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ]
                  : [
                      Theme.of(context).colorScheme.primary.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                    ],
            ),
          ),

          child: Center(
            child: requested
                ? CircularProgressIndicator()
                : Image.asset(CI.arrowRightB, height: 40),
          ),
        ),
      ),
    );
  }

  static Widget commonPCF({
    required BuildContext context,
    required TextEditingController controller,
    required Function(bool) isTyping
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: PinCode(
        appContext: context,
        controller: controller,
        length: 4,
        onTap: () {
          isTyping(true);
        },

        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          color: Theme.of(context).colorScheme.onTertiary,
          fontSize: 39,
        ),
        showCursor: false,

        pinTheme: PinCodeTheme(
          fieldHeight: 60,
          fieldWidth: 68,
          inactiveBorderWidth: 3,
          activeBorderWidth: 3,
          disabledBorderWidth: 3,
          selectedBorderWidth: 3,

          inactiveColor: Theme.of(context).colorScheme.onTertiary,
          activeColor: Theme.of(context).colorScheme.onTertiary,
          selectedFillColor: Theme.of(context).colorScheme.primary,
          errorBorderColor: Theme.of(context).colorScheme.error,
        ),
        separatorBuilder: (context, index) {
          return SizedBox(width: 24); // yahi bich ki spacing hai
        },
      ),
    );
  }

  static Widget commonSignUPHS({
    required String title,
    required String? caption,
    required String isPageBT,
    String? number = '',
    bool isOtp = false,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Container(
        padding: EdgeInsets.only(top: 54, bottom: 75, left: 24, right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 60,
            ),
          ),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 127,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Color(0xffE8F0F9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(CI.leftARB, width: 24),
                      SizedBox(width: 14),
                      Text(
                        isPageBT,
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(color: CC.primary),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: CC.background,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      caption!,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(letterSpacing: 2),
                    ),
                  ],
                ),
                isOtp == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sent to : (${CW.dialCode})",
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          Text(
                            number!,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(letterSpacing: 2),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget commonButton({
    bool isContinue = true,
    required String title,
    required VoidCallback onTap,
    Color textColor = CC.background,
    required BuildContext context,
    bool isRequested = false
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(36),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: isContinue ? null : Color(0xffECF9FF),
          gradient: isContinue
              ? LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          )
              : null,
        ),
        child: Center(
          child: isRequested ? CircularProgressIndicator() : Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> showToast({
    required String msg,
    required BuildContext context,
  }) async {


    await Fluttertoast.showToast(
      msg: msg,

      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Theme.of(context).colorScheme.error,
      textColor: Theme.of(context).colorScheme.onSecondary,
      fontSize: 30,

    );
  }


}
