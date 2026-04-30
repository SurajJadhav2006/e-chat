import 'package:flutter/material.dart';

import '../Utils/image_constants.dart';

class SetFingerprintSecurity extends StatefulWidget {
  const SetFingerprintSecurity({super.key});

  @override
  State<SetFingerprintSecurity> createState() => _SetFingerprintSecurityState();
}

class _SetFingerprintSecurityState extends State<SetFingerprintSecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              headerSection(),
            ],
        
          ),
        ),
      ),
    );
  }

  Widget headerSection() {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){
               // Navigator.push(context, MaterialPageRoute(builder: (_) => UserInformation()));
              },

              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary.withOpacity(0.1),
                ),
                child: Center(
                  child: Image.asset(
                    CI.leftARB,
                    color: Theme.of(context).colorScheme.onSecondary,
                    width: 16,
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Fingerprint Security",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 32),
        Text(
          "Secure your account with your fingerprint\nusing Fingerprint Security",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
