import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserShellScreen extends StatelessWidget {
  const UserShellScreen({
    super.key,
    required this.location,
    required this.child,
  });

  final String location;
  final Widget child;

  int get currentIndex {
    if (location.startsWith('/sell')) {
      return 1;
    }
    if (location.startsWith('/beli')) {
      return 1;
    }
    if (location.startsWith('/tukar-point')) {
      return 2;
    }
    if (location.startsWith('/planner')) {
      return 3;
    }
    if (location.startsWith('/community')) {
      return 5;
    }
    if (location.startsWith('/profile')) {
      return 6;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    const destinations = [
      '/home',
      '/sell',
      '/tukar-point',
      '/beli',
      '/planner',
      '/community',
      '/profile',
    ];
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.go(destinations[index]),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.scale_outlined), label: 'Jual'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard_outlined), label: 'Tukar Point'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Beli'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_2_outlined),
            label: 'Komunitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
