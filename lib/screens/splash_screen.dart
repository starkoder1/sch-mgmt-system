import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_mgmt/providers/user_type_provider.dart';
import 'package:school_mgmt/screens/user_type.dart';
import 'package:school_mgmt/screens/home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  void _checkAuthentication() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    // Trigger provider to fetch and store user role globally
    ref.read(userTypeProvider.notifier).loadUser();

    await Future.delayed(
      const Duration(seconds: 4),
    ); // Splash delay

    if (mounted) {
      // Ensure widget is still in the tree
      if (currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserType()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
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
          ),
        ),
      ),
    );
  }
}
