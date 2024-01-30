import 'package:equatable/equatable.dart';
import 'package:tunts_challenge_exam/core/usecase/usecase.dart';
import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/domain/repository/class_repository.dart';

class PostStudentFinalNote extends UseCaseWithParams<void, PostStudentParams> {
  const PostStudentFinalNote(this._classRepository);

  final ClassRepository _classRepository;

  @override
  ResultVoid call(PostStudentParams params) async =>
      _classRepository.postRequiredToPass(
        naf: params.naf,
        studentId: params.studentId,
      );
}

class PostStudentParams extends Equatable {
  const PostStudentParams({required this.studentId, required this.naf});

  final int studentId;
  final String naf;

  @override
  List<Object?> get props => [studentId, naf];
}
