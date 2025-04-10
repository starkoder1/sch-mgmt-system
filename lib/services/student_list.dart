import 'package:school_mgmt/models/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentFetchService {
  Future<List<Student>> fetchStudents() async {
    final List<Student> studentsList;
    try {
      final response =
          await Supabase.instance.client.from('students').select('*');
      print(response);
      studentsList = response.map(
        (student) {
          return Student.fromMap(student);
        },
      ).toList();
      print('student fetched successfully');
      return studentsList;
    } catch (error) {
      // print(error);z
      throw Exception('Failed to fetch students : $error');
    }
  }
}
