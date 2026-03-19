import 'package:flutter/material.dart';

class Categoryscreen extends StatelessWidget {
  const Categoryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data grouped by month
    final Map<String, List<Map<String, String>>> groupedLogs = {
      "OCTOBER 2023": [
        {"day": "12", "month": "OCT", "mood": "Tired", "symptom": "Fever"},
        {"day": "11", "month": "OCT", "mood": "Energetic", "symptom": "None"},
        {"day": "10", "month": "OCT", "mood": "Relaxed", "symptom": "Headache"},
      ],
      "SEPTEMBER 2023": [
        {"day": "30", "month": "SEP", "mood": "Anxious", "symptom": "Insomnia"},
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF2F7),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: const Text(
          "Entry History",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: const Icon(Icons.calendar_month, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: groupedLogs.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 12),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              ...entry.value.map((log) => _LogCard(log: log)).toList(),
            ],
          );
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final Map<String, String> log;
  const _LogCard({required this.log});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  log['month']!,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  log['day']!,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.blue,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: "Mood: ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: log['mood']),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      log['symptom'] == 'None'
                          ? Icons.check_circle
                          : Icons.warning_amber_rounded,
                      color: log['symptom'] == 'None'
                          ? Colors.green
                          : Colors.orange,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: "Symptoms: ",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: log['symptom']),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
