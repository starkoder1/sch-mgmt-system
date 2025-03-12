import 'package:flutter/material.dart';
// import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/attendance_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            color: Theme.of(context).colorScheme.primaryFixedDim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Class : ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Text(
                    "10 A",
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimaryFixed),
                  ),
                  Spacer(),
                  Text(
                    "Date :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryFixed),
                  ),
                  Text(
                    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimaryFixed),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            height: 40,
            child: Row(children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Student Name",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Present",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Text(
                  "Absent",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]),
          ),
          Expanded(
            child: AttendanceWidget(),
          ),
        ],
      ),
    );
  }
}
