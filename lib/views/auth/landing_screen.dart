import 'package:flutter/material.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';

import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'dart:async';

import 'package:khatabookn/utils/constants.dart';
import 'package:khatabookn/widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Logo
              Image.asset(Constants.splashLogo, width: 300, height: 300),

              10.kH,

              // Title
              const Text(
                "Track your money,\ncontrol your future.  ",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                ),
                textAlign: TextAlign.center,
              ),

              12.kH,

              // Subtitle
              const Text(
                "A simple way to manage your expenses",
                style: TextStyle(fontSize: 18, color: AppTheme.grey),
                textAlign: TextAlign.center,
              ),

              Spacer(),

              CustomButton(
                height: 60,
                onTap: () {},
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Text(

                  "Sign Up",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              20.kH,
              CustomButton(
                height: 60,
                onTap: () {},
                borderRadius: BorderRadius.all(Radius.circular(20)),
                buttoncolor: AppTheme.cardColor,
                child: Text(
                  "Sign in",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: AppTheme.primaryColor),
                ),
              ),
              50.kH,
            ],
          ),
        ),
      ),
    );
  }
}
