import '../../models/src/products/product.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openWhatsApp(Product product) async {
  final phone = "6285179911477";
  final String text = product.isAvailable ?? false
      ? "Halo, saya tertarik dengan produk *${product.name}* (Grade: ${product.grade}) dengan harga Rp${product.price}. Apakah masih tersedia?"
      : "Halo, saya ingin menanyakan apakah produk *${product.name}* (Grade: ${product.grade}) dengan harga Rp${product.price} sudah tersedia lagi?";

  final url = Uri.parse(
    "https://wa.me/$phone?text=${Uri.encodeComponent(text)}",
  );

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw "Tidak bisa membuka WhatsApp";
  }
}
