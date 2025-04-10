class Student {
  final String id;
  final String name;
  final String contactNumber;
  final String roll;
  final String classroomId;
  final String parentId;

  Student(
      {required this.id,
      required this.name,
      required this.contactNumber,
      required this.roll,
      required this.classroomId,
      required this.parentId});

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      contactNumber: map['contact_number'],
      roll: map['roll'],
      classroomId: map['classroom_id'],
      parentId: map['parent_id'],
    );
  }
}
