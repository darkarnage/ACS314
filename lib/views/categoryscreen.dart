import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Breakfast", "Lunch", "Dinner", "Snacks"];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];

                return Card(
                  child: ListTile(
                    title: Text(category),

                    onTap: () {
                      Get.toNamed("/recipescreen", arguments: category);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
