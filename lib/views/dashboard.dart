import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/logincontroller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  final Function(int)? onNavigate;
  const DashboardScreen({super.key, this.onNavigate});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController symptomsController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  String? selectedMood;
  bool isLoading = false;

  final String baseUrl = "http://localhost/healthlog";

  final List<String> moods = [
    'Happy 😊',
    'Sad 😢',
    'Anxious 😰',
    'Tired 😴',
    'Angry 😠',
    'Calm 😌',
  ];

  Future<void> saveEntry() async {
    final LoginController controller = Get.find<LoginController>();
    final String currentUserId = controller.loggedInUserId.value;

    print("User ID being sent: $currentUserId");

    if (symptomsController.text.isEmpty &&
        selectedMood == null &&
        notesController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in at least one field",
        backgroundColor: Colors.red[100],
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/add_log.php"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "user_id": currentUserId,
          "symptoms": symptomsController.text,
          "mood": selectedMood ?? '',
          "notes": notesController.text,
        },
      );

      print("Response: ${response.body}");
      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        symptomsController.clear();
        notesController.clear();
        setState(() => selectedMood = null);
        Get.snackbar(
          "Success",
          "Entry saved successfully",
          backgroundColor: Colors.green[100],
        );
      } else {
        Get.snackbar(
          "Error",
          data['message'],
          backgroundColor: Colors.red[100],
        );
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "Error",
        "Could not connect to server",
        backgroundColor: Colors.red[100],
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    final String displayName = controller.loggedInName.value;
    final String displayEmail = controller.loggedInEmail.value;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.blue[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayEmail,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              _DrawerItem(
                icon: Icons.dashboard,
                label: "Dashboard",
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavigate?.call(0);
                },
              ),
              _DrawerItem(
                icon: Icons.category,
                label: "Categories",
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavigate?.call(1);
                },
              ),
              _DrawerItem(
                icon: Icons.history,
                label: "History",
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavigate?.call(2);
                },
              ),
              _DrawerItem(
                icon: Icons.person_outline,
                label: "Profile",
                onTap: () {
                  Navigator.pop(context);
                  widget.onNavigate?.call(3);
                },
              ),
              _DrawerItem(
                icon: Icons.logout,
                label: "Logout",
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  Get.find<LoginController>().logout(); // 👈 add this
                  Get.offAllNamed("/");
                },
              ),

              const Spacer(),

              _DrawerItem(
                icon: Icons.logout,
                label: "Logout",
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  Get.offAllNamed("/");
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          "Today's Health Log",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getFormattedDate(),
              style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),
            const SizedBox(height: 6),
            const Text(
              "How are you feeling?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 28),
            const Text(
              "Symptoms",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: symptomsController,
              decoration: InputDecoration(
                hintText: "e.g., Headache, Fever",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.medical_services_outlined,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Mood",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Row(
                    children: [
                      Icon(
                        Icons.sentiment_satisfied_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Select Current Mood",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  value: selectedMood,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: moods.map((mood) {
                    return DropdownMenuItem(value: mood, child: Text(mood));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedMood = value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Notes",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: notesController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Add any additional details about your day...",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.black12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Tracking daily helps identify health patterns over time.",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: isLoading ? null : saveEntry,
              child: Container(
                width: double.infinity,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2A3A),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Save Entry",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate() {
    final DateTime now = DateTime.now();
    const List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const List<String> months = [
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
    return "${days[now.weekday - 1]}, ${months[now.month]} ${now.day}";
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
    );
  }
}
