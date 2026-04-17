import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketplaceScreen extends ConsumerStatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  ConsumerState<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends ConsumerState<MarketplaceScreen> {
  PaymentMethod _paymentMethod = PaymentMethod.qris;

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(ecoCycleStoreProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('ECOBuy Marketplace')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 140),
        children: [
          GradientHeroCard(
            title: 'Belanja hasil daur ulang',
            subtitle:
                'Semua produk didesain sebagai etalase UI MVP. Pembayaran v1 diproses lewat adapter mock.',
            child: Text(
              'Isi keranjang: ${store.cart.items.length} item',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          ...store.products.map(
            (product) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7F8F7),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(Icons.shopping_bag_outlined),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text('${product.material} • ${product.sellerName}'),
                            ],
                          ),
                        ),
                        Text(formatCurrency(product.price)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(product.description),
                    const SizedBox(height: 12),
                    FilledButton.tonal(
                      onPressed: () async {
                        await ref.read(marketplaceRepositoryProvider).addToCart(product);
                      },
                      child: const Text('Tambah ke keranjang'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<PaymentMethod>(
                initialValue: _paymentMethod,
                decoration: const InputDecoration(labelText: 'Metode pembayaran'),
                items: PaymentMethod.values
                    .map(
                      (method) => DropdownMenuItem(
                        value: method,
                        child: Text(paymentMethodLabel(method)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _paymentMethod = value!),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total ${formatCurrency(store.cart.totalAmount)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  FilledButton(
                    onPressed: store.cart.items.isEmpty
                        ? null
                        : () async {
                            await ref
                                .read(marketplaceRepositoryProvider)
                                .checkout(_paymentMethod);
                            if (!mounted) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Checkout mock berhasil dibuat.'),
                              ),
                            );
                          },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
