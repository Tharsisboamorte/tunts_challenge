import 'package:equatable/equatable.dart';

class Student extends Equatable {
  const Student({
    required this.id,
    required this.studentName,
    required this.absence,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.situation,
    required this.naf,
  });

  final int id;
  final String studentName;
  final int absence;
  final int p1;
  final int p2;
  final int p3;
  final String situation;
  final String naf;

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return 'Student{id: $id, student: $studentName, absence: $absence,'
        ' p1: $p1, p2: $p2, p3: $p3, situation: $situation,'
        ' requiredToPass: $naf}';
  }
}
