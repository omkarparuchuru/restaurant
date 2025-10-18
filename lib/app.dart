import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/discounts_screen.dart';
import 'screens/earnings_screen.dart';
import 'screens/more_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto Admin',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selected = 0;
  final _pages = const [
    HomeScreen(),
    OrdersScreen(),
    MenuScreen(),
    DiscountsScreen(),
    EarningsScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selected],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange.shade400, Colors.orangeAccent.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selected,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (i) => setState(() => _selected = i),
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.homeOutline),
              activeIcon: Icon(MdiIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.formatListBulleted),
              activeIcon: Icon(MdiIcons.formatListBulletedSquare),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.silverwareForkKnife),
              activeIcon: Icon(MdiIcons.silverwareForkKnife),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.tagOutline),
              activeIcon: Icon(MdiIcons.tag),
              label: 'Discounts',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.chartBarStacked),
              activeIcon: Icon(MdiIcons.chartBarStacked),
              label: 'Earnings',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.dotsHorizontalCircleOutline),
              activeIcon: Icon(MdiIcons.dotsHorizontalCircle),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
