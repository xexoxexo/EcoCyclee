import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(ecoCycleStoreProvider);
    final user = store.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Wallet')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          GradientHeroCard(
            title: user?.name ?? 'Pengguna EcoCycle',
            subtitle:
                '${user?.email ?? ''} • ${user?.points ?? 0} poin • saldo ${formatCurrency(user?.walletBalance ?? 0)}',
            child: FilledButton.tonal(
              onPressed: () => context.go('/user/notifications'),
              child: const Text('Lihat notifikasi'),
            ),
          ),
          const SizedBox(height: 20),
          const EcoSection(title: 'Riwayat poin', child: SizedBox.shrink()),
          ...store.pointHistory.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.title),
                  subtitle: Text(formatShortDate(item.sync.createdAt)),
                  trailing: Text('+${item.points}'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () async {
              await ref.read(authRepositoryProvider).signOut();
              if (context.mounted) {
                context.go('/auth');
              }
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
