import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen1.dart';
import 'screen2.dart';
import 'screen3.dart';
import 'screen4.dart';
import 'tab_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TabModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavLab(),
      ),
    );
  }
}

class BottomNavLab extends StatelessWidget {
  const BottomNavLab({super.key});

  static const List<Widget> screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Selector<TabModel, int>(
        selector: (context, model) => model.currentIndex,
        builder: (context, currentIndex, child) => screens[currentIndex],
      ),
      bottomNavigationBar: Selector<TabModel, int>(
        selector: (context, model) => model.currentIndex,
        builder: (context, currentIndex, child) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          backgroundColor: Colors.blue,
          iconSize: 30,
          currentIndex: currentIndex,
          onTap: (int index) => context.read<TabModel>().setIndex(index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          ],
        ),
      ),
    );
  }
}
