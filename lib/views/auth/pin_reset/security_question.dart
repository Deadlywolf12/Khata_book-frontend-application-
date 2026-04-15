import 'package:flutter/material.dart';

import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';

import 'package:khatabookn/widgets/custom_text_field.dart';

import 'package:lucide_icons/lucide_icons.dart';

class enterSecurityQuestion extends StatefulWidget {
final bool isForgetting;
  const enterSecurityQuestion({
    super.key, required this.isForgetting,

  });

  @override
  State<enterSecurityQuestion> createState() => _enterSecurityQuestionState();
}

class _enterSecurityQuestionState extends State<enterSecurityQuestion> {
  final TextEditingController _nameController = TextEditingController();
 

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
   
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
                  "Enter your security question",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                10.kH,
                const Text(
                  "What is your favorite game?",
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
                    "Enter Answer",
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
                  hintText: 'Type answer here...',
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
                    icon: const Icon(LucideIcons.badgeHelp, size: 30),
                    onPressed: () {
                      setState(() {
                       
                     
                      });
                    },
                  ),
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