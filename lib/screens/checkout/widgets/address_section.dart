import 'package:flutter/material.dart';
import '../../../widgets/common/custom_input_field.dart';
import '../../../widgets/common/decoration_helpers.dart';
import '../../../widgets/common/orange_button.dart';
import '../dialogs/manual_entry_dialog.dart';

Widget addressSection(
    BuildContext context, {
      required TextEditingController addressController,
      required VoidCallback openLocationPicker,
      required String? selectedAddress,
      required Function(String) saveAddress,
      required Function setState,
    }) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: boxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.location_on, color: Colors.deepOrange, size: 22),
            SizedBox(width: 6),
            Text(
              "Delivery Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          controller: addressController,
          decoration: inputDecoration(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: openLocationPicker,
                child: orangeButton(
                  icon: Icons.my_location_outlined,
                  label: "Current Location",
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(
                  Icons.edit_location,
                  color: Colors.deepOrange,
                  size: 20,
                ),
                label: const Text(
                  "Manual Entry",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.deepOrange,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  String? result = await showDialog<String>(
                    context: context,
                    builder: (c) => manualEntryDialog(c),
                  );
                  if (result != null && result.trim().isNotEmpty) {
                    setState(() {
                      selectedAddress = result.trim();
                      addressController.text = selectedAddress!;
                    });
                    saveAddress(result.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}