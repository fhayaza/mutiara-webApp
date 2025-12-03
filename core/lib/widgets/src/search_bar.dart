import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kTextSoft = Color(0xff2e2c27);

/// Small category chip/pill widget
class MiniChip extends StatelessWidget {
  final String label;

  const MiniChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xfffbf6f3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.16)),
      ),
      child: Text(
        label,
        style: GoogleFonts.roboto(fontSize: 12, color: kTextSoft),
      ),
    );
  }
}

/// Search + filter card widget with chips and sort button
class SearchFilterCard extends StatelessWidget {
  const SearchFilterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Search products, e.g. "Cincin mutiara"',
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // simple chips (static)
          const MiniChip(label: 'Necklace'),
          const SizedBox(width: 8),
          const MiniChip(label: 'Earrings'),
          const SizedBox(width: 8),
          const MiniChip(label: 'Ring'),
          const SizedBox(width: 8),
          const MiniChip(label: 'Bracelet'),
          const SizedBox(width: 12),
          // sort
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.18)),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              child: const Text('Price: High → Low'),
            ),
          ),
        ],
      ),
    );
  }
}
