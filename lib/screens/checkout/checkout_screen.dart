import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/cart_item.dart';
import 'widgets/address_section.dart';
import 'widgets/cart_section.dart';
import 'widgets/summary_box.dart';
import '../location/pick_location_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String? selectedAddress;
  late TextEditingController addressController;
  late Box<String> addressBox;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: "No address selected");
    addressBox = Hive.box<String>('addressBox');
    selectedAddress = addressBox.get('address');
    addressController.text = selectedAddress ?? "No address selected";
    // تسجيل للتحقق من تهيئة cartBox
    print('CheckOutScreen initState - cartBox length: ${Hive.box<CartItem>('cartBox').length}');
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress(String address) async {
    selectedAddress = address;
    await addressBox.put('address', address);
    setState(() {
      addressController.text = address;
    });
  }

  Future<void> _openLocationPicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PickLocationScreen()),
    );
    if (result != null && result['address'] != null) {
      await _saveAddress(result['address']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7613),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfffefefe),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CartItem>('cartBox').listenable(),
        builder: (context, Box<CartItem> cartBox, _) {
          final subtotal = cartBox.values.fold<double>(
            0,
                (sum, item) => sum + (item.price * item.quantity),
          );
          print('CheckOutScreen build - Subtotal: $subtotal, Cart items: ${cartBox.length}');
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addressSection(
                  context,
                  addressController: addressController,
                  openLocationPicker: _openLocationPicker,
                  selectedAddress: selectedAddress,
                  saveAddress: _saveAddress,
                  setState: setState,
                ),
                const SizedBox(height: 16),
                cartSection(),
                const SizedBox(height: 16),
                summaryBox(subtotal: subtotal),
              ],
            ),
          );
        },
      ),
    );
  }
}