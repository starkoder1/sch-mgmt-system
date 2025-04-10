import 'package:intl/intl.dart';
import 'package:school_mgmt/models/attendance_record.dart';
import 'package:school_mgmt/models/student_attendance_model.dart';
import 'package:school_mgmt/utils/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService {
  Future<List<AttendanceRecord>> getAttendanceRecords(
      {String? selectedDate}) async {
    // Use the format used in your AttendanceScreen: d-M-yyyy
    selectedDate ??= DateFormat('d-M-yyyy').format(DateTime.now());

    try {
      // Parse using "d-M-yyyy" to match your _selectedDate format
      final DateTime convertedDate = DateFormat("d-M-yyyy").parse(selectedDate);
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(convertedDate);

      final response = await Supabase.instance.client
          .from('students')
          .select('id, name, roll, attendance(is_present)')
          .eq('attendance.attendance_date', formattedDate)
          .order('roll', ascending: true);

      return response.map<AttendanceRecord>((record) {
        return AttendanceRecord(
          studentId: record['id'],
          name: record['name'],
          roll: record['roll'],
          isPresent: (record['attendance'] as List).isNotEmpty
              ? record['attendance'][0]['is_present']
              : false,
        );
      }).toList();
    } catch (error) {
      throw Exception('Failed to fetch attendance records: $error');
    }
  }

  Future<bool> uploadAttendance(List<AttendanceRecord> attendanceList) async {
    // If pickedPreviousDate is empty, default to today using the same format ("d-M-yyyy")
    String effectiveDate = pickedPreviousDate.trim().isEmpty
        ? DateFormat('d-M-yyyy').format(DateTime.now())
        : pickedPreviousDate;

    final parsedDate = DateFormat("d-M-yyyy").parse(effectiveDate);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    final formattedList = attendanceList.map((e) {
      return {
        'student_id': e.studentId,
        'attendance_date': formattedDate,
        'is_present': e.isPresent,
        'attendance_marked': true,
      };
    }).toList();

    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('attendance')
          .upsert(formattedList, onConflict: 'student_id')
          .select();

      return response.isNotEmpty;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<List<StudentAttendance>> getRandomStudentAttendance(
      DateTime selectedMonth) async {
    final firstDayOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month, 1);
    final lastDayOfMonth =
        DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    final supabase = Supabase.instance.client;

    // Step 1: Call SQL function to get a truly random student ID
    final response = await supabase.rpc('get_random_student').single();

    if (response == null || response['student_id'] == null) {
      throw Exception("No student found.");
    }

    final studentId = response['student_id'];

    // Step 2: Get that student's attendance
    final attendanceResponse = await supabase
        .from('attendance')
        .select('''
          student_id, attendance_date, is_present, students(name)
        ''')
        .eq('student_id', studentId)
        .gte('attendance_date', firstDayOfMonth.toIso8601String())
        .lte('attendance_date', lastDayOfMonth.toIso8601String());

    if (attendanceResponse is List) {
      return attendanceResponse
          .map((json) => StudentAttendance.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch attendance data");
    }
  }
}
