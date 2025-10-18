import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gradient_appbar.dart';
import '../providers/earnings_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ep = Provider.of<EarningsProvider>(context);
    final today = DateTime.now();
    final dayIncome = ep.getDayIncome(today);
    final dayOrders = ep.getDayOrders(today);
    final prevDayIncome = dayIncome * 0.8;
    final trendUp = dayIncome >= prevDayIncome;

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const GradientAppBar(title: 'Earnings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: Column(
            children: [
              _summaryCard(
                title: 'Today',
                amount: dayIncome,
                orders: dayOrders,
                up: trendUp,
                icon: MdiIcons.calendarToday,
                w: w,
                color: Colors.blueAccent,
              ),
              SizedBox(height: w * 0.03),
              _summaryCard(
                title: 'Week',
                amount: 22140,
                orders: 80,
                up: true,
                icon: MdiIcons.calendarWeek,
                w: w,
                color: Colors.teal,
              ),
              SizedBox(height: w * 0.03),
              _summaryCard(
                title: 'Month',
                amount: 90200,
                orders: 320,
                up: false,
                icon: MdiIcons.calendarMonth,
                w: w,
                color: Colors.deepPurple,
              ),
              SizedBox(height: w * 0.06),
              // Minimal total section
              Container(
                padding: EdgeInsets.symmetric(vertical: w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _totalInfo(
                      icon: MdiIcons.cashMultiple,
                      label: 'Revenue',
                      value: '₹${(dayIncome + 22140 + 90200).toStringAsFixed(0)}',
                      w: w,
                      color: Colors.orangeAccent,
                    ),
                    _totalInfo(
                      icon: MdiIcons.clipboardList,
                      label: 'Orders',
                      value: '${dayOrders + 80 + 320}',
                      w: w,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required double amount,
    required int orders,
    required bool up,
    required IconData icon,
    required double w,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.035),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Icon Circle
          Container(
            padding: EdgeInsets.all(w * 0.04),
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: w * 0.08),
          ),
          SizedBox(width: w * 0.04),
          // Data
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.045)),
                SizedBox(height: w * 0.008),
                Text('₹${amount.toStringAsFixed(0)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.055)),
                SizedBox(height: w * 0.004),
                Text('$orders orders',
                    style: TextStyle(color: Colors.white70, fontSize: w * 0.035)),
              ],
            ),
          ),
          // Trend
          Icon(
            up ? MdiIcons.trendingUp : MdiIcons.trendingDown,
            color: up ? Colors.greenAccent.shade400 : Colors.redAccent.shade400,
            size: w * 0.07,
          ),
        ],
      ),
    );
  }

  Widget _totalInfo({
    required IconData icon,
    required String label,
    required String value,
    required double w,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(w * 0.03),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: w * 0.08),
        ),
        SizedBox(height: w * 0.015),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        SizedBox(height: w * 0.005),
        Text(value,
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: w * 0.045)),
      ],
    );
  }
}
