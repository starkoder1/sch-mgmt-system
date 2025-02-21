import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_mgmt/utils/image_picker.dart';
import 'package:school_mgmt/utils/utils.dart';

class BackgroundDesign extends StatefulWidget {
  const BackgroundDesign({super.key});

  @override
  State<BackgroundDesign> createState() => _BackgroundDesignState();
}

class _BackgroundDesignState extends State<BackgroundDesign> {
  final imagepicker = ImagePickerHelper();
  File? pickedImage;

  Future<void> _chooseImageSource(BuildContext context) {
    return showAdaptiveDialog(
      barrierDismissible: false,
      barrierLabel: "Choose Source",
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text(
          "Choose Image Source",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton.icon(
                  label: const Text("Camera"),
                  onPressed: () async {
                    File? selectedImage =
                        await imagepicker.userPickImageFrom(ImageSource.camera);
                    if (selectedImage != null) {
                      setState(() {
                        pickedImage = selectedImage;
                      });
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    size: 45,
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  label: const Text("Gallery"),
                  onPressed: () async {
                    File? selectedImage = await imagepicker
                        .userPickImageFrom(ImageSource.gallery);
                    if (selectedImage != null) {
                      setState(() {
                        pickedImage = selectedImage;
                      });
                    }
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.photo_library_rounded,
                    size: 45,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const FittedBox(
      fit: BoxFit.cover,
      child: Icon(
        Icons.person_add,
        color: Colors.black,
        size: 100,
      ),
    );
    if (pickedImage != null) {
      setState(() {
        content = ClipOval(
          child: Image.file(
            pickedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      });
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // Outer white container
        Container(
          color: Colors.white,
          height: 350, // Total height of the background design
          child: Column(
            children: [
              // Curved teal container
              Container(
                height: 170, // Limit the height explicitly
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(800, 500),
                    bottomRight: Radius.elliptical(800, 500),
                  ),
                  color: Colors.teal,
                ),
              ),
              // Additional white background below the teal curve
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: 0.08), // Shadow color
                        offset: const Offset(0,
                            15), // Vertical offset to show shadow at the bottom
                        blurRadius: 35, // Blur effect
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Center avatar positioned to overlap the teal curve
        Positioned(
          top: 90, // Position the avatar to overlap the curved container
          left:
              MediaQuery.of(context).size.width / 2 - 90, // Center horizontally
          child: Container(
            width: 180, // CircleAvatar size (adjust as needed)
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.teal, // Border color to make it stand out
                width: 4.0, // Border thickness
              ),
            ),
            child: InkWell(
              onTap: () {
                _chooseImageSource(context);
              },
              child: CircleAvatar(
                  radius: profilePictureRadius, // Profile picture size
                  backgroundColor: Colors.white,
                  child: content),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          "Add Profile Picture",
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}
