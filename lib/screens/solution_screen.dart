import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class TeacherSolutionScreen extends StatefulWidget {
  const TeacherSolutionScreen({super.key});

  @override
  State<TeacherSolutionScreen> createState() => _SolutionScreenState();
}

class _SolutionScreenState extends State<TeacherSolutionScreen> {
  final _solutionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        // centerTitle: true,
        title: Row(
          children: [
            Image.asset('assets/icons/solutions.png',
                height: appBarIconHeight,
                color: Theme.of(context).colorScheme.onPrimary),
            SizedBox(
              width: 10,
            ),
            Text(
              "SOLUTIONS",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Question 1"),
              SizedBox(
                height: 10,
              ),
              Text(
                  "jdghdskjgshjherwjkkrwhjkjksssssssssssssssssssssssssssshgewiuohddjbvfjbfjgehwifheirewivhdjvnewjbvrueihwidvbfkjvseifheihisovndvjsdfnskhkghewieoeiufdsvnfjvnfjfehwoifheiofhhdsvjskledjweoriowfsdvndkvnfjghwosljefhfskjlhgevnewirvn"),
              SizedBox(
                height: 10,
              ),
              Text("Enter Feedback"),
              TextField(
                controller: _solutionController,
                minLines: 10,
                maxLines: null,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(textFieldOutlineRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(textFieldOutlineRadius),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Upload File"),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: ElevatedBtn(
                  onPressed: () {},
                  content: "Send",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
