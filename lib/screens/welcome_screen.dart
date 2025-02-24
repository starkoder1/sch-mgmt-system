// import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:school_mgmt/screens/add_account_details.dart';
import 'package:school_mgmt/screens/attendance_screen.dart';
import 'package:school_mgmt/screens/homework_screen.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/test.dart';
import 'package:school_mgmt/widgets/welcome_icons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 70,
              ),
              const CircleAvatar(
                radius: profilePictureRadius,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: const Text(
                    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa qu qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, "),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 600,
                child: GridView(
                  clipBehavior: Clip.none,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.80,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    WelcomeIcons(
                      iconPath: 'assets/icons/att.png',
                      label: 'Attendance',
                      destinationScreen: ColorSchemeScreen(),
                    ),
                    WelcomeIcons(
                      iconPath: 'assets/icons/homework.png',
                      label: 'Homework',
                      destinationScreen: HomeworkScreen(),
                    ),

                    WelcomeIcons(
                      iconPath: 'assets/icons/result.png',
                      label: 'Result',
                      destinationScreen: AttendanceScreen(),
                    ),
                    WelcomeIcons(
                      iconPath: 'assets/icons/exam_routine.png',
                      label: 'Exam Routine',
                      destinationScreen: HomeworkScreen(),
                    ),
                    WelcomeIcons(
                      iconPath: 'assets/icons/solutions.png',
                      label: 'Solution',
                      destinationScreen: HomeworkScreen(),
                    ),
                    WelcomeIcons(
                      iconPath: 'assets/icons/notice.png',
                      label: 'Notice & Events',
                      destinationScreen: HomeworkScreen(),
                    ),
                    WelcomeIcons(
                      iconPath: 'assets/icons/add_user.png',
                      label: 'Add Account Details',
                      destinationScreen: AddAccountDetailsScreen(),
                    ),
                    // SizedBox(height: 100,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
