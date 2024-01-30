import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';

abstract class ClassRepository {
  const ClassRepository();

  ResultFuture<List<Student>> getStudentsData();

  ResultVoid postRequiredToPass({
    required int studentId,
    required String naf
  });

  ResultVoid postSituation({required int id, required String situation});
}
