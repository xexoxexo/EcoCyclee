import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/core/services/eco_cycle_store.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(ecoCycleStoreProvider);
    final user = store.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoCycle Hari Ini'),
        actions: [
          IconButton(
            onPressed: () => context.go('/user/notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          GradientHeroCard(
            title: 'Halo, ${user?.name.split(' ').first ?? 'EcoFriend'}',
            subtitle:
                'Dompet ${formatCurrency(user?.walletBalance ?? 0)} • ${user?.points ?? 0} ECOPoints • ${store.syncQueue.length} antrian sync',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                FilledButton.tonal(
                  onPressed: () => context.go('/user/sell'),
                  child: const Text('Jual Sampah'),
                ),
                FilledButton.tonal(
                  onPressed: () => context.go('/user/shop'),
                  child: const Text('Belanja Ulang'),
                ),
                FilledButton.tonal(
                  onPressed: () => context.go('/user/planner'),
                  child: const Text('Atur Pickup'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          EcoSection(
            title: 'Ringkasan cepat',
            action: TextButton(
              onPressed: () => ref.read(syncRepositoryProvider).runMockSync(),
              child: const Text('Jalankan mock sync'),
            ),
            child: _SummaryGrid(store: store),
          ),
          const SizedBox(height: 20),
          EcoSection(
            title: 'ECOducation',
            action: TextButton(
              onPressed: () async {
                final pending = store.educationModules.firstWhere(
                  (module) => !module.completed,
                  orElse: () => store.educationModules.first,
                );
                await ref.read(pointsRepositoryProvider).completeModule(pending.id);
              },
              child: const Text('Selesaikan modul'),
            ),
            child: Column(
              children: store.educationModules
                  .map(
                    (module) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _EducationCard(module: module),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          EcoSection(
            title: 'Produk daur ulang unggulan',
            action: TextButton(
              onPressed: () => context.go('/user/shop'),
              child: const Text('Lihat semua'),
            ),
            child: Column(
              children: store.products.take(2).map((product) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EcoSurfaceCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(product.name, style: theme.textTheme.titleMedium),
                      subtitle: Text(product.material),
                      trailing: Text(formatCurrency(product.price)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.store});

  final EcoCycleStore store;

  @override
  Widget build(BuildContext context) {
    final items = <(String, String, IconData)>[
      ('Transaksi', store.sellTransactions.length.toString(), Icons.receipt_long),
      ('Pickup aktif', store.pickupSchedules.length.toString(), Icons.route),
      (
        'Poin masuk',
        store.pointHistory
            .fold<int>(0, (sum, item) => sum + item.points)
            .toString(),
        Icons.stars_rounded,
      ),
      ('Komunitas', store.posts.length.toString(), Icons.groups_2_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return EcoSurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.$3),
              const Spacer(),
              Text(
                item.$2,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              Text(item.$1),
            ],
          ),
        );
      },
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({required this.module});

  final EducationModule module;

  @override
  Widget build(BuildContext context) {
    return EcoSurfaceCard(
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: module.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              module.completed ? Icons.check_rounded : Icons.school_outlined,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(module.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(module.subtitle),
              ],
            ),
          ),
          InfoPill(label: module.completed ? 'Selesai' : '${module.durationMinutes} mnt'),
        ],
      ),
    );
  }
}
