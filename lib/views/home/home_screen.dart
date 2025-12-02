import 'package:flutter/material.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/custom_button.dart';
import 'package:khatabookn/views/home/widgets/daily%20_chart.dart';

import 'package:khatabookn/widgets/filled_box.dart';
import 'package:khatabookn/views/home/widgets/horizontal_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👋 Greeting Row
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Good Morning,",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Ali!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  FilledBox(
                    shape: BoxShape.circle,
                    padding: EdgeInsets.zero,
                    width: 50,
                    height: 50,
                    color: Theme.of(context).cardColor,
                    child: Center(
                      child: Icon(
                        LucideIcons.userCircle2,
                        size: 30,
                        color: AppTheme.grey,
                      ),
                    ),
                  ),
                ],
              ),

              30.kH,

              // 💰 Lifetime Spent
              FilledBox(
                width: double.infinity,
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Column(
                  children: [
                    Text(
                      "Lifetime Spent",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.grey,
                      ),
                    ),
                    Text(
                      "\$12,345.67",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      
                      ),
                    ),
                  ],
                ),
              ),

              25.kH,

              // 📊 Income + Expenses Row
              Row(
                children: [
                  Expanded(
                    child: FilledBox(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Monthly Income",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.grey,
                            ),
                          ),
                          Text(
                            "\$5,000",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.kW,
                  Expanded(
                    child: FilledBox(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Monthly Expenses",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.grey,
                            ),
                          ),
                          Text(
                            "\$2,500",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              30.kH,

              // 📈 Insights Section
              Text(
                "Spending Insights",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.white,
                ),
              ),

              15.kH,

              // 📊 Daily Avg Spending Chart
              const DailyAvgSpendingCard(),
              15.kH,
              CategorySpendingCard(),
              25.kH,
              FilledBox(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spending Alert",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.grey,
                      ),
                    ),
                    Text(
                      "You're spending too much this week",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                     
                      ),
                    ),
                    10.kH,
                    CustomButton(
                      onTap: () {},
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: (Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.white
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
