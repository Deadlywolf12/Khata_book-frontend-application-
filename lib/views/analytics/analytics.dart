import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:khatabookn/widgets/filled_box.dart';
import 'package:khatabookn/widgets/snack_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selectedTab = 0;
 

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 8),
          child: Column(
            children: [
              // 🔹 Tabs
              FilledBox(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(12),
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    _buildTabButton("Daily", 0),
                    _buildTabButton("Weekly", 1),
                    _buildTabButton("Monthly", 2),
                  ],
                ),
              ),
          
              25.kH,
          
             
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildTabButton(String title, int index) {
    final bool active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? AppTheme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
