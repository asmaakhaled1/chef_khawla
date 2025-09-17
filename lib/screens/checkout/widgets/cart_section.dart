import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../models/cart_item.dart';
import '../../../widgets/common/decoration_helpers.dart';

Widget cartSection() {
  return ValueListenableBuilder(
    valueListenable: Hive.box<CartItem>('cartBox').listenable(),
    builder: (context, Box<CartItem> cartBox, _) {
      final cartItems = cartBox.values.toList();
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.deepOrange, size: 22),
                const SizedBox(width: 6),
                const Text(
                  "Cart Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.orange,
                  child: Text(
                    cartItems.length.toString(),
                    style: const TextStyle(color: Color(0xfffefefe)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            cartItems.isEmpty
                ? Center(child: Column(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.grey[200]!, size: 100),
                    Text("Your cart is empty",
                      style: TextStyle(color: Colors.grey[600]!,fontSize: 15)),
                  ],
                ))
                : ListView.builder(
              itemCount: cartItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                final item = cartItems[i];
                return Card(
                  color: const Color(0xfffefefe),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(item.imageUrl ?? 'assets/images/placeholder.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${item.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                ),
                              ),
                              Text(
                                "Total: \$${item.price * item.quantity}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, color: Colors.red, size: 20),
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      if (item.quantity > 1) {
                                        item.quantity--;
                                        await item.save();
                                      } else {
                                        await cartBox.deleteAt(i);
                                      }
                                    },
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, color: Colors.green, size: 20),
                                    padding: EdgeInsets.zero,
                                    onPressed: () async {
                                      item.quantity++;
                                      await item.save();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              onPressed: () async {
                                await cartBox.deleteAt(i);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}