import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tunts_challenge_exam/core/utils/typedef.dart';
import 'package:http/http.dart' as http;
import 'package:tunts_challenge_exam/src/home/data/model/student_model.dart';

abstract class ClassDataSource {
  Future<List<StudentModel>> getStudentsData();

  Future<void> postSituation(
      {required String situation, required int studentId});

  Future<void> postRequiredToPass({
    required String naf,
    required int studentId,
  });
}

const classroomEndpoint =
    'https://script.google.com/macros/s/AKfycbzH_yAijoV0vETjt7TLP_7XZ1qEthdpQjtKvDp04h9pd8jTwHmvJpAKwOmwwMpkQLi_TA/exec';

class ClassRemoteDataSrcImpl implements ClassDataSource {
  const ClassRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<StudentModel>> getStudentsData() async {
    final response = await _client.get(Uri.parse(classroomEndpoint));

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    debugPrint(response.body);

    return List<DataMap>.from(jsonDecode(response.body) as List)
        .map((userData) => StudentModel.fromMap(userData))
        .toList();
  }

  @override
  Future<void> postRequiredToPass({
    required String naf,
    required int studentId,
  }) async {
    try {
      final request = await _client.post(
        Uri.parse(classroomEndpoint),
        body: jsonEncode({
          'Matricula': studentId,
          'Nota para Aprovação Final': naf,
        }),
      );

      if (request.statusCode != 200) {
        throw Exception(request.body);
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
      final request = await _client.post(
        Uri.parse(classroomEndpoint),
        body: jsonEncode({
          'Matricula': studentId,
          'Situação': situation,
        }),
      );

      if (request.statusCode != 200) {
        throw Exception(request.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
