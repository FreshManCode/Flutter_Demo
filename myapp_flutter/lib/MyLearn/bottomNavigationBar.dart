import 'package:flutter/material.dart';

class MyBottomNaigationBarApp extends StatelessWidget {
  const MyBottomNaigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      title: "Flutter code sample",
      home:_MyStateFullWidget() ,
    );
  }
}

class _MyStateFullWidget extends StatefulWidget {
  const _MyStateFullWidget({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyStateFullWidgetState();
  }
}

class _MyStateFullWidgetState extends State<_MyStateFullWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      "Index 0:Home",
      style: optionStyle,
    ),
    Text(
      "Index 1:Business",
      style: optionStyle,
    ),
    Text(
      "Index 2:School",
      style: optionStyle,
    ),
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business',backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.school),label: 'School',backgroundColor: Colors.purple),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
