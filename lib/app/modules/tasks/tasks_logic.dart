import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TasksLogic extends GetxController {
  final String _idStudent;

  TasksLogic(this._idStudent);

  final _dataRepository = Get.find<DataRepository>();

  DocumentList? _tasks;
  Document? _task;
  Document? _taskStd;
  String _selectedTask = '';
  Document? _student;

  DocumentList? get tasks => _tasks;

  Document? get task => _task;

  Document? get taskStd => _taskStd;

  String get selectedTask => _selectedTask;

  Document? get student => _student;

  @override
  void onReady() {
    _getStudent();
    super.onReady();
  }

  void _getStudent() async {
    _student = await _dataRepository.getStud(idStudent: _idStudent);
    update(['student']);
    if (student != null) {
      _getTaskG(student!.data['grade']);
    }
  }

  void _getTaskG(String grade) async {
    _tasks = await _dataRepository.getTasksG(grade: grade);
    if (tasks != null) {
      final data = tasks!.documents[0];
      final date = DateTime.parse(data.data['date']);
      final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
      final day = DateFormat('d', 'es_ES').format(date);
      final month = DateFormat('MMMM', 'es_ES').format(date);
      _selectedTask = '$dayWeek $day del $month';
      update(['tasks']);
      _task = data;
      update(['task']);
      _getTaskStudent(tasks!.documents[0].$id);
    }
  }

  void selectTask(Document document) {
    final date = DateTime.parse(document.data['date']);
    final dayWeek = DateFormat('EEEE', 'es_ES').format(date);
    final day = DateFormat('d', 'es_ES').format(date);
    final month = DateFormat('MMMM', 'es_ES').format(date);
    _selectedTask = '$dayWeek $day del $month';
    update(['tasks']);
    _task = document;
    update(['task']);
    _getTaskStudent(document.$id);
  }

  void launchPDF(String pdfURL) async {
    await canLaunch(pdfURL)
        ? await launch(pdfURL)
        : throw 'Could not launch $pdfURL';
  }

  void _getTaskStudent(String idTask) async{
    _taskStd = await _dataRepository.getTaskStudent(idStudent: _idStudent, idTask: idTask);
    update(['taskStd']);
  }
}
