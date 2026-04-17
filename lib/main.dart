import 'package:ecocycle/app/app.dart';
import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/services/eco_cycle_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(const EcoCycleRoot());
}

class EcoCycleRoot extends StatelessWidget {
  const EcoCycleRoot({super.key, this.store});

  final EcoCycleStore? store;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (store != null)
          ecoCycleStoreProvider.overrideWith((ref) => store!),
      ],
      child: const EcoCycleApp(),
    );
  }
}
