import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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

    for (var student in students) {
      final int m = calculateFinalNote(student);
      //TODO(PostStudentFinalNote): take calculate off here and implement new BloC

      await _postStudentFinalNote(
        PostStudentParams(studentId: student.id, naf: m.toString()),
      );
    }

    emit(const AddedFinalNote());
  }

  Future<void> postStudentSituation({
    required List<Student> students,
  }) async {
    emit(const AddingFinalNote());

    for (var student in students) {
      final int m = calculateAverageNote(student);

      String situation = '';

      if (m < 5) {
        situation = 'Reprovado por Nota';
      } else if (m >= 5 && m < 7) {
        situation = 'Exame final';
      } else if (student.absence <= 7) {}

      if (m >= 7) {
        situation = 'Aprovado';
      }

      await _postStudentSituation(
        PostSituationParams(studentId: student.id, situation: situation),
      );
    }

    emit(const AddedFinalNote());
  }
}

int calculateFinalNote(Student student) {
  final m = calculateAverageNote(student);

  double desiredResult = 5;

  double naf = (desiredResult * 2) - m;

  return naf.round();
}

int calculateAverageNote(Student student) {
  final p1 = student.p1;
  final p2 = student.p2;
  final p3 = student.p3;

  final m = p1 + p2 + p3 / 3;

  return m.round();
}
