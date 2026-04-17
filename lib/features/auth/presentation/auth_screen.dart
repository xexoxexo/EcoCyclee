import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Masuk ke EcoCycle')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Pilih peran untuk melihat pengalaman aplikasi yang sesuai.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          _RoleCard(
            title: 'Masuk sebagai Pengguna',
            subtitle:
                'Akses jual sampah, planner pickup, poin loyalitas, komunitas, dan marketplace.',
            icon: Icons.eco_outlined,
            color: const Color(0xFFE8F7F6),
            onTap: () async {
              await ref.read(authRepositoryProvider).signInAsRole(AppRole.user);
              if (context.mounted) {
                context.go('/user/home');
              }
            },
          ),
          const SizedBox(height: 16),
          _RoleCard(
            title: 'Masuk sebagai Kurir',
            subtitle:
                'Lihat daftar tugas, update status penjemputan, dan pantau pendapatan harian.',
            icon: Icons.route_outlined,
            color: const Color(0xFFFFF4D8),
            onTap: () async {
              await ref.read(authRepositoryProvider).signInAsRole(AppRole.courier);
              if (context.mounted) {
                context.go('/courier/tasks');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return EcoSurfaceCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(subtitle, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}
