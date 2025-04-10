import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_mgmt/models/attendance_record.dart';
import 'package:flutter/material.dart';

class AttendanceListNotifier extends StateNotifier<List<AttendanceRecord>> {
  AttendanceListNotifier() : super([]);
  void updateList(List<AttendanceRecord> newList) {
    state = [...newList];
   
  }

  void clearList() {
    state = [];
  }
}

final attendanceProvider =
    StateNotifierProvider<AttendanceListNotifier, List<AttendanceRecord>>(
  (ref) => AttendanceListNotifier(),
);
