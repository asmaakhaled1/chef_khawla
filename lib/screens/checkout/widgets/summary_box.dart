import 'package:flutter/material.dart';
import '../../../widgets/common/decoration_helpers.dart';

Widget summaryBox({
  required double subtotal,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: boxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.receipt_long, color: Colors.deepOrange, size: 22),
            SizedBox(width: 6),
            Text(
              "Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _summaryRow("Subtotal", subtotal),
        _summaryRow("Delivery Fee", 2.99),
        _summaryRow("Tax (9%)", subtotal * 0.09),
        const Divider(),
        _summaryRow("Total", subtotal + 2.99 + subtotal * 0.09, isBold: true),
      ],
    ),
  );
}

Widget _summaryRow(String label, double value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}