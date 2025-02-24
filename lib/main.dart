import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:school_mgmt/firebase_options.dart';
import 'package:school_mgmt/screens/splash_screen.dart';
import 'package:school_mgmt/screens/user_type.dart';
import 'package:school_mgmt/screens/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:school_mgmt/screens/user_login.dart';
// For SystemChrome

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SchoolMgmt());

  // Set the app to fullscreen and hide the system navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class SchoolMgmt extends StatelessWidget {
  const SchoolMgmt({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const UserType(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Error occurred :${snapshot.error.toString()}"), //error handling
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const WelcomeScreen(); //successful login
          }
          return const SpalshScreen(); //initial screen
        },
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0C46C4), // Primary color
          primary: const Color(0xFF0C46C4), // Primary color
          secondary: const Color(0xFF28C2A0), // Secondary color
          brightness: Brightness.light,
        ),
        useMaterial3: true, // Enables Material 3 dynamic color generation
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0C46C4),
          primary: const Color(0xFF0C46C4), // Primary color
          secondary: const Color(0xFF28C2A0), // Secondary color
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
