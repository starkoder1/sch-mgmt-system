import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';
import 'package:school_mgmt/providers/user_type_provider.dart';
import 'package:school_mgmt/screens/home_screen.dart';
import 'package:school_mgmt/services/auth.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class UserLoginForm extends ConsumerStatefulWidget {
  const UserLoginForm({super.key, required this.userType});
  final String userType;

  @override
  ConsumerState<UserLoginForm> createState() => _UserLoginFormState();
}

class _UserLoginFormState extends ConsumerState<UserLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  late final User? userData;
  String userEmail = '';
  String userPass = '';
  late String currentUserType = widget.userType;
  bool _isAuthenticating = false;

  bool isPasswordVisible = true;

  //toggle password visibilty
  void _togglePassVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  //Handle validation and authentication
  void _onLoginPress() async {
    setState(() {
      _isAuthenticating = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      userData = await _authService.userSignIn(userEmail, userPass);
      if (userData == null) {
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(_authService.errrMsg!),
            behavior: SnackBarBehavior.floating,
          ));
          setState(() {
            _isAuthenticating = false;
          });
        }
      } else {
        //saving offline usertype for UI
        await ref.read(userTypeProvider.notifier).setUserType(currentUserType);
        setState(() {
          _isAuthenticating = false;
        });
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Sign in successfull"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(Icons.person),
            const CircleAvatar(
              radius: profilePictureRadius,
              backgroundImage: AssetImage("assets/logos/start_logo.jpg"),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              currentUserType.sentenceCase,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text(
                  'Email',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge!.fontSize),
                ),
                suffixIcon: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.contains(' ') ||
                    !(value.contains('@'))) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (newValue) {
                userEmail = newValue!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                errorMaxLines: 2,
                label: Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge!.fontSize),
                ),
                suffixIcon: IconButton(
                  onPressed: _togglePassVisibility,
                  icon: isPasswordVisible
                      ? Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
              ),
              obscureText: isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password cannot be empty';
                }
                return null;
              },
              onSaved: (newValue) {
                userPass = newValue!;
              },
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedBtn(
              content: "Login",
              onPressed: _onLoginPress,
              isLoading: _isAuthenticating,
            ),
          ],
        ),
      ),
    ));
  }
}
