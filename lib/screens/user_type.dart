import 'package:flutter/material.dart';
import 'package:school_mgmt/screens/user_signin_form.dart';
import 'package:school_mgmt/widgets/login_button.dart';

class UserType extends StatefulWidget {
  const UserType({super.key});

  @override
  State<UserType> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserType> {

  
  void _navigateToLoginForm(String userType) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => UserLoginForm(
        userType: userType,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage("assets/logos/start_logo.jpg"),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose your Option',
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginButtonWidget(
                  buttonText: 'Student',
                  onPressed: () {
                    _navigateToLoginForm('student');
                  },
                ),
                LoginButtonWidget(
                  buttonText: 'Teacher',
                  onPressed: () {
                    _navigateToLoginForm('teacher');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // Third Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButtonWidget(
                  buttonText: 'Guest',
                  onPressed: () {
                    _navigateToLoginForm('guest');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
