import 'package:flutter/material.dart';
import 'package:sosial_app/app/views/dashboard/pages/home.dart';
import 'package:sosial_app/app/views/dashboard/pages/profil.dart';
import 'package:sosial_app/app/views/dashboard/pages/searchUser.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectIdx = 0;

  List<Widget> get widgetOption => <Widget>[
      Home(),
      Searchuser(),
      Profil()
    ];

    void onItemTapped(int index) {
    setState(() {
      selectIdx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: widgetOption[selectIdx],
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 3.0),
            color: const Color(0xFF1C1C1C),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 4)
              )
            ]
          ),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconSize: 20,
            selectedFontSize: 12,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            currentIndex: selectIdx,
            onTap: (value) {
              onItemTapped(value);
            },
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: selectIdx == 0 ? Colors.white : Colors.white70,), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search, color: selectIdx == 0 ? Colors.white : Colors.white70,), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded, color: selectIdx == 0 ? Colors.white : Colors.white70,), label: 'Profile')
          ]),
        )
      ),
    );
  }
}