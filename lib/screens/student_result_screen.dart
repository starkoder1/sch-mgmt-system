import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class StudentResultScreen extends StatefulWidget {
  const StudentResultScreen({super.key});

  @override
  State<StudentResultScreen> createState() => _StudentResultScreenState();
}

class _StudentResultScreenState extends State<StudentResultScreen> {
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
              "RESULT",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
          Container(
            width: double.infinity,
            height: 40,
            color: Theme.of(context).colorScheme.primaryFixedDim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Term : ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimaryFixed),
                  ),
                  Spacer(),
                  Text(
                    'Date : ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('REMARKS'),
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
              content: "Download Result",
              onPressed: () {},
              hPadding: 90,
              vPadding: 15,
            ),
          )
        ],
      ),
    );
  }
}
