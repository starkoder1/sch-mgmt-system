class StudentAttendance {
  final String studentId;
  final String studentName;
  final DateTime attendanceDate;
  final bool isPresent;

  StudentAttendance({
    required this.studentId,
    required this.studentName,
    required this.attendanceDate,
    required this.isPresent,
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) {
    return StudentAttendance(
      studentId: json['student_id'] as String, // Ensure it's a string
      studentName: json['students']['name'] as String, // Nested JSON extraction
      attendanceDate: DateTime.parse(json['attendance_date']),
      isPresent: json['is_present'] as bool,
    );
  }
}
