import 'package:flutter/material.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/widgets/filled_box.dart';

class CategorySpendingCard extends StatefulWidget {
  const CategorySpendingCard({super.key});

  @override
  State<CategorySpendingCard> createState() => _CategorySpendingCardState();
}

class _CategorySpendingCardState extends State<CategorySpendingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Map<String, double> data = {
    'Food': 10.0,
    'Travel': 120.0,
    'Shopping': 180.0,
    'Bills': 140.0,
    'Entertainment': 80.0,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = data.values.isEmpty
        ? 1.0
        : data.values.reduce((a, b) => a > b ? a : b);

    return FilledBox(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending by Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                 color: Theme.of(context).disabledColor,
              ),
            ),
            const SizedBox(height: 12),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  children: data.entries.map((entry) {
                    final category = entry.key;
                    final value = entry.value;
                    final targetFraction = (value / maxValue).clamp(0.0, 1.0);
                    final animatedFraction =
                        targetFraction * _controller.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '\$${value.toStringAsFixed(0)}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 13,
                                  
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final barMaxWidth = constraints.maxWidth;
                              final filledWidth =
                                  barMaxWidth * animatedFraction;

                              return Stack(
                                children: [
                                  Container(
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppTheme.grey.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Container(
                                    width: filledWidth,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
