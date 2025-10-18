import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DiscountsScreen extends StatefulWidget {
  const DiscountsScreen({super.key});

  @override
  State<DiscountsScreen> createState() => _DiscountsScreenState();
}

class _DiscountsScreenState extends State<DiscountsScreen> {
  final List<Map<String, dynamic>> _discounts = [
    {"item": "Pizza", "price": 499, "discount": 50},
    {"item": "Burger", "price": 199, "discount": 20},
    {"item": "Pasta", "price": 299, "discount": 30},
  ];

  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();

  void _addDiscount() {
    if (_itemController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _discountController.text.isEmpty) return;

    setState(() {
      _discounts.add({
        "item": _itemController.text,
        "price": double.parse(_priceController.text),
        "discount": double.parse(_discountController.text),
      });
    });

    _itemController.clear();
    _priceController.clear();
    _discountController.clear();
    Navigator.of(context).pop();
  }

  void _showAddDiscountDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add New Discount"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: "Item Name",
                  prefixIcon: Icon(MdiIcons.food),
                ),
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Original Price (₹)",
                  prefixIcon: Icon(MdiIcons.currencyInr),
                ),
              ),
              TextField(
                controller: _discountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Discount (%)",
                  prefixIcon: Icon(MdiIcons.percent),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _addDiscount,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discounts & Offers'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(MdiIcons.plus),
            onPressed: _showAddDiscountDialog,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: _discounts.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.tagOutline, size: 60, color: Colors.deepOrange),
              const SizedBox(height: 12),
              const Text(
                'No discounts yet!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text('Click the + button to add new discounts.'),
            ],
          ),
        )
            : ListView.builder(
          itemCount: _discounts.length,
          itemBuilder: (ctx, i) {
            final d = _discounts[i];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: Icon(MdiIcons.tag, color: Colors.deepOrange),
                title: Text(d['item'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  "Original: ₹${d['price']} • Discount: ${d['discount']}%",
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: IconButton(
                  icon: Icon(MdiIcons.deleteOutline, color: Colors.redAccent),
                  onPressed: () {
                    setState(() => _discounts.removeAt(i));
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDiscountDialog,
        backgroundColor: Colors.deepOrange,
        child: Icon(MdiIcons.plus),
      ),
    );
  }
}
