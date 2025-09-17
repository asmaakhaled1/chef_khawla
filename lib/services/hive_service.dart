import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>('cartBox');
    await Hive.openBox<String>('addressBox');
  }
}
