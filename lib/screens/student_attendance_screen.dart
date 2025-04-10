import 'package:flutter/material.dart';
import 'package:school_mgmt/models/student_attendance_model.dart';
import 'package:school_mgmt/services/attendance_service.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime _normalizeDate(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day);

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  StudentAttendanceScreenState createState() => StudentAttendanceScreenState();
}

class StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  DateTime _focusedDay = _normalizeDate(DateTime.now());
  Map<DateTime, bool> attendanceMap = {};
  List<StudentAttendance> _attendanceList = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isInitialLoad = true;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fetchAttendance(_focusedDay, isInitial: true);
    });
  }

  Future<void> _fetchAttendance(DateTime selectedMonth,
      {bool isInitial = false}) async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      if (isInitial) _isInitialLoad = false;
    });
    if (!isInitial) {
      if (_isDialogShowing) {
        _dismissLoadingDialog();
      }
      _showLoadingDialog();
    }
    try {
      final normalizedMonth = _normalizeDate(selectedMonth);
      final data =
          await AttendanceService().getRandomStudentAttendance(normalizedMonth);
      if (!mounted) return;

      _attendanceList = data;

      final newAttendanceMap = {
        for (var entry in data)
          _normalizeDate(entry.attendanceDate): entry.isPresent
      };
      setState(() {
        attendanceMap = newAttendanceMap;
      });
    } catch (error) {
      print("Error in _fetchAttendance: $error");
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to load attendance: $error';
      });
    } finally {
      if (!mounted) return;
      if (!isInitial) _dismissLoadingDialog();
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showLoadingDialog() {
    if (_isDialogShowing) return;
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading attendance...',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((_) {
      _isDialogShowing = false;
    });
  }

  void _dismissLoadingDialog() {
    if (_isDialogShowing && mounted) {
      Navigator.of(context).pop();
      _isDialogShowing = false;
    }
  }

  String? get _studentName {
    return _attendanceList.isNotEmpty
        ? _attendanceList.first.studentName
        : null;
  }

  int get _presentCount =>
      attendanceMap.values.where((present) => present == true).length;

  int get _absentCount =>
      attendanceMap.values.where((present) => present == false).length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ATTENDANCE",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: theme.colorScheme.primary,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: Column(
        children: [
          if (_studentName != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Center(
                child: Text(
                  _studentName!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          TableCalendar(
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay:
                DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            onPageChanged: (focusedDay) {
              final normalizedFocusedDay = _normalizeDate(focusedDay);
              if (_focusedDay.month != normalizedFocusedDay.month ||
                  _focusedDay.year != normalizedFocusedDay.year) {
                setState(() => _focusedDay = normalizedFocusedDay);
                _fetchAttendance(normalizedFocusedDay);
              } else {
                setState(() => _focusedDay = normalizedFocusedDay);
              }
            },
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            calendarBuilders: CalendarBuilders(
              outsideBuilder: (context, date, _) => const SizedBox.shrink(),
              defaultBuilder: (context, date, focusedDay) {
                final normalizedDate = _normalizeDate(date);
                if (normalizedDate.month != _focusedDay.month) {
                  return const SizedBox.shrink();
                }
                final isPresent = attendanceMap[normalizedDate];
                Color cellColor = Colors.grey.shade300;
                Color textColor = Colors.black87;
                if (isPresent == true) {
                  cellColor = Colors.green.shade300;
                  textColor = Colors.white;
                } else if (isPresent == false) {
                  cellColor = Colors.red.shade300;
                  textColor = Colors.white;
                }
                return Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: cellColor),
                    child: Center(
                      child: Text(
                        '${normalizedDate.day}',
                        style: TextStyle(color: textColor),
                      ),
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, focusedDay) {
                final normalizedDate = _normalizeDate(date);
                if (normalizedDate.month != _focusedDay.month) {
                  return const SizedBox.shrink();
                }
                final isPresent = attendanceMap[normalizedDate];
                Color cellColor = Colors.grey.shade400;
                Color textColor = Colors.black;
                if (isPresent == true) {
                  cellColor = Colors.green;
                  textColor = Colors.white;
                } else if (isPresent == false) {
                  cellColor = Colors.red;
                  textColor = Colors.white;
                }
                return Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cellColor,
                      border:
                          Border.all(color: theme.primaryColorDark, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        '${normalizedDate.day}',
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading && _isInitialLoad)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          else if (!_isLoading && attendanceMap.isEmpty && !_isInitialLoad)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text("No attendance data found for this month."),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      Text("Summary",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor)),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Present:",
                            style: TextStyle(
                                fontSize: 16, color: Colors.green.shade700),
                          ),
                          Text(
                            "$_presentCount",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Absent:",
                            style: TextStyle(
                                fontSize: 16, color: Colors.red.shade700),
                          ),
                          Text(
                            "$_absentCount",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
