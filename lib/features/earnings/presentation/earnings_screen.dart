import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EarningsScreen extends ConsumerWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(ecoCycleStoreProvider).courierTasks;
    final completed = tasks.where((task) => task.status == TaskStatus.completed);
    final total = tasks.fold<double>(0, (sum, task) => sum + task.payout);

    return Scaffold(
      appBar: AppBar(title: const Text('Pendapatan Kurir')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          GradientHeroCard(
            title: formatCurrency(total),
            subtitle: 'Estimasi pendapatan dari semua tugas yang telah ditugaskan di MVP.',
            child: InfoPill(label: '${completed.length} tugas selesai'),
          ),
          const SizedBox(height: 20),
          ...tasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(task.title),
                  subtitle: Text(task.customerName),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formatCurrency(task.payout)),
                      const SizedBox(height: 6),
                      InfoPill(label: taskStatusLabel(task.status)),
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
