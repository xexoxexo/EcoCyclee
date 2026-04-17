import 'package:flutter/material.dart';

class TukarPointScreen extends StatefulWidget {
  const TukarPointScreen({super.key});

  @override
  State<TukarPointScreen> createState() => _TukarPointScreenState();
}

class _TukarPointScreenState extends State<TukarPointScreen> {
  int currentPoints = 1250;

  final List<Map<String, dynamic>> rewards = [
    {
      'name': 'Voucher Belanja Rp 50.000',
      'points': 500,
      'icon': Icons.shopping_bag,
      'color': Colors.green,
    },
    {
      'name': 'Tas Ramah Lingkungan',
      'points': 800,
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
    },
    {
      'name': 'Botol Minum Eco-Friendly',
      'points': 600,
      'icon': Icons.water_drop,
      'color': Colors.cyan,
    },
    {
      'name': 'Donasi Pohon',
      'points': 1000,
      'icon': Icons.eco,
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tukar Point'),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPointCard(),
          const SizedBox(height: 24),
          const Text(
            'Pilih Reward',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildRewardsList(),
        ],
      ),
    );
  }

  Widget _buildPointCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade700],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text(
              'Poin Anda',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$currentPoints',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Poin tersedia untuk ditukar',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        final canRedeem = currentPoints >= reward['points'];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: reward['color'],
                  child: Icon(
                    reward['icon'],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${reward['points']} poin',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: canRedeem
                      ? () => _showRedeemDialog(reward['name'])
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canRedeem ? Colors.green : Colors.grey.shade300,
                  ),
                  child: Text(
                    canRedeem ? 'Tukar' : 'Kurang',
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRedeemDialog(String rewardName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Penukaran'),
        content: Text('Tukar $rewardName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$rewardName berhasil ditukar!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Tukar'),
          ),
        ],
      ),
    );
  }
}
extension TukarPointExtension on _TukarPointScreenState {
  void initializeAdditionalRewards() {
    rewards.addAll([
      {
        'name': 'Pulsa Rp 20.000',
        'points': 300,
        'icon': Icons.phone,
        'color': Colors.orange,
      },
      {
        'name': 'Paket Internet 1GB',
        'points': 400,
        'icon': Icons.signal_cellular_alt,
        'color': Colors.purple,
      },
      {
        'name': 'Paket Sembako',
        'points': 700,
        'icon': Icons.shopping_cart,
        'color': Colors.brown,
      },
    ]);
  }
}