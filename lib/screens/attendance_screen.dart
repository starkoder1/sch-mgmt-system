import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/att.png',
              color: Colors.white,
              height: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "ATTENDANCE",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
