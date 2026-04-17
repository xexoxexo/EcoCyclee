import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/core/services/eco_cycle_store.dart';
import 'package:ecocycle/features/auth/presentation/auth_screen.dart';
import 'package:ecocycle/features/community/presentation/community_screen.dart';
import 'package:ecocycle/features/courier_shell/presentation/courier_shell_screen.dart';
import 'package:ecocycle/features/courier_tasks/presentation/courier_task_detail_screen.dart';
import 'package:ecocycle/features/courier_tasks/presentation/courier_tasks_screen.dart';
import 'package:ecocycle/features/dashboard/presentation/dashboard_screen.dart';
import 'package:ecocycle/features/earnings/presentation/earnings_screen.dart';
import 'package:ecocycle/features/marketplace/presentation/marketplace_screen.dart';
import 'package:ecocycle/features/notifications/presentation/notifications_screen.dart';
import 'package:ecocycle/features/onboarding/presentation/onboarding_screen.dart';
import 'package:ecocycle/features/planner/presentation/planner_screen.dart';
import 'package:ecocycle/features/profile/presentation/profile_screen.dart';
import 'package:ecocycle/features/sell/presentation/sell_screen.dart';
import 'package:ecocycle/features/user_shell/presentation/user_shell_screen.dart';
import 'package:ecocycle/features/onboarding/presentation/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter buildRouter(EcoCycleStore store) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: store,
    redirect: (context, state) {
      final path = state.uri.path;
      final isSplash = path == '/splash';
      final isOnboarding = path == '/onboarding';
      final isAuth = path == '/auth';

      // Jangan redirect dari splash screen
      if (isSplash) {
        return null;
      }

      if (!store.hasCompletedOnboarding) {
        return isOnboarding ? null : '/onboarding';
      }

      if (!store.isAuthenticated) {
        return isAuth ? null : '/auth';
      }

      if (isOnboarding || isAuth) {
        return store.currentRole == AppRole.user
            ? '/home'
            : '/courier/tasks';
      }

      if (store.currentRole == AppRole.user && path.startsWith('/courier')) {
        return '/home';
      }

      if (store.currentRole == AppRole.courier && path.startsWith('/user')) {
        return '/courier/tasks';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const EcoCycleLoadingScreen(
          isAutoNavigate: true,
        ),
      ),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const EcoCycleLoadingScreen(
          isAutoNavigate: false,
        ),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const SizedBox.shrink(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return UserShellScreen(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/sell',
            builder: (context, state) => const SellScreen(),
          ),
          GoRoute(
            path: '/planner',
            builder: (context, state) => const PlannerScreen(),
          ),
          GoRoute(
            path: '/community',
            builder: (context, state) => const CommunityScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/shop',
            builder: (context, state) => const MarketplaceScreen(),
          ),
          GoRoute(
            path: '/notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CourierShellScreen(location: state.uri.path, child: child);
        },
        routes: [
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const CourierTasksScreen(),
            routes: [
              GoRoute(
                path: ':taskId',
                builder: (context, state) => CourierTaskDetailScreen(
                  taskId: state.pathParameters['taskId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/earnings',
            builder: (context, state) => const EarningsScreen(),
          ),
        ],
      ),
    ],
  );
}
