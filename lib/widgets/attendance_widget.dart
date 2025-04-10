import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_mgmt/models/attendance_record.dart';
import 'package:school_mgmt/providers/attendance_list_provider.dart';
import 'package:school_mgmt/services/attendance_service.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class AttendanceWidget extends ConsumerStatefulWidget {
  const AttendanceWidget({super.key});

  @override
  ConsumerState<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends ConsumerState<AttendanceWidget> {
  void _onSubmit(List<AttendanceRecord> newList) async {
    ref.read(attendanceProvider.notifier).updateList(newList);
    final uploadService = AttendanceService();

    // Show styled loading dialog for 2 seconds
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Marking attendance...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    final response = await uploadService.uploadAttendance(newList);

    if (mounted) Navigator.of(context).pop(); // Close loading dialog

    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  response ? Icons.check_circle : Icons.error,
                  color: response ? Colors.green : Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  response ? "Attendance Submitted" : "Submission Failed",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  response
                      ? "Attendance marked successfully."
                      : "Something went wrong. Please try again.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentList = ref.watch(attendanceProvider);

    if (studentList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget studentRowWidget(AttendanceRecord student) {
      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  student.roll,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: Text(
                  student.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: Transform.scale(
                  scale: 1.4,
                  child: Radio<bool>(
                    value: true,
                    groupValue: student.isPresent,
                    onChanged: (value) {
                      setState(() {
                        student.isPresent = value!;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Transform.scale(
                  scale: 1.4,
                  child: Radio<bool>(
                    value: false,
                    groupValue: student.isPresent,
                    onChanged: (value) {
                      setState(() {
                        student.isPresent = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      addAutomaticKeepAlives: true,
      cacheExtent: 500,
      itemExtent: 100,
      physics: const ClampingScrollPhysics(),
      addRepaintBoundaries: true,
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 50),
      itemBuilder: (context, index) {
        if (index == studentList.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
            child: ElevatedBtn(
              content: 'Mark Attendance',
              vPadding: 15,
              hPadding: 0,
              onPressed: () {
                _onSubmit(studentList);
              },
            ),
          );
        }
        return studentRowWidget(studentList[index]);
      },
      itemCount: studentList.length + 1,
    );
  }
}
