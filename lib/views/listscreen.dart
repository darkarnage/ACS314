import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> insightCards = [
      {
        "tag": "THIS WEEK",
        "title": "You logged headaches 3 times this week",
        "subtitle": "That's 1 less than last week.",
        "icon": "medical",
      },
      {
        "tag": "OVERALL",
        "title": "Your average mood is Happy",
        "subtitle": "Consistency is key to your progress.",
        "icon": "mood",
      },
      {
        "tag": "SLEEP",
        "title": "Average of 7.5 hours per night",
        "subtitle": "You are meeting your daily goals.",
        "icon": "sleep",
      },
    ];

    final List<Map<String, String>> highlights = [
      {"label": "Water Intake", "value": "1.8L / 2.0L"},
      {"label": "Activity Level", "value": "Moderate"},
      {"label": "Stress Level", "value": "Low"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF2F7),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "Insights",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "WEEKLY SUMMARY",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            ...insightCards.map((card) => _InsightCard(card: card)).toList(),
            const SizedBox(height: 24),

            const Text(
              "DAILY LOG HIGHLIGHTS",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: highlights.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['label']!,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              item['value']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (index < highlights.length - 1)
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final Map<String, String> card;
  const _InsightCard({required this.card});

  IconData _getIcon(String type) {
    switch (type) {
      case "mood":
        return Icons.sentiment_satisfied;
      case "sleep":
        return Icons.bedtime;
      default:
        return Icons.medical_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(_getIcon(card['icon']!), color: Colors.blue, size: 26),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  card['tag']!,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Text(
            card['title']!,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),

          Text(
            card['subtitle']!,
            style: const TextStyle(color: Colors.blueGrey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
