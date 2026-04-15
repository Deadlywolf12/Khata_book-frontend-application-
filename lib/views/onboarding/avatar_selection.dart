import 'dart:async';
import 'package:flutter/material.dart';
import 'package:khatabookn/helper/alert_dialog.dart';
import 'package:khatabookn/models/currency_models.dart';
import 'package:khatabookn/provider/user_profile_pro.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class AvatarSelectionScreen extends StatefulWidget {
  final bool pinStatus;
  final String username;
  final String accType;
  final Currency currency;

  const AvatarSelectionScreen({
    super.key,
    required this.pinStatus,
    required this.username,
    required this.accType,
    required this.currency,
  });

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  int _selectedAvatar = 0;

  Future<void> _handleProfileCreation() async {
    final profilePro = Provider.of<UserProfileProvider>(context, listen: false);

    final profileCreated = await profilePro.createProfile(
      username: widget.username,
      avatarIndex: _selectedAvatar,
      currency: widget.currency,
      accType: widget.accType,
      pinEnabled: widget.pinStatus,
    );

    if (!mounted) return;

    if (profileCreated) {
      Go.namedReplace(
        context,
        MyRouter.profileCompleted,
        extra: {
          'pin': widget.pinStatus,
          'username': widget.username,
          'accType': widget.accType,
          'currency': widget.currency,
          'avatarUrl': _selectedAvatar,
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Error",
          subTitle: "Failed to create profile. Please try again.",
          onTapOk: () => Go.pop(context),
        ),
      );
    }
  }

  void _onFabPressed() {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: "Are you sure?",
        subTitle: "Almost Complete! Do you want to select this avatar?",
        onTapOk: () {
          Go.pop(context);
          _handleProfileCreation();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, profilePro, _) {
        return Scaffold(
          bottomNavigationBar: const SizedBox(height: 1),
          floatingActionButton: FloatingActionButton.small(
            onPressed: profilePro.isLoading ? null : _onFabPressed,
            foregroundColor: AppTheme.white,
            backgroundColor: profilePro.isLoading
                ? AppTheme.grey
                : AppTheme.primaryColor,
            child: profilePro.isLoading
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.kH,

                  // ── Header ───────────────────────────────────────────────
                  const Text(
                    "Select Avatar",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  10.kH,
                  const Text(
                    "Choose an avatar for your profile",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.grey,
                      height: 1.5,
                    ),
                  ),
                  20.kH,

                  // ── Grid ─────────────────────────────────────────────────
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 12,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final isSelected = _selectedAvatar == index;
                        return InkWell(
                          onTap: () => setState(() => _selectedAvatar = index),
                          child: AnimatedScale(
                            scale: isSelected ? 1.03 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.primaryColor
                                      : Colors.transparent,
                                  width: 4,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.4),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/avatar/avatar$index.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  20.kH,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}