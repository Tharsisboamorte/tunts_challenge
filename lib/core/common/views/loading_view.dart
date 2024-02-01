import 'package:flutter/material.dart';
import 'package:tunts_challenge_exam/core/extensions/context_extension.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                context.theme.colorScheme.secondary,),
            ),
            const SizedBox(width: 10),
            Text('$message...'),
          ],
        ),
      ),
    );
  }
}
