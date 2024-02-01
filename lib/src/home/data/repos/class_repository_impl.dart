import 'package:dartz/dartz.dart';
import 'package:tunts_challenge_exam/core/errors/exceptions.dart';
import 'package:tunts_challenge_exam/core/errors/failures.dart';
import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/data/datasources/class_datasource.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';
import 'package:tunts_challenge_exam/src/home/domain/repository/class_repository.dart';

class ClassRepositoryImpl implements ClassRepository {
  const ClassRepositoryImpl(this._classDataSource);

  final ClassDataSource _classDataSource;

  @override
  ResultFuture<List<Student>> getStudentsData() async {
    try {
      final result = await _classDataSource.getStudentsData();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid postRequiredToPass({
    required int studentId,
    required String naf,
  }) async {
    try {
      await _classDataSource.postRequiredToPass(
        naf: naf,
        studentId: studentId,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid postSituation({
    required int studentId,
    required String situation,
  }) async {
    try {
      await _classDataSource.postSituation(
        situation: situation,
        studentId: studentId,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
