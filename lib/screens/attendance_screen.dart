import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:school_mgmt/models/attendance_record.dart';
import 'package:school_mgmt/providers/attendance_list_provider.dart';
import 'package:school_mgmt/services/attendance_service.dart';
import 'package:school_mgmt/utils/utils.dart';
// import 'package:school_mgmt/utils/utils.dart';
import 'package:school_mgmt/widgets/attendance_widget.dart';
import 'package:school_mgmt/widgets/elevated_btn.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  String _selectedDate = DateFormat('d-M-yyyy').format(DateTime.now());
  final _attendanceService = AttendanceService();
  bool _isLoading = false;

  void getStudent() async {
    final response = await _attendanceService.getAttendanceRecords(
        selectedDate: null); //null because it will fetch the curent day first

    ref.read(attendanceProvider.notifier).updateList(response);
  }

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  void _datePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2025, 2, 1),
      lastDate: DateTime.now(),
      barrierDismissible: false,
      helpText: 'Select Attendance Date',
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat('d-M-yyyy').format(pickedDate);
        pickedPreviousDate = _selectedDate;
      });
    } else {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final previousAttendanceRecords = await _attendanceService
        .getAttendanceRecords(selectedDate: _selectedDate);
    ref.read(attendanceProvider.notifier).updateList(
        previousAttendanceRecords); //update the list provider after fethcing data
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/att.png',
              color: Colors.white,
              height: appBarIconHeight,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "ATTENDANCE",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 40,
            color: Theme.of(context).colorScheme.primaryFixedDim,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    "Class: ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "10 A",
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimaryFixed),
                  ),
                  Spacer(),
                  TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                    label: Row(
                      children: [
                        Text(
                          style: TextStyle(
                              fontSize: 22,
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed),
                          _selectedDate,
                        ),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          size: 35,
                        )
                      ],
                    ),
                    onPressed: _datePicker,
                    icon: Icon(
                      size: 28,
                      Icons.date_range_rounded,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            height: 40,
            child: Row(children: [
              Expanded(
                // flex: 1,
                child: Text(
                  " Roll",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Student Name",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "Present",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Text(
                  "Absent",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ]),
          ),
          Flexible(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : AttendanceWidget(),
          ),
        ],
      ),
    );
  }
}
