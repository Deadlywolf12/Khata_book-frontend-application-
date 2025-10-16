import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.kH,
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                8.kH,
                const Text(
                  "Log in to manage your expenses",
                  style: TextStyle(fontSize: 16, color: AppTheme.grey),
                ),
                30.kH,
                CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Email or username',
                  fillColor: AppTheme.cardColor,
                  filled: true,
                  hintTextStyle: const TextStyle(color: AppTheme.grey),
                  maxLines: 1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                ),
                20.kH,
                CustomTextField(
                  textInputType: TextInputType.text,
                  hintText: 'Password',
                  fillColor: AppTheme.cardColor,
                  filled: true,
                  hintTextStyle: const TextStyle(color: AppTheme.grey),
                  maxLines: 1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  obscureText: !_isPasswordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                10.kH,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Go.named(context, MyRouter.forgotPass);
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: AppTheme.primaryColor),
                    ),
                  ),
                ),
                10.kH,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                20.kH,
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                25.kH,
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.primaryColor,
                            width: 2.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            LucideIcons.fingerprint,
                            color: AppTheme.primaryColor,
                            size: 35,
                          ),
                        ),
                      ),
                      10.kH,
                      const Text(
                        "Use biometric login",
                        style: TextStyle(color: AppTheme.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                70.kH,
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(color: AppTheme.grey,fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Go.namedReplace(context,MyRouter.signup);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

    );
  }
}
