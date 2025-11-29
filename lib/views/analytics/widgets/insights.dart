import 'package:flutter/material.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/widgets/filled_box.dart';
import 'package:lucide_icons/lucide_icons.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color? iconColor;
  final Color? accentColor;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = LucideIcons.lightbulb,
    this.iconColor,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppTheme.primaryColor;
    final effectiveAccentColor = accentColor ?? AppTheme.primaryColor;

    return FilledBox(
      color: AppTheme.cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 10),
              child: Text(
                'Insights',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.grey,
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: effectiveAccentColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          
                  
                  // Icon Container with gradient background
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          effectiveIconColor.withOpacity(0.2),
                          effectiveIconColor.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: effectiveIconColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.grey,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Optional arrow indicator
                  Icon(
                    LucideIcons.chevronRight,
                    color: AppTheme.grey.withOpacity(0.5),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}