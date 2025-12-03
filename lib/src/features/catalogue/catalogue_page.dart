// lib/src/features/catalogue/presentation/catalogue_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/models/src/products/product.dart';
import 'package:core/utils/utils.dart';
import 'package:core/widgets/widgets.dart';

// warna sesuai pilihan
// top-of-wave (darker) and background tone (lighter)
const Color kHeaderBg = Color(0xfff9e8de); // #f9e8de (top of wave)
const Color kPrimary = Color(0xfffff8f7); // #fff8f7 (page background / bottom)
const Color kTextSoft = Color(0xff2e2c27); // #2e2c27

// lokal placeholder (agent/tool akan convert ke URL saat diperlukan)
const String kLocalPlaceholderImage =
    '/mnt/data/ChatGPT Image Nov 21, 2025, 10_05_24 AM.png';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  String formatCurrency(int? value) {
    if (value == null) return "-";
    final s = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+$)'),
      (m) => '${m[1]}.',
    );
    return "Rp $s";
  }

  int calculateColumns(double width) {
    // responsive: C
    if (width >= 1200) return 4;
    if (width >= 800) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // remove default AppBar look — custom header used
      body: Column(
        children: [
          // Header area (flow) — darker top wave (#f9e8de) and lighter background (#faf2e8)
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Stack(
              children: [
                // bottom background (lighter tone)
                Container(color: kPrimary),

                // top area filled with darker wave color, clipped at bottom
                ClipPath(
                  clipper: _TopWaveClipper(),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: kHeaderBg,
                  ),
                ),

                // Title + subtitle + search card placed lower with spacing between title and search
                SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 480;
                            final titleSize = isMobile ? 42.0 : 66.0;
                            final subtitleSize = isMobile ? 13.0 : 16.0;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // push title lower
                                const SizedBox(height: 38),
                                Text(
                                  'Pearl Collection',
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: theme.textTheme.headlineLarge
                                        ?.copyWith(
                                          color: kTextSoft,
                                          fontWeight: FontWeight.w400,
                                          fontSize: titleSize,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Handcrafted Lombok Sea Pearls',
                                  style: GoogleFonts.roboto(
                                    textStyle: theme.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: kTextSoft.withOpacity(0.85),
                                          fontSize: subtitleSize,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 120),
                                // search sits near bottom of header — small gap to grid below
                                const SearchFilterCard(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // CONTENT area: products grid (centered, max width)
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error loading products"),
                        );
                      }

                      final docs = snapshot.data?.docs ?? [];
                      final products = docs
                          .map(
                            (doc) => Product.fromMap(
                              doc.data() as Map<String, dynamic>,
                            ),
                          )
                          .toList();

                      if (products.isEmpty) {
                        return const Center(child: Text("Tidak ada produk"));
                      }

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final columns = calculateColumns(
                            constraints.maxWidth,
                          );
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  mainAxisSpacing: 35,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final p = products[index];
                              return _ProductCardUI(
                                product: p,
                                formatCurrency: formatCurrency,
                              );
                            },
                          );
                        },
                      );
                    },
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

/// Product card UI (purely visual; uses Product model for data, does not change logic)
class _ProductCardUI extends StatelessWidget {
  final Product product;
  final String Function(int?) formatCurrency;

  const _ProductCardUI({required this.product, required this.formatCurrency});

  @override
  Widget build(BuildContext context) {
    final available = product.isAvailable == true;
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          // image area
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Container(
                width: double.infinity,
                color: const Color(0xfff6f1ec),
                child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                    ? Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (_, __, ___) {
                          // fallback to local placeholder path (agent will convert that path)
                          return Image.network(
                            kLocalPlaceholderImage,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.network(kLocalPlaceholderImage, fit: BoxFit.cover),
              ),
            ),
          ),

          // info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // small badge row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: available
                              ? Colors.blue.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          available ? 'Available' : 'Out of Stock',
                          style: TextStyle(
                            color: available
                                ? Colors.blue.shade800
                                : Colors.red.shade800,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        'Grade ${product.grade ?? "-"}',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Text(
                    product.name ?? '-',
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        color: kTextSoft,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),
                  Text(
                    formatCurrency(product.price),
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),

                  const Spacer(),

                  // action row (WA icon kept as original behaviour)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => openWhatsApp(product),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Contact'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => openWhatsApp(product),
                        icon: const Icon(Icons.home, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final w = size.width;
    final h = size.height;

    // Start at top-left
    path.moveTo(0, 0);
    // Top-right
    path.lineTo(w, 0);
    // Turun ke posisi awal gelombang
    path.lineTo(w, h * 0.65);

    // GELOMBANG 1 - lebih halus dan natural
    path.cubicTo(
      w * 0.85,
      h * 0.50, // Control point 1
      w * 0.70,
      h * 0.80, // Control point 2
      w * 0.50,
      h * 0.70, // End point
    );

    // GELOMBANG 2 - naik secara bertahap
    path.cubicTo(
      w * 0.30,
      h * 0.60, // Control point 1
      w * 0.15,
      h * 0.45, // Control point 2
      0,
      h * 0.55, // End point
    );

    // Kembali ke start point
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
