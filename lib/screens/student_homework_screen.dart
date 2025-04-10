import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class StudentHomeworkScreen extends StatefulWidget {
  const StudentHomeworkScreen({super.key});

  @override
  State<StudentHomeworkScreen> createState() => _StudentHomeworkScreenState();
}

class _StudentHomeworkScreenState extends State<StudentHomeworkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/att.png',
              color: Colors.white,
              height: appBarIconHeight,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "H O M E W O R K",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Subject",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Today's Homework"),
          SizedBox(
            height: 15,
          ),
          Placeholder(
            fallbackHeight: 80,
            color: Colors.grey,
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: ElevatedBtn(
              content: "Download Homework",
              onPressed: () {},
              hPadding: 65,
              vPadding: 15,
            ),
          )
        ],
      ),
    );
  }
}
