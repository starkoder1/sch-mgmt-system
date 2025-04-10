class AttendanceRecord {
  final String studentId;
  final String name;
  final String roll;
  bool isPresent;

  AttendanceRecord({
    required this.studentId,
    required this.name,
    required this.roll,
    required this.isPresent,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      studentId: map['students']['id'],
      name: map['students']['name'],
      roll: map['students']['roll'],
      isPresent: map['is_present'],
      //{is_present: true, students: {id: 3d7720fb-966e-4715-9e0b-3d650d41ff69, name: Student 1, roll: 101}}, {is_present: true, students: {id: 119c9ee9-ddb9-4631-81c1-f9501a222dfb, name: Student 2, roll: 102}},
    );
  }
  
}
