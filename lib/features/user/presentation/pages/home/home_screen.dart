import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/presentation/pages/home/settings.dart';
import 'package:time_ledger/features/user/presentation/widgets/app_bar.dart';
import 'package:time_ledger/features/user/presentation/widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  DateTime? _selectedDate;
  // List of pages
  final List<Widget> _widgetOptions = <Widget>[
    const Text('Home Tab',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('Profile Tab',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const SettingsPage(),
    const Text('Invoices Tab',
        style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold)), // Directly using SettingsPage here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onDateSelected(DateTime? newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          selectedIndex: _selectedIndex,
          selectedDate: DateTime.now(),
          onDateSelected: _onDateSelected),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
