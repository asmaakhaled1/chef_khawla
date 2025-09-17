import 'package:flutter/material.dart';
import '../data/data.dart';

const kbutton = Color(0xFFFD5200);

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 28),
              const SizedBox(width: 8),
              Text(
                "Featured Products",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              final product = categories[0].products[index];
              int quantity = 0;

              return StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(product.image, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(product.price, style: const TextStyle(color: Colors.green)),
                        const SizedBox(height: 8),

                        quantity == 0
                            ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kbutton,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            setState(() {
                              quantity = 1;
                            });

                            final messenger = ScaffoldMessenger.of(
                              Navigator.of(context).overlay!.context,
                            );
                            messenger.clearSnackBars();
                            messenger.showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "✅ Item added",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: const Text("Add"),
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () {
                                if (quantity > 0) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                            ),
                            Text("$quantity", style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}