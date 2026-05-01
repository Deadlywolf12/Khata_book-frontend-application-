import 'package:flutter/material.dart';
import 'package:khatabookn/helper/alert_dialog.dart';
import 'package:khatabookn/provider/auth_pro.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:khatabookn/widgets/snackbar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

// ── Dialog state enum ─────────────────────────────────────────────────────────
enum _DialogState { confirm, saving, success }

class EnterSecurityQuestion extends StatefulWidget {
  final bool isForgetting;
  final bool? pinStatus;
  final String? accType;
  const EnterSecurityQuestion({
    super.key,
    required this.isForgetting,
    this.pinStatus,
    this.accType,
  });

  @override
  State<EnterSecurityQuestion> createState() => _EnterSecurityQuestionState();
}

class _EnterSecurityQuestionState extends State<EnterSecurityQuestion> {
  // ── Forgetting mode controllers ───────────────────────────────────────────
  final TextEditingController _answerController = TextEditingController();
  int _currentQuestion = 1;
  String _questionText = '';
  String _question1 = '';
  String _question2 = '';

  // ── Setup mode controllers ────────────────────────────────────────────────
  final TextEditingController _q1Controller = TextEditingController();
  final TextEditingController _a1Controller = TextEditingController();
  final TextEditingController _q2Controller = TextEditingController();
  final TextEditingController _a2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isForgetting) {
      _loadSecurityQuestion();
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    _q1Controller.dispose();
    _a1Controller.dispose();
    _q2Controller.dispose();
    _a2Controller.dispose();
    super.dispose();
  }

  void _loadSecurityQuestion() async {
    final auth = context.read<AuthProvider>();
    _question1 = await auth.loadSecurityQuestions(1);
    _question2 = await auth.loadSecurityQuestions(2);
    setState(() {
      _questionText = _currentQuestion == 1 ? _question1 : _question2;
    });
  }

  // ── Forgetting flow ───────────────────────────────────────────────────────
  Future<void> _handleForgotSubmit() async {
    final answer = _answerController.text.trim();
    if (answer.isEmpty) {
      SnackBarHelper.showWarning("Please enter your answer");
      return;
    }

    final auth = context.read<AuthProvider>();
    final success = await auth.authenticateQuestions(_currentQuestion, answer);

    if (!mounted) return;

    if (success) {
      Go.namedReplace(context,MyRouter.createPin, extra: {
        'isForgot': true,
        'accType': widget.accType ?? 'guest',
        
      });
    } else {
      SnackBarHelper.showError("Incorrect answer. Please try again.");
      _answerController.clear();
    }
  }

  // ── Setup flow ────────────────────────────────────────────────────────────
  Future<void> _handleSetupSubmit() async {
    final q1 = _q1Controller.text.trim();
    final a1 = _a1Controller.text.trim();
    final q2 = _q2Controller.text.trim();
    final a2 = _a2Controller.text.trim();

    if (q1.isEmpty) {
      SnackBarHelper.showWarning("Please enter security question 1");
      return;
    }
    if (q1.length > 80) {
      SnackBarHelper.showWarning("Question 1 must be one short sentence");
      return;
    }
    if (a1.isEmpty) {
      SnackBarHelper.showWarning("Please enter answer for question 1");
      return;
    }
    if (q2.isEmpty) {
      SnackBarHelper.showWarning("Please enter security question 2");
      return;
    }
    if (q2.length > 80) {
      SnackBarHelper.showWarning("Question 2 must be one short sentence");
      return;
    }
    if (a2.isEmpty) {
      SnackBarHelper.showWarning("Please enter answer for question 2");
      return;
    }

    // ✅ Capture context before any async gap
    final rootContext = context;
    _DialogState dialogState = _DialogState.confirm;

    showDialog(
      context: rootContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // ── Confirm state ────────────────────────────────────────
            if (dialogState == _DialogState.confirm) {
              return CustomAlertDialog(
                title: "Save Security Questions?",
                subTitle:
                    "Make sure your answers are memorable. You'll need them to recover your PIN.",
                okBtnTitle: "Save",
                onTapOk: () async {
                  // Switch to loading without closing the dialog
                  setDialogState(() => dialogState = _DialogState.saving);

                  final auth = rootContext.read<AuthProvider>();
                  await auth.saveSecurityQuestion(q1, a1, 1);
                  await auth.saveSecurityQuestion(q2, a2, 2);

                  if (!mounted) return;

                  // Switch to success — still the same dialog, no slide-up
                  setDialogState(() => dialogState = _DialogState.success);
                },
              );
            }

            // ── Saving state ─────────────────────────────────────────
            if (dialogState == _DialogState.saving) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16),
                    CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Saving your questions...",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppTheme.grey,
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
            }

            // ── Success state ────────────────────────────────────────
            return CustomAlertDialog(
              title: "Questions Saved!",
              subTitle:
                  "Your security questions have been set up successfully.",
              okBtnTitle: "Continue",
              onTapOk: () {
                Go.pop(dialogContext);
                Go.namedReplace(rootContext, MyRouter.createUsername, extra: {
                  'pin': true,
                  'accType': widget.accType,
                });
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return Scaffold(
          bottomNavigationBar: const SizedBox(height: 1),
          floatingActionButton: FloatingActionButton.small(
            onPressed: auth.isLoading
                ? null
                : (widget.isForgetting
                    ? _handleForgotSubmit
                    : _handleSetupSubmit),
            foregroundColor: AppTheme.white,
            backgroundColor:
                auth.isLoading ? AppTheme.grey : AppTheme.primaryColor,
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
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      32.kH,

                      // ── Header ─────────────────────────────────────────────
                      Text(
                        widget.isForgetting
                            ? "Security Question"
                            : "Setup Security Questions",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.isForgetting
                            ? "Answer your security question to verify your identity"
                            : "Add two questions to help recover your PIN if forgotten",
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppTheme.grey,
                          height: 1.6,
                        ),
                      ),

                      32.kH,

                      // ── Forgetting mode ────────────────────────────────────
                      if (widget.isForgetting) ...[
                        _sectionLabel("Question"),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppTheme.primaryColor.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            _questionText.isEmpty
                                ? "Loading question..."
                                : _questionText,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                        20.kH,
                        _sectionLabel("Your Answer"),
                        12.kH,
                        CustomTextField(
                          textInputType: TextInputType.text,
                          hintText: 'Type your answer here...',
                          fillColor: Theme.of(context).cardColor,
                          controller: _answerController,
                          filled: true,
                          hintTextStyle: const TextStyle(color: AppTheme.grey),
                          maxLines: 1,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                        ),
                        20.kH,
                        // ── Switch question ──────────────────────────────────
                        GestureDetector(
                          onTap: () => setState(() {
                            _currentQuestion = _currentQuestion == 1 ? 2 : 1;
                            _questionText =
                                _currentQuestion == 1 ? _question1 : _question2;
                            _answerController.clear();
                          }),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.refreshCw,
                                size: 14,
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Try Question ${_currentQuestion == 1 ? 2 : 1} instead",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        40.kH,
                      ],

                      // ── Setup mode ─────────────────────────────────────────
                      if (!widget.isForgetting) ...[
                        // Question 1
                        _questionBlock(
                          number: 1,
                          questionController: _q1Controller,
                          answerController: _a1Controller,
                        ),
                        30.kH,
                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppTheme.grey.withOpacity(0.2),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Question 2",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.grey.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppTheme.grey.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                        30.kH,
                        // Question 2
                        _questionBlock(
                          number: 2,
                          questionController: _q2Controller,
                          answerController: _a2Controller,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Reusable section label ────────────────────────────────────────────────
  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    );
  }

  // ── Question + Answer block ───────────────────────────────────────────────
  Widget _questionBlock({
    required int number,
    required TextEditingController questionController,
    required TextEditingController answerController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _sectionLabel("Security Question $number"),
          ],
        ),
        const SizedBox(height: 10),
        CustomTextField(
          textInputType: TextInputType.text,
          hintText: 'e.g. What was your first pet\'s name?',
          fillColor: Theme.of(context).cardColor,
          controller: questionController,
          filled: true,
          hintTextStyle: const TextStyle(color: AppTheme.grey),
          maxLines: 1,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        const SizedBox(height: 12),
        _sectionLabel("Answer"),
        const SizedBox(height: 10),
        CustomTextField(
          textInputType: TextInputType.text,
          hintText: 'Type your answer...',
          fillColor: Theme.of(context).cardColor,
          controller: answerController,
          filled: true,
          hintTextStyle: const TextStyle(color: AppTheme.grey),
          maxLines: 1,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
      ],
    );
  }
}