import 'package:tunts_challenge_exam/core/usecase/usecase.dart';
import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';
import 'package:tunts_challenge_exam/src/home/domain/repository/class_repository.dart';

class GetStudentsData extends UseCaseWithoutParams<List<Student>> {
  const GetStudentsData(this._classRepository);

  final ClassRepository _classRepository;

  @override
  ResultFuture<List<Student>> call() async =>
      _classRepository.getStudentsData();
}
