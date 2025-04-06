// import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_mgmt/providers/user_type_provider.dart';
import 'package:school_mgmt/screens/add_account_details.dart';
import 'package:school_mgmt/screens/attendance_screen.dart';
import 'package:school_mgmt/screens/homework_screen.dart';
import 'package:school_mgmt/screens/question_list_screen.dart';
import 'package:school_mgmt/screens/result_screen.dart';
import 'package:school_mgmt/screens/solution_screen.dart';
import 'package:school_mgmt/screens/splash_screen.dart';
import 'package:school_mgmt/screens/student_attendance_screen.dart';
import 'package:school_mgmt/screens/student_homework_screen.dart';
import 'package:school_mgmt/screens/student_notice_screen.dart';
import 'package:school_mgmt/screens/student_result_screen.dart';
import 'package:school_mgmt/screens/teacher_notice_screen.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/test.dart';
import 'package:school_mgmt/widgets/welcome_icons.dart';
import 'package:school_mgmt/widgets/home_design.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(userTypeProvider);
    print(userType);
    return Scaffold(
      drawer: Drawer(
        // Add this drawer
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: Text(
                      'Drawer Header',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Messages'),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ],
              ),
            ),
            Divider(), // Optional: Adds a line before Sign Out
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                title: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplashScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeScreenDesign(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 70,
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.80,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        if (userType == 'teacher')
                          WelcomeIcons(
                            iconPath: 'assets/icons/add_user.png',
                            label: 'Add Details',
                            destinationScreen: AddAccountDetailsScreen(),
                          ),

                        if (userType == 'student')
                          WelcomeIcons(
                            iconPath: 'assets/icons/att.png',
                            label: 'Attendance',
                            destinationScreen: StudentAttendanceScreen(),
                          ),
                        if (userType == 'teacher')
                          WelcomeIcons(
                            iconPath: 'assets/icons/att.png',
                            label: 'Attendance',
                            destinationScreen: AttendanceScreen(),
                          ),
                        //IF USER IS TEACHER
                        if (userType == 'teacher')
                          WelcomeIcons(
                            iconPath: 'assets/icons/homework.png',
                            label: 'Homework',
                            destinationScreen: HomeworkScreen(),
                          ),
                        if (userType == 'student')
                          WelcomeIcons(
                            iconPath: 'assets/icons/homework.png',
                            label: 'Homework',
                            destinationScreen: StudentHomeworkScreen(),
                          ),

                        //IF USER IS TEACHER
                        if (userType == 'teacher')
                          WelcomeIcons(
                            iconPath: 'assets/icons/result.png',
                            label: 'Result',
                            destinationScreen: ResultScreen(),
                          ),
                        //IF USER IS STUDENT
                        if (userType == 'student')
                          WelcomeIcons(
                            iconPath: 'assets/icons/result.png',
                            label: 'Result',
                            destinationScreen: StudentResultScreen(),
                          ),
                        WelcomeIcons(
                          iconPath: 'assets/icons/exam_routine.png',
                          label: 'Exam Routine',
                          destinationScreen: ColorSchemeScreen(),
                        ),
                        WelcomeIcons(
                          iconPath: 'assets/icons/solutions.png',
                          label: 'Questions',
                          destinationScreen: QuestionListScreen(),
                        ),
                        if (userType == 'teacher')
                          WelcomeIcons(
                            iconPath: 'assets/icons/notice.png',
                            label: 'Notice & Events',
                            destinationScreen: TeacherNoticeScreen(),
                          ),
                        if (userType == 'student')
                          WelcomeIcons(
                            iconPath: 'assets/icons/notice.png',
                            label: 'Notice & Events',
                            destinationScreen: AllNoticesScreen(),
                          )
                        // SizedBox(height: 100,)
                      ],
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
}
