import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khatabookn/helper/alert_dialog.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/utils/dailog.dart';
import 'package:khatabookn/utils/helper/username_gen.dart';
import 'package:khatabookn/utils/helper/username_message.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:khatabookn/widgets/snackbar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateUsernameScreen extends StatefulWidget {
  const CreateUsernameScreen({super.key});

  @override
  State<CreateUsernameScreen> createState() => _CreateUsernameScreenState();
}

class _CreateUsernameScreenState extends State<CreateUsernameScreen> {
  final TextEditingController _nameController =   TextEditingController();
 
  int _totalRandomized = 0;


  @override
  void initState() {
   
  _nameController.text = UsernameHelper.safeGenerate();
      
 
 

    super.initState();
  }




    
  @override
  void dispose() {
   _nameController.dispose();
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
                  // UserName label
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
                  hintText: 'Annonymous_kingdom2',
                  fillColor: Theme.of(context).cardColor,
                  controller: _nameController,
                  filled: true,
                  hintTextStyle: const TextStyle(color: AppTheme.grey),
                  maxLines: 1,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                 
                  suffix: IconButton(
                    icon: Icon(
                  
                           LucideIcons.dices,
                           size: 30,
                        
                    ),
                    onPressed: () {
                      setState(() {
                        
                    _nameController.text = UsernameHelper.safeGenerate();
                    _totalRandomized++;
                      });
                 
                    },
                  ),
                ),
                20.kH,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){

                        showDialog(context: context, builder: (context)
                        =>CustomAlertDialog(onTapOk:  (){
                          Go.named(context, MyRouter.home);
                        },
                         title: "Username Created",
                          subTitle: _totalRandomized == 0 ? "${getUsernameMessage(_totalRandomized)}":
        "${getUsernameMessage(_totalRandomized)}\n\n""Randomized $_totalRandomized times.",
                          okBtnTitle: "Continue",
                        
                        ));



                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Create Username",
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
