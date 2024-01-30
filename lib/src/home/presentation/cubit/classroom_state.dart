part of 'classroom_cubit.dart';

@immutable
abstract class ClassroomState extends Equatable {
  const ClassroomState();

  @override
  List<Object> get props => [];
}

class ClassroomInitial extends ClassroomState {
  const ClassroomInitial();
}

class GettingStudentsData extends ClassroomState{
  const GettingStudentsData();
}

class AddingFinalNote extends ClassroomState{
  const AddingFinalNote();
}

class AddedFinalNote extends ClassroomState{
  const AddedFinalNote();
}

class AddingSituation extends ClassroomState{
  const AddingSituation();
}

class ClassroomCreated extends ClassroomState{
  const ClassroomCreated();
}

class StudentsLoaded extends ClassroomState{
  const StudentsLoaded(this.students);

  final List<Student> students;

  @override
  List<Object> get props => students.map((student) => student.id).toList();
}

class AuthenticationError extends ClassroomState{
  const AuthenticationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
