import 'package:flutter/material.dart';


class BuyEcoScreen extends StatefulWidget {
  const BuyEcoScreen({Key? key}) : super(key: key);

  @override
  State<BuyEcoScreen> createState() => _BuyEcoScreenState();
}

class _BuyEcoScreenState extends State<BuyEcoScreen> {
  final List<EcoProduct> ecoProducts = [
    EcoProduct(
      id: 1,
      name: 'Plastik Daur Ulang',
      category: 'Plastik',
      price: 25000,
      image: 'assets/plastic.png',
      description: 'Plastik bersih hasil daur ulang untuk kerajinan',
    ),
    EcoProduct(
      id: 2,
      name: 'Kain Bekas',
      category: 'Kain',
      price: 15000,
      image: 'assets/fabric.png',
      description: 'Kain berkualitas untuk membuat tas dan dekorasi',
    ),
    EcoProduct(
      id: 3,
      name: 'Kayu Bekas',
      category: 'Kayu',
      price: 35000,
      image: 'assets/wood.png',
      description: 'Kayu utuh untuk proyek furniture dan kerajinan',
    ),
    EcoProduct(
      id: 4,
      name: 'Logam Daur Ulang',
      category: 'Logam',
      price: 30000,
      image: 'assets/metal.png',
      description: 'Logam berkualitas untuk kerajinan metalwork',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belanja Bahan Daur Ulang'),
        backgroundColor: const Color.fromARGB(255, 30, 142, 161),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: ecoProducts.length,
        itemBuilder: (context, index) {
          final product = ecoProducts[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(EcoProduct product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Icon(Icons.image, size: 50),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  product.category,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(
                    color: const Color.fromARGB(255, 30, 142, 161),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} ditambahkan')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 30, 142, 161),
                    ),
                    child: const Text('Beli'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EcoProduct {
  final int id;
  final String name;
  final String category;
  final int price;
  final String image;
  final String description;

  EcoProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
  });
}