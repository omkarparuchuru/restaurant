import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/order_provider.dart';
import 'providers/menu_provider.dart';
import 'providers/earnings_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => EarningsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
