import 'package:data/models/checkout_item.dart';

class OrderDetails{
  final List<CheckoutItem> image, title, description, sku, category;
  final int id;
  final double price;

  OrderDetails({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.sku,
    required this.category
  });
}