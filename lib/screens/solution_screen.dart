import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class TeacherSolutionScreen extends StatefulWidget {
  final int questionNumber;
  final String questionText;

  const TeacherSolutionScreen({
    super.key,
    required this.questionNumber,
    required this.questionText,
  });

  @override
  State<TeacherSolutionScreen> createState() => _SolutionScreenState();
}

class _SolutionScreenState extends State<TeacherSolutionScreen> {
  final _solutionController = TextEditingController();
  File? _pickedFile;
  bool _isSending = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null && result.files.single.size <= 3 * 1024 * 1024) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    } else if (result != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("File must be under 3MB")));
    }
  }

  void _clearPickedFile() {
    setState(() {
      _pickedFile = null;
    });
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
              'assets/icons/solutions.png',
              height: appBarIconHeight,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: 10),
            Text("SOLUTIONS",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question ${widget.questionNumber}"),
            const SizedBox(height: 10),
            Text(widget.questionText),
            const SizedBox(height: 10),
            const Text("Enter Feedback"),
            TextField(
              controller: _solutionController,
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

            /// Add File Button
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file),
                  label: const Text("Add File"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    foregroundColor: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(width: 10),
                if (_pickedFile != null)
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _pickedFile!.path.split('/').last,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _clearPickedFile,
                        )
                      ],
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16),
                const SizedBox(width: 4),
                Text(
                  "Only PDFs and images under 3MB allowed",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: 80),
            Center(
              child: ElevatedBtn(
                onPressed: () {
                  // Example submit behavior
                  FocusScope.of(context).unfocus();
                  _solutionController.clear();
                  setState(() {
                    _pickedFile = null;
                    _isSending = true;
                  });
                  Future.delayed(const Duration(seconds: 2), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Answer Sent✅"),
                      ),
                    );
                    setState(() {
                      _isSending = false;
                    });
                  });
                },
                content: "Send",
                isLoading: _isSending,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
