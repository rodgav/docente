import 'package:docente/app/data/middlewares/auth_middleware.dart';
import 'package:docente/app/modules/assistances/assistances_binding.dart';
import 'package:docente/app/modules/assistances/assistances_view.dart';
import 'package:docente/app/modules/detail_student/detail_student_binding.dart';
import 'package:docente/app/modules/detail_student/detail_student_view.dart';
import 'package:docente/app/modules/home/home_binding.dart';
import 'package:docente/app/modules/home/home_view.dart';
import 'package:docente/app/modules/login/login_binding.dart';
import 'package:docente/app/modules/login/login_view.dart';
import 'package:docente/app/modules/new_assistance/new_assistance_binding.dart';
import 'package:docente/app/modules/new_assistance/new_assistance_view.dart';
import 'package:docente/app/modules/qualifications/qualifications_binding.dart';
import 'package:docente/app/modules/qualifications/qualifications_view.dart';
import 'package:docente/app/modules/root/root_binding.dart';
import 'package:docente/app/modules/root/root_view.dart';
import 'package:docente/app/modules/students/students_binding.dart';
import 'package:docente/app/modules/students/students_view.dart';
import 'package:docente/app/modules/tasks/tasks_binding.dart';
import 'package:docente/app/modules/tasks/tasks_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;
  static final routes = [
    GetPage(
        name: '/',
        page: () => RootPage(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          GetPage(
              preventDuplicates: true,
              middlewares: [EnsureNotAuthMiddleware()],
              name: _Paths.login,
              page: () => LoginPage(),
              binding: LoginBinding()),
          GetPage(
              preventDuplicates: true,
              middlewares: [EnsureAuthMiddleware()],
              name: _Paths.home,
              page: () => HomePage(),
              binding: HomeBinding(),
              children: [
                GetPage(
                    name: _Paths.students,
                    page: () => StudentsPage(),
                    binding: StudentsBinding(),
                    children: [
                      GetPage(
                          name: _Paths.detailStudent,
                          page: () => DetailStudentPage(),
                          binding: DetailStudentBinding()),
                      GetPage(
                          name: _Paths.tasks,
                          page: () => TasksPage(),
                          binding: TasksBinding()),
                      GetPage(
                          name: _Paths.assistances,
                          page: () => AssistancesPage(),
                          binding: AssistancesBinding()),
                      GetPage(
                          name: _Paths.qualifications,
                          page: () => QualificationsPage(),
                          binding: QualificationsBinding()),
                    ]),
              ]),
          GetPage(
              name: _Paths.newAssistance,
              page: () => NewAssistancePage(),
              binding: NewAssistanceBinding())
        ])
  ];
}
