import 'package:flutter/material.dart';

import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/views/analytics/widgets/insights.dart';
import 'package:khatabookn/views/analytics/widgets/overview.dart';
import 'package:khatabookn/views/analytics/widgets/trending_wig.dart';

import 'package:khatabookn/widgets/filled_box.dart';
import 'package:khatabookn/views/home/widgets/horizontal_bar.dart';


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
              // 🔹 Tab Content Area
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  child: _buildTabContent(),
),

          
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
  switch (_selectedTab) {
    case 0:
      return Column(
        children: [

          SpendingOverView(values: [50.0, 70.0, 40.0, 90.0, 60.0, 30.0, 10.0], days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], subtitle: 'Last 7 days',),
          25.kH,
SpendingTrendLine(values: [50.0, 70.0, 40.0, 90.0, 60.0, 30.0, 100.0], days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], subtitle: 'Last 7 days',),
25.kH,
 CategorySpendingCard(),
 25.kH,
 InsightCard(title: 'cook at home', description: 'cook at home to save money'),
        ],
      );

    case 1:
      return Column(
        children: [

          SpendingOverView(values: [50.0, 70.0, 40.0, 90.0, 60.0], days: ['Week One ', 'Week Two ', 'Week Three', 'Week Four', 'Week Five'], subtitle: 'Last 5 weeks',),
          25.kH,
SpendingTrendLine(values: [50.0, 70.0, 40.0, 90.0, 60.0], days: ['One', 'Two', 'Three', 'Four', 'Five'], subtitle: 'Last 7 days',),
25.kH,
 CategorySpendingCard(),
 25.kH,
 InsightCard(title: 'cook at home', description: 'cook at home to save money'),
        ],
      );

    case 2:
      return Column(
        children: [

          SpendingOverView(values: [50.0, 70.0, 40.0, 90.0, 60.0, 30.0], days: ['First', 'Second', 'Third', 'Forth', 'Fifth', 'Sixth'], subtitle: 'Last 6 months',),
          25.kH,
SpendingTrendLine(values: [50.0, 70.0, 40.0, 90.0, 60.0, 30.0], days: ['First', 'Second', 'Third', 'Forth', 'Fifth', 'Sixth'], subtitle: 'Last 7 days',),
25.kH,
 CategorySpendingCard(),
 25.kH,
 InsightCard(title: 'cook at home', description: 'cook at home to save money'),
        ],
      );

    default:
      return const SizedBox.shrink();
  }
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
