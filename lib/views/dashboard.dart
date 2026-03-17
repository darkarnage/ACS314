import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController ingredientController = TextEditingController();
  List<String> ingredients = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's in your pantry?",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),
          Text(
            "Add the ingredients you have on hand and we'll whip up somehting delicous for you!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ingredientController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "e.g eggs, milk",
                  ),
                ),
              ),

              SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  if (ingredientController.text.isNotEmpty) {
                    setState(() {
                      ingredients.add(ingredientController.text);
                      ingredientController.clear();
                    });
                  }
                },
                child: Text("Add"),
              ),
            ],
          ),

          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: ingredients.map((item) {
              return Chip(
                label: Text(item),
                deleteIcon: Icon(Icons.close),
                onDeleted: () {
                  setState(() {
                    ingredients.remove(item);
                  });
                },
              );
            }).toList(),
          ),

          SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (ingredients.isNotEmpty) {
                  Get.toNamed("/recipescreen", arguments: ingredients);
                }
              },
              child: Text("Cook Something!"),
            ),
          ),
        ],
      ),
    );
  }
}
