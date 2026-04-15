import 'package:flutter/material.dart';
import 'package:khatabookn/helper/get_flag.dart';
import 'package:khatabookn/models/currency_models.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';


class ProfileCompletedScreen extends StatelessWidget {
  final String username;
  final int avatarUrl;
  final Currency currency;
  final String accType;
  final bool pinStatus;
  const ProfileCompletedScreen({Key? key, required this.username, required this.avatarUrl, required this.currency, required this.accType, required this.pinStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Stack(
        children: [
          // Ambient background glow
          Positioned(
            top: -100,
            left: -100,
            right: -100,
            bottom: -100,
            child: Center(
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(0.08),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  // ── Header ──────────────────────────────────────────
                  24.kH,
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.15),
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
               24.kH,
                  const Text(
                    'Welcome Aboard',
                    style: TextStyle(
                     
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                  color: AppTheme.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  6.kH,
                  const Text(
                    'PROFILE CREATED',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.grey,
                      letterSpacing: 4,
                    ),
                  ),

                  // ── Card ────────────────────────────────────────────
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        // Avatar
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 128,
                              height: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: AppTheme.cardColor,
                                border: Border.all(
                                  color: const Color(0xFF5B4041).withOpacity(0.2),
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Image.asset(
                                  'assets/avatar/avatar$avatarUrl.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -6,
                              right: -6,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFFB2B7), Color(0xFFFF516A)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppTheme.cardColor,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.verified,
                                  color: AppTheme.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Name & Badge
                        24.kH,
                         Text(
                          username,
                          style: TextStyle(
                         
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.white,
                          ),
                        ),
                    8.kH,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${accType.toUpperCase()} ACCOUNT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                              letterSpacing: 3,
                            ),
                          ),
                        ),

                        // Currency Row
                         28.kH,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:  AppTheme.grey.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppTheme.cardColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child:  Center(
                                  child: Text(
                                    getFlag(currency.code),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                                14.kW,
                               Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  const  Text(
                                      'PRIMARY CURRENCY',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.grey,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    2.kH,
                                    Text(
                                      '${currency.code} - ${currency.subtitle}',
                                      style: TextStyle(
                                    
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const Icon(
                              //   Icons.expand_more,
                              //   color: AppTheme.grey,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Actions ─────────────────────────────────────────
                   40.kH,
                  // Skip button
                  Container(
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient:  LinearGradient(
                        colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF92002A).withOpacity(0.25),
                          blurRadius: 32,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: const Center(
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Take Tour button
                  Container(
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E3545).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
                        child: Center(
                          child: Text(
                            'Take Tour',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Branding ─────────────────────────────────────────
                  const SizedBox(height: 32),
                  const Text(
                    'KHATA BOOK',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF334155),
                      letterSpacing: 6,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}