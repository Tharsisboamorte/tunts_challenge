import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.studentName,
    required super.absence,
    required super.p1,
    required super.p2,
    required super.p3,
    required super.situation,
    required super.naf,
  });

  Map<String, dynamic> toMap() {
    return {
      'Matricula': id,
      'Aluno': studentName,
      'Faltas': absence,
      'P1': p1,
      'P2': p2,
      'P3': p3,
      'Situação': situation,
      'Nota para Aprovação Final': naf,
    };
  }

  StudentModel.fromMap(DataMap map)
      : super(
          id: (map['Matricula'] as num).toInt(),
          studentName: map['Aluno'] as String,
          absence: (map['Faltas'] as num).toInt(),
          p1: (map['P1'] as num).toInt(),
          p2: (map['P2'] as num).toInt(),
          p3: (map['P3'] as num).toInt(),
          situation: map['Situação'].toString().isNotEmpty
              ? map['Situação'] as String
              : 'Aprovado ',
          naf: map['Nota para Aprovação Final'].toString().isNotEmpty
              ? map['Nota para Aprovação Final'] as String
              : '0',
        );
}
