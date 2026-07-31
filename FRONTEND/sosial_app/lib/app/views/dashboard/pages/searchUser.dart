import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Searchuser extends StatefulWidget {
  const Searchuser({super.key});

  @override
  State<Searchuser> createState() => _SearchuserState();
}

class _SearchuserState extends State<Searchuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Searching User"),
      ),
    );
  }
}