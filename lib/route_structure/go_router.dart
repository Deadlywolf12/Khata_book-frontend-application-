
import 'package:go_router/go_router.dart';
import 'package:khatabookn/models/currency_models.dart';
import 'package:khatabookn/views/about/about.dart';
import 'package:khatabookn/views/add/add_loan.dart';
import 'package:khatabookn/views/add/add_trans.dart';
import 'package:khatabookn/views/analytics/analytics.dart';
import 'package:khatabookn/views/auth/authentication.dart';
import 'package:khatabookn/views/auth/pin_reset/security_question.dart';
import 'package:khatabookn/views/onboarding/avatar_selection.dart';
import 'package:khatabookn/views/onboarding/create_name.dart';
import 'package:khatabookn/views/onboarding/create_pin.dart';
import 'package:khatabookn/views/onboarding/currency_selection.dart';

import 'package:khatabookn/views/auth/forgot_pass.dart';
import 'package:khatabookn/views/onboarding/profile_completed.dart';
import 'package:khatabookn/views/catergory/manageCat.dart';
import 'package:khatabookn/views/faqs/faqs.dart';
import 'package:khatabookn/views/landing/landing_screen.dart';
import 'package:khatabookn/views/auth/otp_screen.dart';
import 'package:khatabookn/views/auth/set_new_pass.dart';
import 'package:khatabookn/views/auth/signin.dart';
import 'package:khatabookn/views/auth/signup.dart';
import 'package:khatabookn/views/home/home_screen.dart';
import 'package:khatabookn/views/loans/loan_dashboard.dart';
import 'package:khatabookn/views/loans/loans.dart';

import 'package:khatabookn/views/navbar/navbar.dart';
import 'package:khatabookn/views/profile/profile.dart';
import 'package:khatabookn/views/remainder/remainders.dart';
import 'package:khatabookn/views/settings/settings.dart';

import 'package:khatabookn/views/splash/splash.dart';
import 'package:khatabookn/views/storage/storage.dart';
import 'package:khatabookn/views/transactions/transactions.dart';


class MyRouter {
  static const String home = 'home';
  static const String landing = 'landing';
  static const String signup = 'signup';
  static const String signin = 'signin';
  static const String splash = 'splash';
  static const String profileCompleted = 'profileCompleted';
  static const String otp = 'otp';
  static const String createPin = 'createPin';
  static const String forgotPass = 'forgotPass';
  static const String newPass = 'newPass';
  static const String app = 'app';
  static const String newTransaction = 'newTransaction';
  static const String transactions = 'Transactions';
  static const String newLoan = 'newLoan';
  static const String profile = 'profile';
  static const String about = 'about';
  static const String faqs = 'faqs';
  static const String remainder = 'remainder';
  static const String cat = 'cat';
  static const String createUsername = 'createUsername';
  static const String createAvatar = 'createAvatar';
  static const String currencySelection = 'currencySelection';
  static const String authentication = 'authentication';
  static const String securityQuestion = 'securityQuestion';

  static const String storage = 'storage';
  static const String loanDashboard = 'loanDashboard';
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
        path: '/$authentication',
        name: authentication,
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: '/$securityQuestion',
        name: securityQuestion,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          
          final isForgetting = extra?['isForgetting'] as bool? ?? false;

          return enterSecurityQuestion(isForgetting: isForgetting);
        },
      ),
      GoRoute(
        path: '/$signin',
        name: signin,
        builder: (context, state) => const SignInScreen(),
      ),
        GoRoute(
        path: '/$createPin',
        name: createPin,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final accType = extra?['accType'] as String?;
          return CreatePinScreen(accType: accType ?? '');
        },
      ),
        GoRoute(
        path: '/$createAvatar',
        name: createAvatar,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final pinStatus = extra?['pin'] as bool?;
          final username = extra?['username'] as String?;
          final currency = extra?['currency'] as Currency?;
          final accType = extra?['accType'] as String?;
           return AvatarSelectionScreen(pinStatus: pinStatus ?? false, username: username ?? '', accType: accType ?? '', currency: currency ??Currency(code: "USD", title: "USD", subtitle: "US Dollar",symbol: "\$"));},
      ),
        GoRoute(
        path: '/$profileCompleted',
        name: profileCompleted,
        builder: (context, state) { 
            final extra = state.extra as Map<String, dynamic>?;
    final username = extra?['username'] as String?;
    final avatarUrl = extra?['avatarUrl'] as int?;
    final currency = extra?['currency'] as Currency?;
    final accType = extra?['accType'] as String?;
    final pinStatus = extra?['pin'] as bool?;

          
          return ProfileCompletedScreen(username: username ?? '', avatarUrl: avatarUrl ?? 0, currency: currency ?? Currency(code: "USD", title: "USD", subtitle: "US Dollar",symbol: "\$"), accType: accType ?? '', pinStatus: pinStatus ?? false); },
      ),
        GoRoute(
        path: '/$createUsername',
        name: createUsername,
        builder: (context, state) { 
            final extra = state.extra as Map<String, dynamic>?;
          final pin = extra?['pin'] as bool?;
          final accType = extra?['accType'] as String?;
          return CreateUsernameScreen(pinStatus: pin ?? false, accType: accType??'',);},
      ),
      GoRoute(
        path: '/$signup',
        name: signup,
        builder: (context, state) => const SignUpScreen(),
      ),

       GoRoute(
        path: '/$currencySelection',
        name: currencySelection,
  
        
        builder: (context, state) { 
            final extra = state.extra as Map<String, dynamic>?;
    final username = extra?['username'] as String?;
    final pinStatus = extra?['pin'] as bool?;
    final accType = extra?['accType'] as String?;
    
          return CurrencySelectionScreen(pinStatus: pinStatus ?? false, username: username ?? '', accType: accType ?? '');},
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
        path: '/$storage',
        name: storage,
        builder: (context, state) => const StoragePreferenceScreen(),
      ),
     GoRoute(
        path: '/$newPass',
        name: newPass,
        builder: (context, state) => const SetNewPasswordScreen(),
      ),
       GoRoute(
        path: '/$newLoan',
        name: newLoan,
        builder: (context, state) => const AddLoanScreen(),
      ),
        GoRoute(
        path: '/$about',
        name: about,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/$newTransaction',
        name: newTransaction,
        builder: (context, state) => const AddNewTransactionScreen(),
      ),
        GoRoute(
        path: '/$profile',
        name: profile,
        builder: (context, state) => const ProfileScreen(),
      ),
       GoRoute(
        path: '/$faqs',
        name : faqs,
        builder: (context, state) => const HelpSupportScreen(),
      ),
        GoRoute(
        path: '/$remainder',
        name : remainder,
        builder: (context, state) => const RemindersScreen(),
      ),
        GoRoute(
        path: '/$transactions',
        name: transactions,
        builder: (context, state) => const TransactionsScreen(),
      ),
       GoRoute(
        path: '/$cat',
        name: cat,
        builder: (context, state) => const CategoryScreen(),
      ),
     GoRoute(
path: '/$loanDashboard/:userName/:totalToTake/:totalToGive',

  name: loanDashboard,
  builder: (context, state) {
    final userName = state.pathParameters['userName']!;
    final toTake = state.pathParameters['totalToTake']!;
    final toGive = state.pathParameters['totalToGive']!;
    return LoanDetailScreen(userName: userName, totalToTake: toTake,totalToGive:toGive,);
  },
),

   GoRoute(
      path: '/home',
      builder: (context, state) => const NavigationHandler(),
    ),
   

   

    ],
  );
}
