import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Login Screen",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Image.asset("assets/profilepic.png"),
            Text(
              "Login Screen",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
            ),
            Text("Enter Username"),
            TextField(),
            Text("Enter Password"),
            TextField(),
            MaterialButton(
              onPressed: () {},
              color: Colors.amber,
              child: Text("Login", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}
