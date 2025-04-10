import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/homework.png',
              color: Colors.white,
              height: appBarIconHeight,
            ),
            const SizedBox(
              width: 10,
            ),
            Text("H O M E W O R K",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Subject",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Add Homework"),
                TextField(
                  minLines: 10,
                  maxLines: null,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(textFieldOutlineRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(textFieldOutlineRadius),
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedBtn(
              content: "Submit",
              onPressed: () {},
              hPadding: 120,
              vPadding: 15,
            ),
          ],
        ),
      ),
    );
  }
}
