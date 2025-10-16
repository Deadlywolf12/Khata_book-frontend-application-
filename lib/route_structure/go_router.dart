
import 'package:go_router/go_router.dart';
import 'package:khatabookn/views/add/add_trans.dart';
import 'package:khatabookn/views/analytics/analytics.dart';

import 'package:khatabookn/views/auth/forgot_pass.dart';
import 'package:khatabookn/views/auth/landing_screen.dart';
import 'package:khatabookn/views/auth/otp_screen.dart';
import 'package:khatabookn/views/auth/set_new_pass.dart';
import 'package:khatabookn/views/auth/signin.dart';
import 'package:khatabookn/views/auth/signup.dart';
import 'package:khatabookn/views/home/home_screen.dart';
import 'package:khatabookn/views/loans/loans.dart';

import 'package:khatabookn/views/navbar/navbar.dart';
import 'package:khatabookn/views/settings/settings.dart';

import 'package:khatabookn/views/splash/splash.dart';


class MyRouter {
  static const String home = 'home';
  static const String landing = 'landing';
  static const String signup = 'signup';
  static const String signin = 'signin';
  static const String splash = 'splash';
  static const String otp = 'otp';
  static const String forgotPass = 'forgotPass';
  static const String newPass = 'newPass';
  static const String app = 'app';
  static const String newTransaction = 'newTransaction';

  static final GoRouter router = GoRouter(
    initialLocation: '/$splash',

    routes: [
      /// -------------------
      /// 🔹 Auth & Splash Routes
      /// -------------------
      GoRoute(
        path: '/$splash',
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/$landing',
        name: landing,
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: '/$signin',
        name: signin,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/$signup',
        name: signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/$otp',
        name: otp,
        builder: (context, state) => const OtpVerificationScreen(),
      ),
      GoRoute(
        path: '/$forgotPass',
        name: forgotPass,
        builder: (context, state) => const ForgotPassScreen(),
      ),
      GoRoute(
        path: '/$newPass',
        name: newPass,
        builder: (context, state) => const SetNewPasswordScreen(),
      ),
      // GoRoute(
      //   path: '/$newTransaction',
      //   name: newTransaction,
      //   builder: (context, state) => const AddNewTransactionScreen(),
      // ),
   GoRoute(
      path: '/home',
      builder: (context, state) => const NavigationHandler(),
    ),
   

   

    ],
  );
}
