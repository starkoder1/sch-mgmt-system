import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';
import 'package:school_mgmt/widgets/file_picker.dart';

class TeacherNoticeScreen extends StatefulWidget {
  const TeacherNoticeScreen({super.key});

  @override
  State<TeacherNoticeScreen> createState() => _TeacherNoticeScreenState();
}

class _TeacherNoticeScreenState extends State<TeacherNoticeScreen> {
  final _noticeController = TextEditingController();
  File? pickedFile;
  bool isLoading = false;
  String? pickedFileName;

  void _uploadNotice() async {
    if (_noticeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Description cannot be empty"),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    try {
      if (pickedFile != null) {
        setState(() => isLoading = true);

        final ref = FirebaseStorage.instance.ref().child('notices/$pickedFileName');
        await ref.putFile(pickedFile!);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('notices').add({
          'title': _noticeController.text,
          'url': url,
        });

        if (mounted) {
          setState(() {
            pickedFile = null;
            pickedFileName = null;
            _noticeController.clear();
            isLoading = false;
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Notice uploaded successfully"),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  void _chooseFile() async {
    try {
      final file = await filePicker();
      if (file != null) {
        setState(() {
          pickedFile = file;
          pickedFileName = fileName;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/notice.png',
              height: appBarIconHeight,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 10),
            Text(
              "NOTICE & EVENTS",
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter Details"),
            TextField(
              controller: _noticeController,
              minLines: 10,
              maxLines: null,
              cursorColor: theme.primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.primaryContainer,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFieldOutlineRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(textFieldOutlineRadius),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondaryContainer,
              ),
              onPressed: _chooseFile,
              child: Text(
                "Add File",
                style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
              ),
            ),
            if (pickedFile != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pickedFileName!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          pickedFile = null;
                          pickedFileName = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            Row(
              children: const [
                Icon(Icons.info_outline, size: 18),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    "Only PDF and image files under 3MB are allowed.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Center(
              child: ElevatedBtn(
                onPressed: _uploadNotice,
                content: "Upload Notice",
                vPadding: 15,
                hPadding: 90,
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
