import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_mgmt/utils/image_picker.dart';

class BackgroundDesign extends StatefulWidget {
  final bool allowImageSelection;
  final String? profileImageUrl;

  const BackgroundDesign({
    super.key,
    this.allowImageSelection = false,
    this.profileImageUrl,
  });

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
    Widget content;

    if (pickedImage != null) {
      content = ClipOval(
        child: Image.file(
          pickedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (widget.profileImageUrl != null) {
      content = ClipOval(
        child: Image.network(
          widget.profileImageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.person, size: 100, color: Colors.black),
        ),
      );
    } else {
      content = const Icon(
        Icons.person_add,
        color: Colors.black,
        size: 100,
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // Outer white container
        Container(
          // color: Colors.white,
          height: 325, // Total height of the background design
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
                    // color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
        // Center avatar positioned to overlap the teal curve
        Positioned(
          top: 90, // Position the avatar to overlap the curved container
          left: MediaQuery.of(context).size.width / 2 - 90,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.teal,
                width: 4.0,
              ),
            ),
            child: InkWell(
              onTap: widget.allowImageSelection
                  ? () {
                      _chooseImageSource(context);
                    }
                  : null,
              child: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.white,
                child: content,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          widget.allowImageSelection
              ? "Add Profile Picture"
              : "Profile Picture",
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}
