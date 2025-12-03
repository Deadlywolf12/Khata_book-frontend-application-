import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:khatabookn/route_structure/go_navigator.dart';
import 'package:khatabookn/route_structure/go_router.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/widgets/filled_box.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        appBar: AppBar(
      
          elevation: 0,
        
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(LucideIcons.plus, color: Colors.white),
                onPressed: () {
                 Go.named(context,MyRouter.newLoan);
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Summary Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Loans Taken',
                      amount: '\$5,420.00',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Loans Given',
                      amount: '\$3,200.00',
                    ),
                  ),
                ],
              ),
            ),
      
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Theme.of(context).disabledColor,
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Taken'),
                  Tab(text: 'Given'),
                ],
              ),
            ),
      
            const SizedBox(height: 16),
      
            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLoansList(loansTaken),
                  _buildLoansList(loansGiven),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
  }) {
    return FilledBox(
      color: Theme.of(context).cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).disabledColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
           
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoansList(List<LoanItem> loans) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: loans.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () =>Go.named(context, MyRouter.loanDashboard,params: {
          'userName':"rushan",
          'totalToTake':"1000",
          'totalToGive':'2000',
        }),
          child: _buildLoanCard(loans[index]));
      },
    );
  }

  Widget _buildLoanCard(LoanItem loan) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledBox(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 28,
            
                child: ClipOval(child: Image.asset('assets/avatar/f_avatar_4.jpeg'))
              ),
              const SizedBox(width: 12),
              
              // Name and Reason
              Expanded(
                child: Text(
                  loan.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  
                  ),
                ),
              ),
              
              // Amount
              Text(
                loan.amount,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
             
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model class for loan items
class LoanItem {
  final String name;
  final String reason;
  final String amount;

  LoanItem({
    required this.name,
    required this.reason,
    required this.amount,
  });
}

// Sample data - Loans Taken
final List<LoanItem> loansTaken = [
  LoanItem(
    name: 'John Smith',
    reason: 'Emergency medical expenses',
    amount: '\$1,200.00',
  ),
  LoanItem(
    name: 'Sarah Johnson',
    reason: 'Car repair',
    amount: '\$850.00',
  ),
  LoanItem(
    name: 'Michael Brown',
    reason: 'House renovation',
    amount: '\$2,500.00',
  ),
  LoanItem(
    name: 'Emily Davis',
    reason: 'Education fees',
    amount: '\$870.00',
  ),
];

// Sample data - Loans Given
final List<LoanItem> loansGiven = [
  LoanItem(
    name: 'David Wilson',
    reason: 'Business startup',
    amount: '\$1,500.00',
  ),
  LoanItem(
    name: 'Lisa Anderson',
    reason: 'Personal emergency',
    amount: '\$650.00',
  ),
  LoanItem(
    name: 'Robert Taylor',
    reason: 'Wedding expenses',
    amount: '\$1,050.00',
  ),
];