import 'package:flutter/material.dart';
import 'package:khatabookn/theme/colors.dart';
import 'package:khatabookn/widgets/filled_box.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoanDetailScreen extends StatefulWidget {
  final String userName;
  final String totalToTake;
  final String totalToGive;

  const LoanDetailScreen({
    super.key,
    required this.userName,
    required this.totalToTake,
    required this.totalToGive,
  });

  @override
  State<LoanDetailScreen> createState() => _LoanDetailScreenState();
}

class _LoanDetailScreenState extends State<LoanDetailScreen>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(

      appBar: AppBar(
   
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: AppTheme.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Loan Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppTheme.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.moreVertical, color: AppTheme.white),
            onPressed: () {
              // Show menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                  child: Text(
                    widget.userName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Total Summary Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'To Take',
                        amount: widget.totalToTake,
                        color: AppTheme.green,
                        icon: LucideIcons.arrowDownCircle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'To Give',
                        amount: widget.totalToGive,
                        color: Colors.red,
                        icon: LucideIcons.arrowUpCircle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // History Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
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
              unselectedLabelColor: AppTheme.grey,
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'History'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTransactionsList(activeLoans),
                _buildTransactionsList(loanHistory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required Color color,
    required IconData icon,
  }) {
    return FilledBox(
      color: AppTheme.cardColor,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList(List<LoanTransaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.inbox,
              size: 64,
              color: AppTheme.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No transactions yet',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(transactions[index]);
      },
    );
  }

  Widget _buildTransactionCard(LoanTransaction transaction) {
    final isGiven = transaction.type == 'given';
    final statusColor = transaction.status == 'pending'
        ? Colors.orange
        : transaction.status == 'completed'
            ? AppTheme.green
            : Colors.red;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledBox(
        color: AppTheme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Type Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isGiven
                          ? Colors.red.withOpacity(0.1)
                          : AppTheme.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isGiven ? LucideIcons.arrowUpCircle : LucideIcons.arrowDownCircle,
                      color: isGiven ? Colors.red : AppTheme.green,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Reason and Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.reason,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transaction.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Amount
                  Text(
                    '${isGiven ? '-' : '+'}${transaction.amount}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isGiven ? Colors.red : AppTheme.green,
                    ),
                  ),
                ],
              ),

              // Status Badge
              if (transaction.status != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: statusColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        transaction.status!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Model class for loan transactions
class LoanTransaction {
  final String type; // 'given' or 'taken'
  final String reason;
  final String amount;
  final String date;
  final String? status; // 'pending', 'completed', 'overdue'

  LoanTransaction({
    required this.type,
    required this.reason,
    required this.amount,
    required this.date,
    this.status,
  });
}

// Sample data - Active Loans
final List<LoanTransaction> activeLoans = [
  LoanTransaction(
    type: 'taken',
    reason: 'Emergency medical expenses',
    amount: '\$800.00',
    date: 'Nov 28, 2024',
    status: 'pending',
  ),
  LoanTransaction(
    type: 'given',
    reason: 'Car repair',
    amount: '\$400.00',
    date: 'Nov 25, 2024',
    status: 'pending',
  ),
  LoanTransaction(
    type: 'taken',
    reason: 'House rent',
    amount: '\$1,200.00',
    date: 'Nov 20, 2024',
    status: 'overdue',
  ),
];

// Sample data - Loan History
final List<LoanTransaction> loanHistory = [
  LoanTransaction(
    type: 'given',
    reason: 'Business investment',
    amount: '\$2,500.00',
    date: 'Oct 15, 2024',
    status: 'completed',
  ),
  LoanTransaction(
    type: 'taken',
    reason: 'Education fees',
    amount: '\$650.00',
    date: 'Sep 10, 2024',
    status: 'completed',
  ),
  LoanTransaction(
    type: 'given',
    reason: 'Wedding expenses',
    amount: '\$1,100.00',
    date: 'Aug 5, 2024',
    status: 'completed',
  ),
  LoanTransaction(
    type: 'taken',
    reason: 'Travel expenses',
    amount: '\$320.00',
    date: 'Jul 22, 2024',
    status: 'completed',
  ),
];