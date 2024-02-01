import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tunts_challenge_exam/core/extensions/context_extension.dart';

class StudentListItem extends StatelessWidget {
  const StudentListItem({
    required this.p1, required this.p2, required this.p3, super.key,
    this.situation,
    this.naf,
  });

  final String? situation;
  final String? naf;
  final int p1;
  final int p2;
  final int p3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('P1: $p1 '),
            Text('| P2: $p2'),
            Text(' | P3: $p3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Situação: $situation '),
            Text(' Naf: $naf'),
          ],
        ),
        SizedBox(
          height: context.height * .02,
          child: const Divider(),
        ),
      ],
    );
  }
}
