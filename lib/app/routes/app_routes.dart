part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const login = _Paths.login;

  static String loginThen(String afterSuccessFullLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessFullLogin)}';
  static const home = _Paths.home;
  static const students = _Paths.home + _Paths.students;

  static String detailStudent(String idStudent) =>
      '$students/detail/$idStudent';

  static String tasks(String idStudent) => '$students/tasks/$idStudent';

  static String assistances(String idStudent) =>
      '$students/assistances/$idStudent';

  static String qualifications(String idStudent) =>
      '$students/qualifications/$idStudent';
  static const newAssistance = _Paths.newAssistance;
  static const editAssistance = _Paths.editAssistance;
  static const newTask = _Paths.newTask;
  static const newQualTasks = _Paths.newQualTasks;
  static const newQualNotes = _Paths.newQualNotes;
  static const editQualTasks = _Paths.editQualTasks;
  static const editQualNotes = _Paths.editQualNotes;

  static String docenteThen(String afterSuccessDocente) =>
      '$home?then=${Uri.encodeQueryComponent(afterSuccessDocente)}';
}

abstract class _Paths {
  static const login = '/login';
  static const home = '/home';
  static const students = '/students';
  static const detailStudent = '/detail/:idStudent';
  static const tasks = '/tasks/:idStudent';
  static const assistances = '/assistances/:idStudent';
  static const qualifications = '/qualifications/:idStudent';
  static const newAssistance = '/newAssistance';
  static const editAssistance  = '/editAssistance';
  static const newTask = '/newTask';
  static const editQualTasks = '/editQualTasks';
  static const newQualTasks = '/newQualTasks';
  static const newQualNotes = '/newQualNotes';
  static const editQualNotes = '/editQualNotes';
}
