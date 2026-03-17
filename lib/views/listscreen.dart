import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "List Screen",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
      ),
    );
  }
}
