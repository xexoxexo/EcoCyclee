import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourierTaskDetailScreen extends ConsumerWidget {
  const CourierTaskDetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(ecoCycleStoreProvider).findTask(taskId);
    if (task == null) {
      return const Scaffold(
        body: Center(child: Text('Tugas tidak ditemukan')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Tugas')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          GradientHeroCard(
            title: task.title,
            subtitle: '${task.customerName} • ${task.address}',
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                InfoPill(label: taskStatusLabel(task.status)),
                InfoPill(label: '${task.weightKg} kg'),
                InfoPill(label: formatCurrency(task.payout)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          EcoSurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jadwal ${formatShortDate(task.scheduledFor)}'),
                const SizedBox(height: 8),
                Text('Catatan: ${task.notes ?? 'Tidak ada catatan tambahan'}'),
                const SizedBox(height: 8),
                Text('Sync: ${syncStatusLabel(task.sync.syncStatus)}'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () async {
              await ref.read(courierTasksRepositoryProvider).advanceTask(task.id);
              if (!context.mounted) {
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Status tugas diperbarui.')),
              );
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
            child: const Text('Lanjutkan status tugas'),
          ),
        ],
      ),
    );
  }
}
