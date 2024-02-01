import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';
import 'package:tunts_challenge_exam/src/home/domain/usecases/get_students_data.dart';
import 'package:tunts_challenge_exam/src/home/domain/usecases/post_student_final_note.dart';
import 'package:tunts_challenge_exam/src/home/domain/usecases/post_student_situation.dart';

part 'classroom_state.dart';

class ClassroomCubit extends Cubit<ClassroomState> {
  ClassroomCubit({
    required GetStudentsData getStudentsData,
    required PostStudentFinalNote postStudentFinalNote,
    required PostStudentSituation postStudentSituation,
  })  : _getStudentsData = getStudentsData,
        _postStudentFinalNote = postStudentFinalNote,
        _postStudentSituation = postStudentSituation,
        super(const ClassroomInitial());

  final GetStudentsData _getStudentsData;

  final PostStudentFinalNote _postStudentFinalNote;

  final PostStudentSituation _postStudentSituation;

  Future<void> getStudentsData() async {
    emit(const GettingStudentsData());
    final result = await _getStudentsData();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (students) => emit(StudentsLoaded(students)),
    );
  }

  Future<void> postStudentFinalNote({
    required List<Student> students,
  }) async {
    emit(const AddingFinalNote());


    for (final student in students) {
      var naf = 0;

      if (student.situation == 'Exame final') {
        final m = calculateAverageNote(student);

        const desiredResult = 5;

        naf = (desiredResult * 2) - m;

        debugPrint(naf.toString());
      }

      await _postStudentFinalNote(
        PostStudentNafParams(
          studentId: student.id,
          naf: naf.round().toString(),
        ),
      );
    }

    final result = await _getStudentsData();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (students) => emit(ClassroomCreated(students)),
    );
  }

  Future<void> postStudentSituation({
    required List<Student> students,
  }) async {
    emit(const AddingFinalNote());

    for (final student in students) {
      final m = calculateAverageNote(student);

      var situation = '';

      final absence = student.absence;
      const totalNumberOfClasses = 60;

      final percentageLoss = (absence * 100) / totalNumberOfClasses;

      if (percentageLoss.round() > 25) {
        situation = 'Reprovado por Falta';
      } else if (m < 5) {
        situation = 'Reprovado por Nota';
      } else if (m >= 5 && m < 7) {
        situation = 'Exame final';
      } else if (m >= 7) {
        situation = 'Aprovado';
      }

      debugPrint(situation);
      debugPrint(percentageLoss.round().toString());

      await _postStudentSituation(
        PostSituationParams(
          studentId: student.id,
          situation: situation,
        ),
      );
    }

    final result = await _getStudentsData();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (students) => emit(AddedSituation(students)),
    );
  }
}

int calculateAverageNote(Student student) {
  final p1 = student.p1;
  final p2 = student.p2;
  final p3 = student.p3;

  var m = (p1 + p2 + p3) / 3;
  m = m / 10;

  debugPrint(m.round().toString());

  return m.round();
}
