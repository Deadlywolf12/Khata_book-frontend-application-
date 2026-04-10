import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/snackbar.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final List<TextEditingController> _pinControllers = List.generate(4, (_) => TextEditingController());
  final List<TextEditingController> _confirmPinControllers = List.generate(4, (_) => TextEditingController());
  bool _pinsMatch = false;

  void _checkPinsMatch() {
    final pin = _pinControllers.map((e) => e.text).join();
    final confirmPin = _confirmPinControllers.map((e) => e.text).join();
    setState(() {
      _pinsMatch = pin == confirmPin && pin.length == 4;
    });
  }

  void _createPin() {
    final pin = _pinControllers.map((e) => e.text).join();
    if (pin.length != 4) {
     SnackBarHelper.showWarning("Please enter a 4-digit PIN");
      return;
    }

    if (!_pinsMatch) {
      SnackBarHelper.showError("PINs do not match");
    
       
      return;
    }

    // TODO: Save PIN logic
    Go.named(context, MyRouter.createUsername);
  }

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var controller in _confirmPinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    "Set up a secure 4-digit PIN for your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.grey,
                      height: 1.5,
                    ),
                  ),
                  40.kH,
                  // PIN label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter PIN",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  12.kH,
                  // PIN boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 60,
                        height: 60,
                        child: TextField(
                          controller: _pinControllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                           
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              // borderSide: const BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                            _checkPinsMatch();
                          },
                        ),
                      ),
                    ),
                  ),
                  35.kH,
                  // Confirm PIN label
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm PIN",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  12.kH,
                  // Confirm PIN boxes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 60,
                        height: 60,
                        child: TextField(
                          controller: _confirmPinControllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: Theme.of(context).cardColor,
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: const BorderSide(color: AppTheme.grey),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              // borderSide: const BorderSide(color: AppTheme.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                            _checkPinsMatch();
                          },
                        ),
                      ),
                    ),
                  ),
                  40.kH,
                  // Create PIN button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _createPin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Create PIN",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  15.kH,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
