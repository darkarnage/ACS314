import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  final String baseUrl = "http://localhost/healthlog";
  bool isLoading = true;
  List<Map<String, dynamic>> logs = [];

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    setState(() => isLoading = true);

    try {
      final LoginController controller = Get.find<LoginController>();
      final String userId = controller.loggedInUserId.value;

      print("Fetching logs for user ID: $userId");

      final response = await http.post(
        Uri.parse("$baseUrl/get_logs.php"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {"user_id": userId},
      );

      print("Logs response: ${response.body}");
      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        setState(() {
          logs = List<Map<String, dynamic>>.from(data['logs']);
        });
      }
    } catch (e) {
      print("Error fetching logs: $e");
    }

    setState(() => isLoading = false);
  }

  // Groups logs by month e.g. "OCTOBER 2024"
  Map<String, List<Map<String, dynamic>>> groupLogsByMonth() {
    Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var log in logs) {
      final date = DateTime.parse(log['date_logged']);
      final monthYear = "${_monthName(date.month).toUpperCase()} ${date.year}";

      if (!grouped.containsKey(monthYear)) {
        grouped[monthYear] = [];
      }
      grouped[monthYear]!.add(log);
    }

    return grouped;
  }

  String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  String _shortMonth(int month) {
    const months = [
      '',
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final groupedLogs = groupLogsByMonth();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF2F7),
        elevation: 0,
        automaticallyImplyLeading: false,
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
              icon: const Icon(Icons.refresh, color: Colors.black),
              onPressed: fetchLogs,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : logs.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 60, color: Colors.blueGrey),
                  SizedBox(height: 16),
                  Text(
                    "No entries yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Go to Dashboard and save your first entry",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: fetchLogs,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
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
                      ...entry.value.map((log) {
                        final date = DateTime.parse(log['date_logged']);
                        return _LogCard(
                          day: date.day.toString(),
                          month: _shortMonth(date.month),
                          mood: log['mood'] ?? 'N/A',
                          symptom: log['symptoms'] ?? 'None',
                        );
                      }),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final String day;
  final String month;
  final String mood;
  final String symptom;

  const _LogCard({
    required this.day,
    required this.month,
    required this.mood,
    required this.symptom,
  });

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
          // Date box
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
                  month,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  day,
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

          // Mood and symptom
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
                          TextSpan(text: mood.isEmpty ? 'N/A' : mood),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      symptom.isEmpty || symptom == 'None'
                          ? Icons.check_circle
                          : Icons.warning_amber_rounded,
                      color: symptom.isEmpty || symptom == 'None'
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
                          TextSpan(text: symptom.isEmpty ? 'None' : symptom),
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
