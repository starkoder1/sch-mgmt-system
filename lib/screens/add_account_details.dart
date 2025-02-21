import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/background_design.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class AddAccountDetailsScreen extends StatefulWidget {
  const AddAccountDetailsScreen({super.key});

  @override
  State<AddAccountDetailsScreen> createState() {
    return _AddAccountDetailsScreenState();
  }
}

class _AddAccountDetailsScreenState extends State<AddAccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String teacherName = '';
  String tEmail = '';
  String contactNum = '';
  String classTeacherSection = '';
  String newPass = '';
  String confirmPass = '';
  // final String teacherName='';

  var _isPassVisible = false;
  final bool _isPictureSelected=false;

  void _togglePassVisibility() {
    if (_isPassVisible) {
      setState(() {
        _isPassVisible = false;
      });
    } else {
      setState(() {
        _isPassVisible = true;
      });
    }
  }

  void _onSubmitPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); //curentstate cant be null because form builds first

      print("form saved successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Theme.of(context).primaryColor,
        child: Text(
          "TEACHER DETAILS",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          const BackgroundDesign(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(screenEdgePadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(fontSize: 20),
                          labelText: "Full Name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 6) {
                            return 'Full Name cannot be empty or less than 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: formFieldGap,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          labelText: "Email",
                          floatingLabelStyle: const TextStyle(fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).unselectedWidgetColor,
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
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
                      ),
                      const SizedBox(
                        height: formFieldGap,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: "Contact Number",
                          floatingLabelStyle: const TextStyle(fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).unselectedWidgetColor,
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length != 10) {
                            return 'Contact Number must be only 10 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: formFieldGap,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Class Teacher Section",
                          floatingLabelStyle: const TextStyle(fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).unselectedWidgetColor,
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                        ),
                        onSaved: (newValue) {
                          classTeacherSection = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: formFieldGap,
                      ),
                      TextFormField(
                        obscureText: !_isPassVisible,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isPassVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: _togglePassVisibility,
                          ),
                          labelText: "Password",
                          floatingLabelStyle: const TextStyle(fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).unselectedWidgetColor,
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                          errorMaxLines: 2,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          final RegExp passCheck = RegExp(
                              r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$'); // regEx for validating user password

                          if (!passCheck.hasMatch(value)) {
                            return 'Password must contain at least 1 lowercase letter, 1 uppercase letter, 1 digit, and be at least 8 characters long';
                          }
                          setState(() {
                            newPass = value;
                          });
                          return null;
                        },
                        onChanged: (newValue) {
                          newPass = newValue;
                        },
                      ),
                      const SizedBox(
                        height: formFieldGap,
                      ),
                      TextFormField(
                        obscureText: !_isPassVisible,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isPassVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: _togglePassVisibility,
                          ),
                          labelText: "Confirm Password",
                          floatingLabelStyle: const TextStyle(fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).unselectedWidgetColor,
                                width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(textFieldOutlineRadius),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          if (value != newPass) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          confirmPass = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: formFieldGap,
                      ),
                      ElevatedBtn(
                        content: "Submit",
                        onPressed: _onSubmitPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
