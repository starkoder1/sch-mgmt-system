import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:school_mgmt/widgets/background_design.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key});
  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  Map<String, dynamic>? student;
  bool isLoading = true;
  String displayId = '';

  @override
  void initState() {
    super.initState();
    fetchStudent();
  }

  Future<void> fetchStudent() async {
    final supabase = Supabase.instance.client;

    final data = await supabase
        .from('students')
        .select('*, classroom (*), parents (*)')
        .limit(1)
        .maybeSingle();

    if (data != null) {
      setState(() {
        student = data;
        displayId = (100000 + Random().nextInt(900000)).toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackgroundDesign(
                    profileImageUrl:
                        'https://randomuser.me/api/portraits/lego/1.jpg',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(height: 40),
                        buildInfo(theme, "ID :", displayId),
                        buildInfo(theme, "Name :", student?['name'] ?? ''),
                        buildInfo(theme, "Class :",
                            student?['classroom']?['class_name'] ?? ''),
                        buildInfo(theme, "Roll No. :",
                            student?['roll']?.toString() ?? ''),
                        buildInfo(theme, "Address :", student?['name'] ?? ''),
                        buildInfo(theme, "Parent's Name :",
                            student?['parents']?['name'] ?? ''),
                        buildInfo(theme, "Parent's Contact :",
                            student?['parents']?['contact_number'] ?? ''),
                        const SizedBox(height: 40),
                        Center(
                          child: ElevatedBtn(
                            content: "Request Edit",
                            onPressed: () {},
                            hPadding: 90,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildInfo(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(color: theme.colorScheme.primary, fontSize: 28)),
          Text(value, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
