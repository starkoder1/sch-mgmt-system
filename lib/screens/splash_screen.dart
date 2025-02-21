import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_mgmt/screens/user_type.dart';
import 'package:school_mgmt/screens/welcome_screen.dart';
// import 'package:school_mgmt/services/auth.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  void _checkAuthentication() {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final currentContext = Navigator.of(context);
    if (currentUser == null) {
      Future.delayed(
        const Duration(seconds: 4),
        () {
          currentContext.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const UserType(),
            ),
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 4),
        () {
          currentContext.pushReplacement(
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: CircleAvatar(
            radius: 110,
            backgroundImage: AssetImage("assets/logos/start_logo.jpg"),
            // child: Text("Greenfield Scholars"),
          ),
        ),
      ),
    );
  }
}
