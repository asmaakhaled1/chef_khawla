import 'package:flutter/material.dart';

BoxDecoration boxDecoration() => BoxDecoration(
  color: const Color(0xfffefefe),
  borderRadius: BorderRadius.circular(18),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ],
);