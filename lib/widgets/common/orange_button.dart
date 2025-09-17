import 'package:flutter/material.dart';

Widget orangeButton({required IconData icon, required String label}) {
  return Container(
    height: 46,
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.2,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}