import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/models/src/products/product.dart';
import 'package:core/utils/utils.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  String formatCurrency(int? value) {
    if (value == null) return "-";
    return "Rp ${value.toString()}"; // nanti upgrade ke intl
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Katalog Produk")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading products"));
          }

          final docs = snapshot.data?.docs ?? [];
          final products = docs
              .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          if (products.isEmpty) {
            return const Center(child: Text("Tidak ada produk"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 2 kolom
              mainAxisSpacing: 60,
              crossAxisSpacing: 50,
              childAspectRatio: 0.85, // tinggi > lebar
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return ProductCard(product: p, formatCurrency: formatCurrency);
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final String Function(int?) formatCurrency;

  const ProductCard({
    super.key,
    required this.product,
    required this.formatCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk (pakai placeholder dulu)
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Container(
                color: Colors.grey.shade200,
                width: double.infinity,
                child: product.imageUrl != null
                    ? Image.network(product.imageUrl!, fit: BoxFit.cover)
                    : const Icon(Icons.image, size: 60, color: Colors.grey),
              ),
            ),
          ),

          // Status available / out of stock
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              product.isAvailable == true ? "Available" : "Out of Stock",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: product.isAvailable == true ? Colors.blue : Colors.red,
              ),
            ),
          ),

          // Nama produk
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              product.name ?? "-",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Harga + tombol WA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatCurrency(product.price),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () => openWhatsApp(product),
                  icon: const Icon(Icons.whatshot, color: Colors.green),
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
