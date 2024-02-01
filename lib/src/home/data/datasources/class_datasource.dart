import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:tunts_challenge_exam/src/home/data/model/student_model.dart';

abstract class ClassDataSource {
  Future<List<StudentModel>> getStudentsData();

  Future<void> postSituation({
    required String situation,
    required int studentId,
  });

  Future<void> postRequiredToPass({
    required String naf,
    required int studentId,
  });
}

const classroomEndpoint =
    'https://script.google.com/macros/s/AKfycbwRSGKmrJCFarpESC_R3NBFDELnvrf7eZHFj96Z3vV9Tt6rbim9KfWmiVUfWAsWGe3mlA/exec';

class ClassRemoteDataSrcImpl implements ClassDataSource {
  const ClassRemoteDataSrcImpl(this._client, this._dio);

  final http.Client _client;

  final Dio _dio;

  @override
  Future<List<StudentModel>> getStudentsData() async {
    final response = await _client.get(Uri.parse(classroomEndpoint));

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    debugPrint(response.body);

    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map(StudentModel.fromMap)
        .toList();
  }

  @override
  Future<void> postRequiredToPass({
    required String naf,
    required int studentId,
  }) async {
    try {
      final request = await _dio.post(
        classroomEndpoint,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'action': 'postNaf',
          'naf': naf,
          'matricula': studentId,
        },
      );

      debugPrint(request.statusMessage);
      debugPrint(request.statusCode.toString());

      if (request.statusCode != 200) {
        throw Exception(request.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> postSituation({
    required String situation,
    required int studentId,
  }) async {
    try {
      final request = await _dio.post(
        classroomEndpoint,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'action': 'postSituation',
          'situacao': situation,
          'matricula': studentId,
        },
      );


      if (request.statusCode != 200) {
        throw Exception(request.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
