import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'loading/loading_screen.dart';
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const GradientHeroCard(
                title: 'EcoCycle',
                subtitle:
                    'Jual sampah, atur penjemputan, belanja daur ulang, dan jalankan operasional kurir dalam satu alur offline-first.',
                child: _BrandHighlights(),
              ),
              const SizedBox(height: 24),
              Text(
                'Bangun kebiasaan sirkular dari rumah, komunitas, sampai titik pickup.',
                style: theme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Konsep UI ini memadukan nuansa hijau laut, aksen emas, dan kartu berbentuk organik agar terasa modern tetapi tetap dekat dengan tema lingkungan.',
                style: theme.textTheme.bodyLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () async {
                  await ref.read(authRepositoryProvider).completeOnboarding();
                  if (context.mounted) {
                    context.go('/auth');
                  }
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                ),
                child: const Text('Mulai Sekarang'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => Dialog(
                      backgroundColor: const Color.fromARGB(167, 141, 141, 141),
                      elevation: 0,
                      child: Stack(
                        children: [
                          const EcoCycleLoadingScreen(
                            isAutoNavigate: false,
                          ),
                          Positioned(
                            top: 32,
                            right: 16,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(58),
                ),
                child: const Text('Lihat Konsep Aplikasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandHighlights extends StatelessWidget {
  const _BrandHighlights();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const [
        InfoPill(label: 'Offline-first'),
        InfoPill(label: 'User + Courier'),
        InfoPill(label: 'ECOSell'),
        InfoPill(label: 'Marketplace'),
      ],
    );
  }
}
