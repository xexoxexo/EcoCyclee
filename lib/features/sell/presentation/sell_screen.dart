import 'package:ecocycle/app/providers.dart';
import 'package:ecocycle/core/models/app_models.dart';
import 'package:ecocycle/core/utils/formatters.dart';
import 'package:ecocycle/shared/widgets/eco_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellScreen extends ConsumerStatefulWidget {
  const SellScreen({super.key});

  @override
  ConsumerState<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends ConsumerState<SellScreen> {
  WasteType _wasteType = WasteType.plastik;
  PaymentMethod _paymentMethod = PaymentMethod.ewallet;
  final TextEditingController _weightController = TextEditingController(text: '3');
  bool _pickupRequested = true;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(ecoCycleStoreProvider);
    final weight = double.tryParse(_weightController.text) ?? 0;
    final estimatedPrice = switch (_wasteType) {
      WasteType.plastik => 5000,
      WasteType.kertas => 3000,
      WasteType.kaca => 2500,
      WasteType.logam => 7000,
    } * weight;

    return Scaffold(
      appBar: AppBar(title: const Text('ECOSell')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 120),
        children: [
          GradientHeroCard(
            title: 'Jual sampah lebih cepat',
            subtitle:
                'Catat berat, pilih metode pencairan, lalu simpan ke lokal sebelum sinkron otomatis.',
            child: Text(
              'Estimasi saat ini ${formatCurrency(estimatedPrice.toDouble())}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 20),
          EcoSurfaceCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<WasteType>(
                  initialValue: _wasteType,
                  decoration: const InputDecoration(labelText: 'Jenis sampah'),
                  items: WasteType.values
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(wasteTypeLabel(type)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => _wasteType = value!),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Berat (kg)',
                    hintText: 'Contoh: 4.5',
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<PaymentMethod>(
                  initialValue: _paymentMethod,
                  decoration: const InputDecoration(labelText: 'Metode pencairan'),
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
                const SizedBox(height: 16),
                SwitchListTile(
                  value: _pickupRequested,
                  title: const Text('Butuh penjemputan'),
                  subtitle: const Text('Jika aktif, jadwal pickup dibuat otomatis.'),
                  onChanged: (value) => setState(() => _pickupRequested = value),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () async {
                    await ref.read(sellRepositoryProvider).submitSell(
                          wasteType: _wasteType,
                          weightKg: weight,
                          paymentMethod: _paymentMethod,
                          pickupRequested: _pickupRequested,
                        );
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transaksi tersimpan ke antrian lokal.'),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                  ),
                  child: const Text('Simpan transaksi'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const EcoSection(
            title: 'Transaksi terbaru',
            child: SizedBox.shrink(),
          ),
          ...store.sellTransactions.map(
            (transaction) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EcoSurfaceCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(wasteTypeLabel(transaction.wasteType)),
                  subtitle: Text(
                    '${transaction.weightKg} kg • ${paymentMethodLabel(transaction.paymentMethod)}',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formatCurrency(transaction.estimatedPrice)),
                      const SizedBox(height: 6),
                      InfoPill(label: syncStatusLabel(transaction.sync.syncStatus)),
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
