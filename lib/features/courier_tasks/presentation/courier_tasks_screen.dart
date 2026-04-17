import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CourierTasksScreen extends ConsumerWidget {
  const CourierTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(ecoCycleStoreProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Penjemputan'),
        actions: [
          IconButton(
            onPressed: () => ref.read(syncRepositoryProvider).runMockSync(),
            icon: const Icon(Icons.sync_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          GradientHeroCard(
            title: 'Kurir siap jalan',
            subtitle:
                '${store.courierTasks.length} tugas aktif dengan ${store.syncQueue.length} perubahan belum tersinkron.',
            child: const InfoPill(label: 'Mode task-focused'),
          ),
          const SizedBox(height: 20),
          ...store.courierTasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: InkWell(
                  onTap: () => context.go('/courier/tasks/${task.id}'),
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          InfoPill(label: taskStatusLabel(task.status)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(task.customerName),
                      const SizedBox(height: 4),
                      Text(task.address),
                      const SizedBox(height: 10),
                      Text(
                        '${formatShortDate(task.scheduledFor)} • ${task.weightKg} kg • ${formatCurrency(task.payout)}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
