import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:khatabookn/widgets/filled_box.dart';
import 'package:khatabookn/widgets/snack_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddNewTransactionScreen extends StatefulWidget {
  const AddNewTransactionScreen({super.key});

  @override
  State<AddNewTransactionScreen> createState() => _AddNewTransactionScreenState();
}

class _AddNewTransactionScreenState extends State<AddNewTransactionScreen> {
  int _selectedTab = 0;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Salary',
    'Bills',
    'Other',
  ];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppTheme.primaryColor,
              surface: AppTheme.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _addTransaction() {
    showSnackBar(context, "Transaction added successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    
        elevation: 0,
        title: const Text('Add Transaction'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 Tabs
            FilledBox(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  _buildTabButton("Expense", 0),
                  _buildTabButton("Income", 1),
                ],
              ),
            ),

            25.kH,

            // 💰 Amount field
            CustomTextField(
              textInputType: const TextInputType.numberWithOptions(),
              hintText: "\$0",
              hintTextStyle: TextStyle(fontSize: 52, color: AppTheme.grey),
              fillColor: Theme.of(context).cardColor,
              filled: true,
              padding: const EdgeInsets.all(25),
              focusedBorder: const OutlineInputBorder(
                
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorderColor: Theme.of(context).cardColor,
              focusedBorderColor: Theme.of(context).cardColor,
             
            
              cursorTextStyle:
                  TextStyle(fontSize: 52),
              controller: _amountController,
            ),

            25.kH,

            // 📂 Category Dropdown
            Row(
              children: [
                Expanded(
                  child: FilledBox(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        hint:  Text(
                          'Select Category',
                          // style: TextStyle(color:Theme.of(context).disabledColor),
                        ),
                        dropdownColor:Theme.of(context).cardColor,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: _categories.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Text(
                              cat,
                              style: TextStyle(color: AppTheme.primaryColor),
                           
              
                        
                            ),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedCategory = val),
                      ),
                    ),
                  ),
                ),
                10.kW,
                GestureDetector(
                  onTap: () => Go.named(context,MyRouter.cat),
                  child: FilledBox(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(17),
                    child: Icon(LucideIcons.plusCircle, color: AppTheme.grey, size: 30),
                  ),
                ),
              ],
            ),

            25.kH,

            // 📅 Date Picker
            GestureDetector(
              onTap: _pickDate,
              child: FilledBox(
                color:Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                     Icon(Icons.calendar_today, color: Theme.of(context).disabledColor,),
                  ],
                ),
              ),
            ),

            25.kH,

            // 📝 Notes
            FilledBox(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _noteController,
                maxLines: 4,
             
                decoration:  InputDecoration(
                  hintText: 'Notes',
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor,),
                  border: InputBorder.none,
                ),
              ),
            ),

            35.kH,

           
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
              color: active ? Colors.white : Theme.of(context).disabledColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
