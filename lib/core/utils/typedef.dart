import 'package:dartz/dartz.dart';
import 'package:tunts_challenge_exam/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

typedef ResultVoid = ResultFuture<void>;
