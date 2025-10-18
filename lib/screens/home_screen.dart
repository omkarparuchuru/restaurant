import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; // ✅ New package
import '../widgets/gradient_appbar.dart';
import '../providers/order_provider.dart';
import '../providers/menu_provider.dart';
import '../models/order.dart';
import 'orders_screen.dart';
import 'menu_screen.dart';
import 'discounts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final op = Provider.of<OrderProvider>(context);
    final mp = Provider.of<MenuProvider>(context);

    final pages = [
      _buildHome(context, op, mp),
      const OrdersScreen(),
      const MenuScreen(),
      const DiscountsScreen(),
    ];

    return Scaffold(
      appBar: const GradientAppBar(title: 'Restaurant Admin'),
      body: pages[_currentIndex],
    );
  }

  Widget _buildHome(BuildContext context, OrderProvider op, MenuProvider mp) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(
                    MdiIcons.silverwareForkKnife,
                    size: 28,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'My Restaurant',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Manage orders & menu', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Text('Store'),
                    Switch(
                      value: op.storeOnline,
                      onChanged: (v) => op.setStoreOnline(v),
                      activeColor: Colors.white,
                      activeTrackColor: Colors.greenAccent,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildNotifications(context, op)),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifications(BuildContext context, OrderProvider op) {
    final recent = op.all.take(3).toList();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(MdiIcons.bellAlert, color: Colors.deepOrange),
                const SizedBox(width: 8),
                const Text(
                  'Recent Orders',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (!op.storeOnline)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '⚠️ Store is offline — new orders will not be received.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (op.storeOnline)
              ...recent.map(
                    (o) => ListTile(
                  leading: Icon(MdiIcons.receipt, color: Colors.deepOrange),
                  title: Text('New order ${o.id.substring(0, 6)}'),
                  subtitle: Text('₹${o.total.toStringAsFixed(0)} • ${o.dishes.length} items'),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Provider.of<OrderProvider>(context, listen: false).acceptOrder(o);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrdersScreen()),
                      );
                    },
                    child: const Text('Accept'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
