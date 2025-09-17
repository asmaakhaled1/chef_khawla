import 'package:hive/hive.dart';
part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String? imageUrl;

  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    this.imageUrl,
  });
}