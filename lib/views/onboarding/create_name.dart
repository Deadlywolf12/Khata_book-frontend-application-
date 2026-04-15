import 'package:flutter/material.dart';
import 'package:khatabookn/helper/alert_dialog.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/utils/helper/username_gen.dart';
import 'package:khatabookn/utils/helper/username_message.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:khatabookn/widgets/snackbar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateUsernameScreen extends StatefulWidget {
  final bool pinStatus;
  final String accType;
  const CreateUsernameScreen({
    super.key,
    required this.pinStatus,
    required this.accType,
  });

  @override
  State<CreateUsernameScreen> createState() => _CreateUsernameScreenState();
}

class _CreateUsernameScreenState extends State<CreateUsernameScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _totalRandomized = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = UsernameHelper.safeGenerate();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final username = _nameController.text.trim();

    if (username.isEmpty) {
      SnackBarHelper.showError("Username cannot be empty");
      return;
    } else if (username.length < 3) {
      SnackBarHelper.showError("Username must be at least 3 characters long");
      return;
    } else if (username.length > 35) {
      SnackBarHelper.showError("Username cannot be more than 35 characters long");
      return;
    }

    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        onTapOk: () {
          Go.namedReplace(
            context,
            MyRouter.currencySelection,
            extra: {
              'username': username,
              'pin': widget.pinStatus,
              'accType': widget.accType,
            },
          );
        },
        title: "Username Created",
        subTitle: _totalRandomized == 0
            ? getUsernameMessage(_totalRandomized)
            : "${getUsernameMessage(_totalRandomized)}Randomized $_totalRandomized times.",
        okBtnTitle: "Continue",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SizedBox(height: 1),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _handleSubmit,
        foregroundColor: AppTheme.white,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(LucideIcons.arrowRight),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Create Username",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                10.kH,
                const Text(
                  "What should we call you?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppTheme.grey,
                    height: 1.5,
                  ),
                ),
                40.kH,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter UserName",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                12.kH,
                CustomTextField(
                  textInputType: TextInputType.text,
                  hintText: 'BraveDragon4821',
                  fillColor: Theme.of(context).cardColor,
                  controller: _nameController,
                  filled: true,
                  hintTextStyle: const TextStyle(color: AppTheme.grey),
                  maxLines: 1,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  suffix: IconButton(
                    icon: const Icon(LucideIcons.dices, size: 30),
                    onPressed: () {
                      setState(() {
                        _nameController.text = UsernameHelper.safeGenerate();
                        _totalRandomized++;
                      });
                    },
                  ),
                ),8.kH,
// ── Randomized count hint ──────────────────────────────────
if (_totalRandomized > 0)
  Row(
    children: [
      const Icon(
        LucideIcons.refreshCw,
        size: 12,
        color: AppTheme.grey,
      ),
      6.kW,
      Text(
        "Randomized $_totalRandomized time${_totalRandomized == 1 ? '' : 's'}",
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.grey,
        ),
      ),
    ],
  ),
                20.kH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}