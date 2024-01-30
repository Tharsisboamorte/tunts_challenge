import 'package:flutter/cupertino.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';

class StudentListItem extends StatelessWidget {
  const StudentListItem({super.key, this.situation, this.naf});

  final String? situation;
  final String? naf;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Situação: $situation"),
        Text("Naf: $naf"),
      ],
    );
  }
}
