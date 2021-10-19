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
}
