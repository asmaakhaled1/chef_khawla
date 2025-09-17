import 'package:flutter/material.dart';

InputDecoration inputDecoration() => InputDecoration(
  filled: true,
  fillColor: Colors.grey.shade100,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.deepOrange),
  ),
);