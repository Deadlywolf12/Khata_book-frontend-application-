import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/theme/spacing.dart';
import 'package:khatabookn/widgets/custom_text_field.dart';
import 'package:khatabookn/widgets/filled_box.dart';
import 'package:khatabookn/widgets/snack_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddLoanScreen extends StatefulWidget {
  const AddLoanScreen({super.key});

  @override
  State<AddLoanScreen> createState() => _AddLoanScreenState();
}

class _AddLoanScreenState extends State<AddLoanScreen> {
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
    showSnackBar(context, "Loan added successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
   
        elevation: 0,
        title: const Text('Add Loan'),
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
                  _buildTabButton("Taking", 0),
                  _buildTabButton("Giving", 1),
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
              cursorTextStyle:
                  TextStyle(fontSize: 52),
              controller: _amountController,
            ),

            25.kH,
               //person
            FilledBox(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _noteController,
                maxLines: 1,
               
                decoration:  InputDecoration(
                  hintText: 'From whom, eg, John doe',
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                  border: InputBorder.none,
                ),
              ),
            ),


       
  25.kH,
            // 📅 Date Picker
            GestureDetector(
              onTap: _pickDate,
              child: FilledBox(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                     Icon(Icons.calendar_today, color: Theme.of(context).disabledColor),
                  ],
                ),
              ),
            ),

            25.kH,

            //reason
            FilledBox(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _noteController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration:  InputDecoration(
                  hintText: 'Reason',
                  hintStyle: TextStyle(color: Theme.of(context).disabledColor),
                  border: InputBorder.none,
                ),
              ),
            ),

            35.kH,

            // Add Loan Button
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
                  'Add Loan',
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
