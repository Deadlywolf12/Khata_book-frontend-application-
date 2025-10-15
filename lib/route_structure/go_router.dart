import 'package:go_router/go_router.dart';
import 'package:khatabookn/views/auth/landing_screen.dart';
import 'package:khatabookn/views/auth/signin.dart';
import 'package:khatabookn/views/auth/singup.dart';
import 'package:khatabookn/views/home/home_screen.dart';
import 'package:khatabookn/views/splash/splash.dart';

class MyRouter {
  static const String home = 'home';
  static const String landing = 'landing';
  static const String signup = 'signup';
  static const String signin = 'signin';
  static const String splash = 'splash';
  // static const String selectUser = 'select-user';
  // static const String transaction = 'transaction';
  // static const String methodScreen = 'methodScreen';
  // static const String transactionDone = 'transaction-done';

  static final GoRouter router = GoRouter(
    initialLocation: '/$splash',
   
    routes: [
      GoRoute(
        path: '/$splash',
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      
     
      GoRoute(
        path: '/$home',
        name: home,
        builder: (context, state) => const HomeScreen(),
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
      // GoRoute(
      //   path: '/$transaction/:custId/:type',
      //   name: transaction,
      //   builder: (context, state) {
      //     final custId = state.pathParameters['custId']!;
      //     final type = state.pathParameters['type']!;
      //     return SimulateTransactionScreen(custId: custId, type: type);
      //   },
      // ),
      // GoRoute(
      //   path: '/$methodScreen/:custId/:name',
      //   name: methodScreen,
      //   builder: (context, state) {
      //     final custId = state.pathParameters['custId']!;
      //     final name = state.pathParameters['name']!;
      //     return TransactionMethodScreen(custId: custId, name: name);
      //   },
      // ),
      // GoRoute(
      //   path: '/$transactionDone/:image/:custId',
      //   name: transactionDone,
      //   builder: (context, state) {
      //     final transaction = state.extra as Transaction;
      //     final image = state.pathParameters['image']!;
      //     final custId = state.pathParameters['custId']!;
      //     return TransactionDonePage(
      //       tx: transaction,
      //       imagePath: image,
      //       custId: custId,
      //     );
      //   },
      // ),
 
    ],
  );
}
