
import 'package:equatable/equatable.dart';
import 'package:tunts_challenge_exam/core/usecase/usecase.dart';
import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/domain/repository/class_repository.dart';

class PostStudentSituation extends UseCaseWithParams<void, PostSituationParams> {
  const PostStudentSituation(this._classRepository);

  final ClassRepository _classRepository;

  @override
  ResultVoid call(PostSituationParams params) async =>
      _classRepository.postSituation(
        situation: params.situation,
        id: params.studentId,
      );
}

class PostSituationParams extends Equatable {
  const PostSituationParams({required this.studentId, required this.situation});

  final int studentId;
  final String situation;

  @override
  List<Object?> get props => [studentId, situation];
}


