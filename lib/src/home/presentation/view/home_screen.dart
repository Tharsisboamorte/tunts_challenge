import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunts_challenge_exam/core/common/views/loading_view.dart';
import 'package:tunts_challenge_exam/src/home/domain/entity/student.dart';
import 'package:tunts_challenge_exam/src/home/presentation/cubit/classroom_cubit.dart';
import 'package:tunts_challenge_exam/src/home/presentation/widgets/student_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void getStudents() {
    context.read<ClassroomCubit>().getStudentsData();
  }

  void postFinalNote(List<Student> students) {
    context
        .read<ClassroomCubit>()
        .postStudentFinalNote(students: students);
  }

  void postSituation(List<Student> students){
    context.read<ClassroomCubit>();
  }

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClassroomCubit, ClassroomState>(
        listener: (context, state) {
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
      if(state is AddedFinalNote) {
        getStudents();
      }
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: state is GettingStudentsData
              ? const LoadingView()
              : state is StudentsLoaded
                  ? Center(
                      child: ListView.builder(
                        itemCount: state.students.length,
                        itemBuilder: (context, index) {
                          postFinalNote(state.students);

                          final student = state.students[index];
                          return ListTile(
                            title: Text(student.studentName),
                            subtitle: StudentListItem(
                              situation: student.situation,
                              naf: student.naf,
                            ),
                          );
                        },
                      ),
                    )
                  : const LoadingView());
    });
  }
}
