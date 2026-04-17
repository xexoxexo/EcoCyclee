import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(ecoCycleStoreProvider).notifications;
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: notifications
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: EcoSurfaceCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.notifications_active_outlined),
                    title: Text(item.title),
                    subtitle: Text('${item.message}\n${formatShortDate(item.createdAt)}'),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
