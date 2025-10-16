// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:khatabookn/theme/colors.dart';

// class ScaffoldWithNavBar extends StatefulWidget {
//   final StatefulNavigationShell navigationShell;
//   const ScaffoldWithNavBar({super.key, required this.navigationShell});

//   @override
//   State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
// }

// class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
//   late PageController _pageController;
//   int _currentIndex = 0;

//   final List<String> routes = [
//     '/home',
//     '/analytics',
//     '/add',
//     '/loans',
//     '/settings',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentIndex);
//   }

//   void _onItemTapped(int index) {
//     setState(() => _currentIndex = index);
//     _pageController.jumpToPage(index);
//     widget.navigationShell.goBranch(index);
//   }

//   void _onPageChanged(int index) {
//     setState(() => _currentIndex = index);
//     widget.navigationShell.goBranch(index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: _onPageChanged,
//         children: [
//           widget.navigationShell.branchNavigators[0],
//           widget.navigationShell.branchNavigators[1],
//           widget.navigationShell.branchNavigators[2],
//           widget.navigationShell.branchNavigators[3],
//           widget.navigationShell.branchNavigators[4],
//         ],
//       ),

//       // 🧭 Custom Bottom Nav
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         decoration: BoxDecoration(
//           color: AppTheme.cardColor,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(Icons.home_rounded, 0, 'Home'),
//             _buildNavItem(Icons.analytics_rounded, 1, 'Analytics'),

//             // Add button (center)
//             GestureDetector(
//               onTap: () => _onItemTapped(2),
//               child: Container(
//                 height: 56,
//                 width: 56,
//                 decoration: BoxDecoration(
//                   color: AppTheme.primaryColor,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppTheme.primaryColor.withOpacity(0.4),
//                       blurRadius: 10,
//                     ),
//                   ],
//                 ),
//                 child: const Icon(Icons.add, color: Colors.white, size: 28),
//               ),
//             ),

//             _buildNavItem(Icons.account_balance_wallet_rounded, 3, 'Loans'),
//             _buildNavItem(Icons.settings_rounded, 4, 'Settings'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, int index, String label) {
//     final isSelected = _currentIndex == index;
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isSelected ? AppTheme.primaryColor : AppTheme.grey,
//             size: 26,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               color: isSelected ? AppTheme.primaryColor : AppTheme.grey,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
