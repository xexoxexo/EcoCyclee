import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlannerScreen extends ConsumerWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(ecoCycleStoreProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('ECOPlanner')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          GradientHeroCard(
            title: 'Rencanakan pickup tanpa ribet',
            subtitle:
                'Jadwal baru akan disimpan lebih dulu di perangkat dan masuk ke antrian sync ketika jaringan stabil.',
            child: FilledButton.tonal(
              onPressed: () async {
                await ref.read(plannerRepositoryProvider).createManualPickupSchedule(
                      scheduledFor: DateTime.now().add(const Duration(days: 2)),
                      location: 'Titik kumpul RT 03',
                    );
              },
              child: const Text('Tambah jadwal cepat'),
            ),
          ),
          const SizedBox(height: 20),
          ...store.pickupSchedules.map(
            (schedule) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            schedule.location,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        InfoPill(label: schedule.status.name),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Jadwal: ${formatShortDate(schedule.scheduledFor)}'),
                    const SizedBox(height: 4),
                    Text('Kurir: ${schedule.courierName ?? 'Belum ditentukan'}'),
                    const SizedBox(height: 8),
                    Text('Status sync: ${syncStatusLabel(schedule.sync.syncStatus)}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
