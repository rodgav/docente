import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/auth_service.dart';
import 'package:docente/app/data/services/dialog_service.dart';
import 'package:get/get.dart';

class NewAssistanceLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final grades = ['6to B', '6to A', '5to', '4to', '3ero', '2do', '1ero'];
  String? _selectGrade;
  DocumentList? _students;

  String? get selectGrade => _selectGrade;

  DocumentList? get students => _students;

  void gradeSelect(String grade) {
    _selectGrade = grade;
    update(['grade']);
    _getStusG();
  }

  void _getStusG() async {
    _students = await _dataRepository.getStusG(grade: selectGrade ?? '');
    update(['students']);
  }

  void createAssitance(Document studentD, String tipo) async {
    if (AuthService.to.userId != null) {
      if (AuthService.to.userId == '616c934cf3ebb') {
        DialogService.to.openDialog();
        final student = await _dataRepository.createAssistance(map: {
          'idStudent': studentD.$id,
          'name': studentD.data['name'],
          'grade': studentD.data['grade'],
          'assistance': tipo,
          'date': DateTime.now().toString()
        });
        DialogService.to.closeDialog();
        if (student != null) {
          _students!.documents.removeWhere(
              (element) => element.$id == student.data['idStudent']);
          update(['students']);
        } else {
          Get.snackbar('ERROR', 'No se pudo guardar o ya tiene una asistencia');
        }
      } else {
        Get.snackbar('ERROR', 'No tienes permisos para realizar esta acción');
      }
    }
  }
}
