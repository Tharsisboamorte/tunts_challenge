import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:tunts_challenge_exam/src/home/data/datasources/class_datasource.dart';
import 'package:tunts_challenge_exam/src/home/data/repos/class_repository_impl.dart';
import 'package:tunts_challenge_exam/src/home/domain/repository/class_repository.dart';
import 'package:tunts_challenge_exam/src/home/domain/usecases/get_students_data.dart';
import 'package:tunts_challenge_exam/src/home/domain/usecases/post_student_final_note.dart';
import 'package:tunts_challenge_exam/src/home/domain/usecases/post_student_situation.dart';
import 'package:tunts_challenge_exam/src/home/presentation/cubit/classroom_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    //App Logic
    ..registerFactory(
      () => ClassroomCubit(
        getStudentsData: sl(),
        postStudentFinalNote: sl(),
        postStudentSituation: sl(),
      ),
    )

    //Use cases
    ..registerLazySingleton(() => GetStudentsData(sl()))
    ..registerLazySingleton(() => PostStudentFinalNote(sl()))
    ..registerLazySingleton(() => PostStudentSituation(sl()))

    //Repositories
    ..registerLazySingleton<ClassRepository>(
      () => ClassRepositoryImpl(sl()),
    )

    //Data Sources
    ..registerLazySingleton<ClassDataSource>(
      () => ClassRemoteDataSrcImpl(sl(), sl()),
    )

    //External Dependencies
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(Dio.new);
}
