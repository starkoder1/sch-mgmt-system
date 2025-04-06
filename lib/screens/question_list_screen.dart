import 'package:flutter/material.dart';
import 'package:school_mgmt/screens/solution_screen.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/card_widget.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key});

  @override
  State<QuestionListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuestionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              "assets/icons/quiz.png",
              color: Theme.of(context).colorScheme.onPrimary,
              height: appBarIconHeight,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Questions',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return CustomCard(
                titleText: "Question",
                bodyText:
                    "vdjhfakjfhjfhdkjkjdsvhdkjvdkjfshdsjgdskjghdkgdsfjdsifjdifjdfjdkvncjvdsnskjbfgadjfhahfdfajkjfjsklfjeiofjdfjdkvndvdnjvdshjdskfjdlfjdsgvdsklvjnckvncvjdsnjfhdfadfjakljsklhdjdsjkvdjkadhlifjdlvdklvbdsjkbvdskjvndsjvjcvndjkvhdjvdkdnvkjndsjvadnjajn",
                buttonLabel: "View",
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TeacherSolutionScreen(),
                  ));
                },
              );
            },
            itemCount: 5,
          )),
    );
  }
}
