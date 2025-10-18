import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../providers/menu_provider.dart';
import '../models/dish.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mp = Provider.of<MenuProvider>(context);
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => _showAddDialog(context, mp),
        child: Icon(MdiIcons.plus),
      ),
      body: mp.dishes.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(MdiIcons.food, size: w * 0.15, color: Colors.deepOrange.shade200),
            SizedBox(height: w * 0.05),
            Text('No dishes added yet', style: TextStyle(fontSize: w * 0.05, color: Colors.grey.shade600)),
            SizedBox(height: w * 0.02),
            Text('Tap the + button to add your menu', style: TextStyle(fontSize: w * 0.035, color: Colors.grey.shade500)),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(w * 0.03),
        itemCount: mp.dishes.length,
        itemBuilder: (c, i) {
          final d = mp.dishes[i];
          return Container(
            margin: EdgeInsets.only(bottom: w * 0.03),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade100, Colors.deepOrange.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: w * 0.025),
              leading: Container(
                padding: EdgeInsets.all(w * 0.025),
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(MdiIcons.food, color: Colors.deepOrange, size: w * 0.08),
              ),
              title: Text(d.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.045)),
              subtitle: Text('₹${d.price.toStringAsFixed(0)} • ${d.description}', style: TextStyle(fontSize: w * 0.035)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(MdiIcons.squareEditOutline, color: Colors.blue, size: w * 0.07),
                    onPressed: () => _showEditDialog(context, mp, d),
                  ),
                  IconButton(
                    icon: Icon(MdiIcons.delete, color: Colors.red, size: w * 0.07),
                    onPressed: () => mp.removeDish(d.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context, MenuProvider mp) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add New Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(MdiIcons.food, size: w * 0.06),
                ),
              ),
              SizedBox(height: w * 0.03),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(MdiIcons.currencyInr, size: w * 0.06),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: w * 0.03),
              TextField(
                controller: descCtrl,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(MdiIcons.text, size: w * 0.06),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              mp.addDish(
                nameCtrl.text,
                double.tryParse(priceCtrl.text) ?? 0,
                descCtrl.text,
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, MenuProvider mp, Dish dish) {
    final nameCtrl = TextEditingController(text: dish.name);
    final priceCtrl = TextEditingController(text: dish.price.toString());
    final descCtrl = TextEditingController(text: dish.description);
    final w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(MdiIcons.food, size: w * 0.06),
                ),
              ),
              SizedBox(height: w * 0.03),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(MdiIcons.currencyInr, size: w * 0.06),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: w * 0.03),
              TextField(
                controller: descCtrl,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(MdiIcons.text, size: w * 0.06),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              mp.updateDish(
                dish.id,
                nameCtrl.text,
                double.tryParse(priceCtrl.text) ?? 0,
                descCtrl.text,
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
