import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khatabookn/main.dart';
import 'package:khatabookn/provider/auth_pro.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';

import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'dart:async';

import 'package:khatabookn/utils/constants.dart';
import 'package:khatabookn/utils/helper/secured_storage/secure_storage_keys.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isWorkDone = false;
  final _secureStorage = const FlutterSecureStorage();



Future<bool> hasProfile() async {
  final profile = await appDatabase.getProfile();
  return profile != null;
}
Future<bool> hasPin() async {
  final pin = await _secureStorage.read(key: StorageKeys.savePin);
  final salt = await _secureStorage.read(key: StorageKeys.pinSalt);

  return pin != null && salt != null;
}
@override
void initState() {
  super.initState();

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10), // max safety duration
  );

  _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
    ..addListener(() {
      setState(() {});
    });

  // Start at 70% slowly — leaves room for work to finish
  _controller.animateTo(0.7, duration: const Duration(seconds: 3));

  _simulateLoadingTasks();
}
Future<void> _simulateLoadingTasks() async {
  final profileExists = await hasProfile();
  final pinExists = await hasPin();
  final isNewUser = !profileExists || !pinExists;

  if (mounted) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.loadUserMode();
    await auth.restoreLockState(); 
  }

  await _controller.animateTo(
    1.0,
    duration: const Duration(milliseconds: 600),
  );

  if (!mounted) return;
  setState(() => _isWorkDone = true);

  await Future.delayed(const Duration(milliseconds: 800));
  if (!mounted) return;

  if (isNewUser) {
    Go.namedReplace(context, MyRouter.landing);
  } else if (pinExists) {
    Go.namedReplace(context, MyRouter.authentication);
  } else {
    Go.namedReplace(context, MyRouter.landing);
  }
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _animation.value;

    return Scaffold(
     
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Logo
             Image.asset(Constants.splashLogo,width: 300,height: 300,),

              10.kH,

              // Title
              const Text(
                "KhataBook",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),

             8.kH,

              // Subtitle
              const Text(
                "Tracking your expenses",
                style: TextStyle(fontSize: 18, color: AppTheme.grey),
                textAlign: TextAlign.center,
              ),

              Spacer(),

              // Progress bar
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                color: AppTheme.primarySwatch,
                borderRadius: BorderRadius.circular(10),
              ),

              10.kH,

              // Loading text
              Text(
                _isWorkDone
                    ? "Loading Complete!"
                    : "Loading... ${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(fontSize: 14, color: AppTheme.grey),
              ),
              50.kH,
            ],
          ),
        ),
      ),
    );
  }
}



