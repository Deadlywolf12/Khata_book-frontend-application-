import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khatabookn/provider/auth_pro.dart';
import 'package:khatabookn/provider/user_profile_pro.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/snackbar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  bool _isPinComplete = false;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    for (var c in _pinControllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _checkPinComplete() {
    final pin = _pinControllers.map((e) => e.text).join();
    final complete = pin.length == 4;
    if (complete != _isPinComplete) {
      setState(() => _isPinComplete = complete);
    }
  }

  void _clearPin() {
    for (var c in _pinControllers) c.clear();
    setState(() => _isPinComplete = false);
    _focusNodes[0].requestFocus();
  }

  Future<void> _shake() async {
    await _shakeController.forward();
    _shakeController.reset();
  }

  Future<void> _handleSubmit() async {
    final pin = _pinControllers.map((e) => e.text).join();
    if (pin.length != 4) {
      SnackBarHelper.showWarning("Please enter your 4-digit PIN");
      return;
    }

    final auth = context.read<AuthProvider>();

    if (auth.isGuest) {
      if (auth.isLocked) {
        SnackBarHelper.showError(
          "Account locked. Wait ${auth.remainingSeconds}s",
        );
        await _shake();
        _clearPin();
        return;
      }

      final success = await auth.authenticatePin(pin);

     if (success) {
  final profileProvider = context.read<UserProfileProvider>();

  await profileProvider.loadProfile();

  if (!mounted) return;

  Go.namedReplace(context, MyRouter.home);
} else {
        await _shake();
        _clearPin();
        if (!mounted) return;

        if (auth.isLocked) {
          SnackBarHelper.showError(
            "Too many attempts. Locked for 1 minute.",
          );
        } else {
          final remaining = AuthProvider.maxAttempts - auth.attempts;
          SnackBarHelper.showError(
            "Wrong PIN. $remaining attempt${remaining == 1 ? '' : 's'} remaining.",
          );
        }
      }
    } else {
      SnackBarHelper.showInfo("Online authentication coming soon");
    }
  }

  // ── Format seconds as mm:ss ───────────────────────────────────────────────
  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, UserProfileProvider>(
      builder: (context, auth, profileProvider, child) {
        final bool fabEnabled =
            _isPinComplete && !auth.isLoading && !auth.isLocked;

        return Stack(
          children: [
            Scaffold(
              bottomNavigationBar: const SizedBox(height: 1),
              floatingActionButton: FloatingActionButton.small(
                onPressed: fabEnabled ? _handleSubmit : null,
                foregroundColor: AppTheme.white,
                backgroundColor: fabEnabled ? AppTheme.primaryColor : AppTheme.grey,
                child: auth.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(LucideIcons.arrowRight),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
            
                      // ── Icon ──────────────────────────────────────────────────
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (auth.isLocked
                                  ? Colors.red
                                  : AppTheme.primaryColor)
                              .withOpacity(0.1),
                        ),
                        child: Icon(
                          auth.isLocked
                              ? LucideIcons.lock
                              : LucideIcons.shieldCheck,
                          color: auth.isLocked ? Colors.red : AppTheme.primaryColor,
                          size: 36,
                        ),
                      ),
                      24.kH,
            
                      // ── Title ─────────────────────────────────────────────────
                      Text(
                        auth.isLocked ? "Account Locked" : "Welcome Back",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color:
                              auth.isLocked ? Colors.red : AppTheme.primaryColor,
                        ),
                      ),
                      10.kH,
                      Text(
                        auth.isLocked
                            ? "Too many failed attempts."
                            : "Enter your 4-digit PIN to continue",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppTheme.grey,
                          height: 1.6,
                        ),
                      ),
            
                      // ── Countdown timer ────────────────────────────────────────
                      if (auth.isLocked) ...[
                        20.kH,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          // decoration: BoxDecoration(
                          //   // color: Colors.red.withOpacity(0.06),
                          //   borderRadius: BorderRadius.circular(16),
                          //   border: Border.all(
                          //     // color: Colors.red.withOpacity(0.2),
                          //   ),
                          // ),
                          child: Column(
                            children: [
                              Text(
                                _formatTime(auth.remainingSeconds),
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  letterSpacing: 4,
                                ),
                              ),
                              // 6.kH,
                              // const Text(
                              //   "Try again when the timer reaches 00:00",
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     color: AppTheme.grey,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
            
                      const Spacer(flex: 1),
            
                      // ── PIN boxes ──────────────────────────────────────────────
                      AnimatedBuilder(
                        animation: _shakeAnimation,
                        builder: (context, child) {
                          final offset = _shakeAnimation.value == 0
                              ? 0.0
                              : ((_shakeAnimation.value * 4).round() % 2 == 0
                                      ? -12.0
                                      : 12.0) *
                                  _shakeAnimation.value;
                          return Transform.translate(
                            offset: Offset(offset, 0),
                            child: child,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return SizedBox(
                              width: 64,
                              height: 64,
                              child: TextField(
                                controller: _pinControllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                obscureText: true,
                                enabled: !auth.isLocked,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: auth.isLocked
                                      ? Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.5)
                                      : Theme.of(context).cardColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.grey.withOpacity(0.2),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                      color: AppTheme.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppTheme.grey.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 3) {
                                    _focusNodes[index + 1].requestFocus();
                                  } else if (value.isEmpty && index > 0) {
                                    _focusNodes[index - 1].requestFocus();
                                  }
                                  _checkPinComplete();
                                  if (index == 3 && value.isNotEmpty) {
                                    _handleSubmit();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                       25.kH,
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${AuthProvider.maxAttempts - auth.attempts} "
                                    "attempt${(AuthProvider.maxAttempts - auth.attempts) == 1 ? '' : 's'} remaining",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
            
                      const Spacer(flex: 2),
                      auth.isLocked
                          ? GestureDetector(
                            onTap: () => Go.named(context, MyRouter.securityQuestion, extra: {'isForgetting': true}),
                            child:  Text(
                                "Forgot your pin?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.grey,
                              
                                ),
                              ),
                          )
                          : const SizedBox(),
                               auth.isLocked? const Spacer(flex: 2): const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
  if (profileProvider.isLoading)
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.4),
          child: const Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 55,
            ),
          ),
        ),

          ],
        );
      },
    );
  }
}