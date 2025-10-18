import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/gradient_appbar.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  int tab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) setState(() => tab = _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final op = Provider.of<OrderProvider>(context);
    final all = op.all;

    final ordered = all.where((o) => o.status == OrderStatus.placed || o.status == OrderStatus.accepted).toList();
    final ready = all.where((o) => o.status == OrderStatus.readyToHandOver).toList();
    final completed = all.where((o) => o.status == OrderStatus.completed).toList();
    final cancelled = all.where((o) => o.status == OrderStatus.cancelled).toList();

    List<Order> current;
    if (tab == 0) current = ordered;
    else if (tab == 1) current = ready;
    else if (tab == 2) current = completed;
    else current = cancelled;

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const GradientAppBar(title: 'Orders'),
      body: SafeArea(
        child: op.storeOnline
            ? Column(
          children: [
            _responsiveTabs(w),
            Expanded(
              child: current.isEmpty
                  ? Center(
                child: Text(
                  'No orders found',
                  style: TextStyle(fontSize: w * 0.04, color: Colors.black54),
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: 8),
                itemCount: current.length,
                itemBuilder: (c, i) {
                  final o = current[i];
                  return _orderCard(o, op, w);
                },
              ),
            ),
          ],
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(MdiIcons.cloudOffOutline, color: Colors.red, size: w * 0.15),
              SizedBox(height: w * 0.03),
              Text(
                'Store is offline',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red, fontSize: w * 0.045),
              ),
              SizedBox(height: w * 0.02),
              Text('You cannot receive or view orders now.',
                  style: TextStyle(color: Colors.black54, fontSize: w * 0.035)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _responsiveTabs(double w) {
    final icons = [MdiIcons.cartOutline, MdiIcons.clockOutline, MdiIcons.checkOutline, MdiIcons.cancel];
    final labels = ['Orders', 'Ready', 'Completed', 'Cancelled'];

    return SizedBox(
      height: w * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        itemCount: 4,
        itemBuilder: (context, idx) {
          final active = tab == idx;
          return GestureDetector(
            onTap: () => _tabController.animateTo(idx),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: w * 0.025),
              margin: EdgeInsets.symmetric(horizontal: w * 0.01),
              decoration: BoxDecoration(
                color: active ? Colors.deepOrange : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons[idx], color: active ? Colors.white : Colors.black87, size: w * 0.05),
                  SizedBox(width: w * 0.015),
                  Text(labels[idx],
                      style: TextStyle(
                          color: active ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: w * 0.035)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _orderCard(Order o, OrderProvider op, double w) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.015),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.all(w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(MdiIcons.cartOutline, color: Colors.deepOrange, size: w * 0.05),
                SizedBox(width: w * 0.02),
                Flexible(
                  child: Text('Order ${o.id.substring(0, 8)}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.04),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            SizedBox(height: w * 0.015),
            Text('${o.dishes.length} items • ₹${o.total.toStringAsFixed(0)}',
                style: TextStyle(fontSize: w * 0.035, color: Colors.black54)),
            SizedBox(height: w * 0.02),
            Wrap(
              spacing: w * 0.02,
              runSpacing: w * 0.015,
              children: [
                if (o.status == OrderStatus.placed)
                  _flatButton(MdiIcons.checkBold, 'Accept', Colors.deepOrange, () => op.acceptOrder(o), w),
                if (o.status == OrderStatus.accepted)
                  _flatButton(MdiIcons.clockOutline, 'Mark Ready', Colors.orangeAccent, () => op.markReady(o), w),
                if (o.status == OrderStatus.readyToHandOver)
                  _flatButton(MdiIcons.truckDeliveryOutline, 'Allocate', Colors.green, () {
                    final boy = op.db.boys.firstWhere((b) => b.available, orElse: () => op.db.boys.first);
                    op.allocateBoy(o, boy);
                  }, w),
                _flatButton(MdiIcons.cancel, 'Cancel', Colors.red, () => op.cancelOrder(o), w, isText: true),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _flatButton(IconData icon, String label, Color color, VoidCallback onPressed, double w,
      {bool isText = false}) {
    final maxWidth = w * 0.28; // responsive max width
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 0, maxWidth: maxWidth),
      child: isText
          ? TextButton.icon(
        icon: Icon(icon, color: color, size: w * 0.04),
        label: Flexible(
            child: Text(label,
                style: TextStyle(color: color, fontSize: w * 0.035), overflow: TextOverflow.ellipsis)),
        onPressed: onPressed,
      )
          : ElevatedButton.icon(
        icon: Icon(icon, size: w * 0.04),
        label: Flexible(
            child: Text(label, style: TextStyle(fontSize: w * 0.035), overflow: TextOverflow.ellipsis)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: w * 0.015),
          minimumSize: const Size(0, 0),
          elevation: 0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
