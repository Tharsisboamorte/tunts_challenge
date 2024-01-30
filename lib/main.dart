import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunts_challenge_exam/core/services/injection_container.dart';
import 'package:tunts_challenge_exam/src/home/presentation/cubit/classroom_cubit.dart';
import 'package:tunts_challenge_exam/src/home/presentation/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ClassroomCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const HomePage(),
      ),
    );
  }
}
