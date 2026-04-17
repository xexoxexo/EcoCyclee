import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourierShellScreen extends StatelessWidget {
  const CourierShellScreen({
    super.key,
    required this.location,
    required this.child,
  });

  final String location;
  final Widget child;

  int get currentIndex => location.startsWith('/courier/earnings') ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.go(index == 0 ? '/courier/tasks' : '/courier/earnings');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Pendapatan',
          ),
        ],
      ),
    );
  }
}
