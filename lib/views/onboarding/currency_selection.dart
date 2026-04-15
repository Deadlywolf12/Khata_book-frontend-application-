import 'package:flutter/material.dart';
import 'package:khatabookn/helper/alert_dialog.dart';
import 'package:khatabookn/helper/get_flag.dart';
import 'package:khatabookn/models/currency_models.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/utils/helper/username_gen.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CurrencySelectionScreen extends StatefulWidget {
  final bool pinStatus;
  final String username;
  final String accType;
  
  const CurrencySelectionScreen({
    super.key, 
    required this.pinStatus, 
    required this.username, 
    required this.accType
  });

  @override
  State<CurrencySelectionScreen> createState() => _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {

  late Currency selectedCurrency;

  @override
  void initState() {
    super.initState();
    
    selectedCurrency = CurrencyModel.currencies.firstWhere(
      (c) => c.code == 'USD',
      orElse: () => CurrencyModel.currencies[0],
    );
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
                    "Select Currency",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  10.kH,
                  const Text(
                    "Select your preferred Currency type for your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppTheme.grey,
                      height: 1.5,
                    ),
                  ),
                  40.kH,
                  
                  // --- Currency Selector Card ---
                  GestureDetector(
                    onTap: () => _showCurrencyPicker(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          // Flag Circle
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E3545),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                getFlag(selectedCurrency.code),
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          14.kW,
                          // Currency Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PRIMARY CURRENCY',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.grey,
                                    letterSpacing: 2,
                                  ),
                                ),
                                2.kH,
                                Text(
                                  '${selectedCurrency.code} - ${selectedCurrency.subtitle}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.expand_more,
                            color: AppTheme.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                
                ],
              ),
            ),

            
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton.small(onPressed: (){
 Go.namedReplace(context, MyRouter.createAvatar,extra: {
                            'pin': widget.pinStatus,
                            'username': widget.username,
                            'accType': widget.accType,
                            'currency': selectedCurrency,
                          });

      },foregroundColor: AppTheme.white,backgroundColor: AppTheme.primaryColor,child: Icon(LucideIcons.arrowRight),),
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              20.kH,
              const Text(
                "Select Currency",
                style: TextStyle(
                  color: AppTheme.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold
                ),
              ),
              15.kH,
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: CurrencyModel.currencies.length,
                  itemBuilder: (context, index) {
                    final currency = CurrencyModel.currencies[index];
                    final isSelected = selectedCurrency.code == currency.code;
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Text(
                          getFlag(currency.code), 
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(
                          currency.title, 
                          style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold)
                        ),
                        subtitle: Text(
                          currency.subtitle, 
                          style: const TextStyle(color: AppTheme.grey)
                        ),
                        trailing: isSelected 
                          ? const Icon(Icons.check_circle, color: AppTheme.primaryColor)
                          : null,
                        onTap: () {
                          setState(() {
                            selectedCurrency = currency;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}