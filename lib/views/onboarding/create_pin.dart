import 'package:flutter/material.dart';
import 'package:khatabookn/provider/auth_pro.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/snackbar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class CreatePinScreen extends StatefulWidget {
  final String accType;
  final bool isForgot;
  const CreatePinScreen({super.key, required this.accType, required this.isForgot});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> _confirmPinControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _pinFocusNodes =
      List.generate(4, (_) => FocusNode());
  final List<FocusNode> _confirmFocusNodes =
      List.generate(4, (_) => FocusNode());

  bool _pinsMatch = false;
  bool _isPinComplete = false;
  bool _isConfirmComplete = false;

  void _checkPinsMatch() {
    final pin = _pinControllers.map((e) => e.text).join();
    final confirmPin = _confirmPinControllers.map((e) => e.text).join();
    setState(() {
      _isPinComplete = pin.length == 4;
      _isConfirmComplete = confirmPin.length == 4;
      _pinsMatch = pin == confirmPin && pin.length == 4;
    });
  }

  void _createPin() async{
    final authPro = Provider.of<AuthProvider>(context, listen: false);
    final pin = _pinControllers.map((e) => e.text).join();
    if (pin.length != 4) {
      SnackBarHelper.showWarning("Please enter a 4-digit PIN");
      return;
    }
    if (!_pinsMatch) {
      SnackBarHelper.showError("PINs do not match");
      return;
    }

    if(widget.accType == "guest"){
     await authPro.signUpUserAsGuest();
     await authPro.saveOfflinePin(pin);
     if(widget.isForgot){
        Go.namedReplace(context, MyRouter.authentication, );
        return;
     }
       Go.namedReplace(context, MyRouter.securityQuestion, extra: {
      'pin': true,
      'accType': widget.accType,
      'isForgetting': false,
    });
    } else {
      SnackBarHelper.showSuccess("online navigation");
    }

  
  }

  @override
  void dispose() {
    for (var c in _pinControllers) {
      c.dispose();
    }
    for (var c in _confirmPinControllers) {
      c.dispose();
    }
    for (var f in _pinFocusNodes) {
      f.dispose();
    }
    for (var f in _confirmFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Widget _buildPinRow({
    required List<TextEditingController> controllers,
    required List<FocusNode> focusNodes,
    FocusNode? firstOfNextRow,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 64,
          height: 64,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            obscureText: true,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Theme.of(context).cardColor,
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
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                focusNodes[index + 1].requestFocus();
              } else if (value.isNotEmpty &&
                  index == 3 &&
                  firstOfNextRow != null) {
                firstOfNextRow.requestFocus(); // jump to confirm row
              } else if (value.isEmpty && index > 0) {
                focusNodes[index - 1].requestFocus();
              }
              _checkPinsMatch();
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool fabEnabled = _isPinComplete && _isConfirmComplete && _pinsMatch;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppTheme.primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: const SizedBox(height: 1),
     floatingActionButton: Consumer<AuthProvider>(
  builder: (context, auth, _) {
    final bool fabEnabled = _isPinComplete && _isConfirmComplete && _pinsMatch && !auth.isLoading;
    return FloatingActionButton.small(
      onPressed: fabEnabled ? _createPin : null,
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
    );
  },
),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              32.kH,

              // ── Header ────────────────────────────────────────────────
              const Text(
                "Create PIN",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              10.kH,
              const Text(
                "Set up a secure 4-digit PIN\nto protect your account",
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.grey,
                  height: 1.6,
                ),
              ),

              const Spacer(),

              // ── PIN ───────────────────────────────────────────────────
              Text(
                "Enter PIN",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              16.kH,
              _buildPinRow(
                controllers: _pinControllers,
                focusNodes: _pinFocusNodes,
                firstOfNextRow: _confirmFocusNodes[0],
              ),

              40.kH,

              // ── Confirm PIN ───────────────────────────────────────────
              Row(
                children: [
                  Text(
                    "Confirm PIN",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Spacer(),
                  // ← match indicator
                  if (_isConfirmComplete)
                    Row(
                      children: [
                        Icon(
                          _pinsMatch
                              ? LucideIcons.checkCircle
                              : LucideIcons.xCircle,
                          size: 16,
                          color: _pinsMatch ? Colors.green : Colors.red,
                        ),
                        6.kW,
                        Text(
                          _pinsMatch ? "Matches" : "Doesn't match",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _pinsMatch ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              16.kH,
              _buildPinRow(
                controllers: _confirmPinControllers,
                focusNodes: _confirmFocusNodes,
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}