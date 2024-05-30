import 'package:flutter/material.dart';
import 'package:time_ledger/features/user/presentation/pages/home/clockin_screen.dart';
import 'package:time_ledger/features/user/presentation/pages/profile/profile_screen.dart';
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
    const ClockInPage(),
    const Text('Track Tab',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('Dahboard',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const Text('Invoices Tab',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const ProfileScreen(), // Directly using SettingsPage here
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(
  //         selectedIndex: _selectedIndex,
  //         selectedDate: DateTime.now(),
  //         onDateSelected: _onDateSelected),
  //     body: Center(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: BottomNavigation(
  //       selectedIndex: _selectedIndex,
  //       onItemSelected: _onItemTapped,
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      // CustomAppBar(
      //     selectedIndex: _selectedIndex,
      //     selectedDate: DateTime.now(),
      //     onDateSelected: _onDateSelected),
      body: Stack(
        children: [
          // The main content or background of your app
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          // Navigation bar placed on top of the main content
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: BottomNavigation(
          //     selectedIndex: _selectedIndex,
          //     onItemSelected: _onItemTapped,
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemSelected:
              _onItemTapped), // Make the scaffold itself transparent
    );
  }
}
