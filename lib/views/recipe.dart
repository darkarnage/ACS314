import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Generated Recipes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w200,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Here are some recipes you might like!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Text(
              "Ingredients:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text("Eggs"),
            Text("Onions"),
            Text("Tomatoes"),
            SizedBox(height: 20),
            Text(
              "Instructions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text("1. Beat the eggs in a bowl."),
            Text("2. Chop the onions and tomatoes."),
            Text("3. Cook the onions and tomatoes in a pan."),
            Text("4. Add the beaten eggs to the pan and cook until done."),
          ],
        ),
      ),
    );
  }
}
