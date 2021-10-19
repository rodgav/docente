import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:get/get.dart';

class AssistancesLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();
  final String _idStudent;

  AssistancesLogic(this._idStudent);

  Document? _student;
  DocumentList? _assistances;

  Document? get student => _student;

  DocumentList? get assistances => _assistances;

  @override
  void onReady() {
    _getStudent();
    super.onReady();
  }

  void _getStudent() async {
    _student = await _dataRepository.getStud(idStudent: _idStudent);
    update(['student']);
    _getAssistances(_idStudent);
  }

  void _getAssistances(String idStudent) async {
    _assistances = await _dataRepository.getAssitances(idStudent: idStudent);
    update(['assistances']);
  }
}
