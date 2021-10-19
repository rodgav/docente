import 'package:appwrite/models.dart';
import 'package:docente/app/data/repositorys/data_repository.dart';
import 'package:docente/app/data/services/auth_service.dart';
import 'package:docente/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentsLogic extends GetxController {
  final _dataRepository = Get.find<DataRepository>();

  /*final sextoB = [
    {'num': 1, 'name': 'ACSARA MAMANI KENYI FERNANDO', 'grade': '6to B'},
    {'num': 2, 'name': 'CARI ESPINOZA JHERAL JOSUE', 'grade': '6to B'},
    {'num': 3, 'name': 'CCAHUANTICO MAMANI VALERIA LISBETH', 'grade': '6to B'},
    {'num': 4, 'name': 'CHAIÑA ARENAS ANGIE DAYANNA SONIA', 'grade': '6to B'},
    {'num': 5, 'name': 'CHEVARRIA FLORES ARIANA YULEISY', 'grade': '6to B'},
    {'num': 6, 'name': 'CHURA ZEVALLOS CRISTHIAN YHEYSON', 'grade': '6to B'},
    {'num': 7, 'name': 'COLQUEHUANCA QUISPE YOSELIN MAYUMI', 'grade': '6to B'},
    {'num': 8, 'name': 'CUTISACA CANAZA ELESLY CAMILA', 'grade': '6to B'},
    {'num': 9, 'name': 'FLORES VARGAS LIAN JOSIAS', 'grade': '6to B'},
    {'num': 10, 'name': 'HIRPANOCA CORONEL REIK LERNER', 'grade': '6to B'},
    {'num': 11, 'name': 'HUACANI QUISPE MISHEL FANY', 'grade': '6to B'},
    {'num': 12, 'name': 'HUAYTA CHURQUIPA EDITH KATERIN', 'grade': '6to B'},
    {'num': 13, 'name': 'LIZARRAGA MULLISACA AYMER EMERSON', 'grade': '6to B'},
    {'num': 14, 'name': 'MAMANI LLANQUI JOSUE FERNANDO', 'grade': '6to B'},
    {'num': 15, 'name': 'MAMANI MONZON ALDAIR BRANDON', 'grade': '6to B'},
    {'num': 16, 'name': 'MAYTA PABLO CYNTHIA STEPHANIE', 'grade': '6to B'},
    {'num': 17, 'name': 'MIRANDA VALERO VIVIAN MELANY', 'grade': '6to B'},
    {'num': 18, 'name': 'PACORI HUAMAN DANA FERNANDA', 'grade': '6to B'},
    {'num': 19, 'name': 'QUISPE YUCRA PHOOL MAYCKEL', 'grade': '6to B'},
    {'num': 20, 'name': 'ROSAS BACA EMILIE MICHELLE', 'grade': '6to B'},
    {'num': 21, 'name': 'TOLA GOMEZ BRANDO AARON', 'grade': '6to B'},
    {'num': 22, 'name': 'VALVERDE SUPO LUZ MARIA DEL PILAR', 'grade': '6to B'}
  ];
  final sextoA = [
    {'num': 1, 'name': 'ALEJO HUMPIRI CRISTIAN SMITH', 'grade': '6to A'},
    {'num': 2, 'name': 'ALVAREZ MARCELO LUCIANA CANDY', 'grade': '6to A'},
    {'num': 3, 'name': 'BERNEDO OVALLE KATHERIN LOURDES', 'grade': '6to A'},
    {'num': 4, 'name': 'CCASO MACHACA ANGHELY NATHANYL', 'grade': '6to A'},
    {'num': 5, 'name': 'CHURA COAQUIRA DAYRA JIMENA', 'grade': '6to A'},
    {'num': 6, 'name': 'CONDORI GONZALO GABRIEL SANTIAGO', 'grade': '6to A'},
    {'num': 7, 'name': 'FLORES ALIAGA LUIS MIGUEL', 'grade': '6to A'},
    {'num': 8, 'name': 'HUANCA CHUQUIHUARA SUNMY CAMILA', 'grade': '6to A'},
    {'num': 9, 'name': 'HUARACHI HUALLA JOHANA ABIGAIL', 'grade': '6to A'},
    {'num': 10, 'name': 'LIMA ANTESANA ESTHER CECILIA', 'grade': '6to A'},
    {'num': 11, 'name': 'MACEDO COAQUIRA JHOSTYN', 'grade': '6to A'},
    {'num': 12, 'name': 'MAMANI GOMEZ JESUS LEONARDO', 'grade': '6to A'},
    {'num': 13, 'name': 'MAYTA TURPO ELISBAN DUSTIN', 'grade': '6to A'},
    {'num': 14, 'name': 'MOLINA LEON ANGÉLICA VICTORIA', 'grade': '6to A'},
    {'num': 15, 'name': 'PILCO TIPULA NICK SALVADOR', 'grade': '6to A'},
    {'num': 16, 'name': 'PORTILLO RUELAS GISELL MILAGROS', 'grade': '6to A'},
    {'num': 17, 'name': 'PURACA VILCA MARC ANDRES', 'grade': '6to A'},
    {'num': 18, 'name': 'RAMOS CONDORI MIJAIL NOVAK', 'grade': '6to A'},
    {'num': 19, 'name': 'SALAS ESPINOZA YARO RADMAN', 'grade': '6to A'},
    {'num': 20, 'name': 'YANA NEGRETE ROUSS DAHYRA MILAGROS', 'grade': '6to A'},
    {'num': 21, 'name': 'YANA QUISPE AIME ANALIA', 'grade': '6to A'}
  ];
  final quinto = [
    {'num': 1, 'name': 'AGUILAR YUCRA ANDY DAYRON', 'grade': '5to'},
    {'num': 2, 'name': 'ALVAREZ ROSELLO GREYSS ROSARIO', 'grade': '5to'},
    {'num': 3, 'name': 'APAZA QUISPE ANGELES DEL CIELO', 'grade': '5to'},
    {'num': 4, 'name': 'BERNEDO OVALLE RODRIGO RICARDO', 'grade': '5to'},
    {'num': 5, 'name': 'CATACORA QUISPE YOSMEL SAMIR', 'grade': '5to'},
    {'num': 6, 'name': 'CCAHUANA QUISPE NEIL BRANKO', 'grade': '5to'},
    {'num': 7, 'name': 'CHAMBI CUTIPA ENZO ANDERSON', 'grade': '5to'},
    {'num': 8, 'name': 'CHARCA MULLISACA GABRIEL ANTONY', 'grade': '5to'},
    {'num': 9, 'name': 'CHOQUE CUNO JUSTIN AIMAR BECKHAM', 'grade': '5to'},
    {'num': 10, 'name': 'CHUQUICALLATA COLCA EBERNI FRAY', 'grade': '5to'},
    {'num': 11, 'name': 'CHUQUIJA POMARI LEIDY ORIANA', 'grade': '5to'},
    {'num': 12, 'name': 'CHUQUIMAMANI CHARCA DAYRO LEONNEL', 'grade': '5to'},
    {'num': 13, 'name': 'CONDORI RAMIREZ ABIGAIL MARGOT', 'grade': '5to'},
    {'num': 14, 'name': 'FLORES QUISPE SASHA KHALED', 'grade': '5to'},
    {'num': 15, 'name': 'LEON CONDORI MAURO ENRIQUE MIGUEL', 'grade': '5to'},
    {'num': 16, 'name': 'LIMA FLORES LEYLI ROSARIO', 'grade': '5to'},
    {'num': 17, 'name': 'LIVISI PACSI FRANK LUY', 'grade': '5to'},
    {'num': 18, 'name': 'MAMANI CHATA DIEGO ALESSANDRO', 'grade': '5to'},
    {'num': 19, 'name': 'MAMANI PARI JHOSMELL JHOSEMIR FREDDY', 'grade': '5to'},
    {'num': 20, 'name': 'MENDOZA SONCO DEMIAN REY YADIR', 'grade': '5to'},
    {'num': 21, 'name': 'MULLISACA CUTIPA ANNGUI JHAN YHONSU', 'grade': '5to'},
    {'num': 22, 'name': 'OCORURO CCOSI MELINA NICOLE', 'grade': '5to'},
    {'num': 23, 'name': 'ORTEGA ROMERO JADE YAJAYDA', 'grade': '5to'},
    {'num': 24, 'name': 'PACORI GUZMAN EDDIE JHOSEP', 'grade': '5to'},
    {'num': 25, 'name': 'PAUCAR PAJA CAMILA JAZMIN', 'grade': '5to'},
    {'num': 26, 'name': 'QUICO APAZA DULCE GABRIELA', 'grade': '5to'},
    {'num': 27, 'name': 'QUISPE ALIAGA JHON ANDERSON', 'grade': '5to'},
    {'num': 28, 'name': 'QUISPE MERMA JHEYSON DENNYS', 'grade': '5to'},
    {'num': 29, 'name': 'QUISPE PUMA DANNA VALENTINA', 'grade': '5to'},
    {'num': 30, 'name': 'RAMOS PORTUGAL JHOSTIN WILLIAMS', 'grade': '5to'},
    {'num': 31, 'name': 'SANCA CAUNA KIARA NATHANIEL', 'grade': '5to'},
    {'num': 32, 'name': 'TICONA NEYRA ILLARI ARIADNA', 'grade': '5to'},
    {'num': 33, 'name': 'UCHAMACO AGUILAR ADANA MAYUMI', 'grade': '5to'},
    {'num': 34, 'name': 'VELARDE CALSIN RODRIGO ANTONIO', 'grade': '5to'}
  ];
  final cuarto = [
    {'num': 1, 'name': 'APAZA TAIPE JUNIOR DELFREDY', 'grade': '4to'},
    {'num': 2, 'name': 'ARNAO COLQUE ANA SUSAN', 'grade': '4to'},
    {'num': 3, 'name': 'AYALA ALFERES AXEL DAYRO', 'grade': '4to'},
    {'num': 4, 'name': 'CALSINA COAQUIRA ADEL RANDY', 'grade': '4to'},
    {'num': 5, 'name': 'CATACORA CHAMA ARON PERCY', 'grade': '4to'},
    {'num': 6, 'name': 'CHAIÑA ARENAS BRHITTNY NICOLE', 'grade': '4to'},
    {'num': 7, 'name': 'CHURA CABANA MAYKEL NEYMAR', 'grade': '4to'},
    {'num': 8, 'name': 'CHURA CALSIN YUMITA KEY', 'grade': '4to'},
    {'num': 9, 'name': 'CONDORI ITO PIERO ALBERT', 'grade': '4to'},
    {'num': 10, 'name': 'FLORES BARRIENTOS ABRIL', 'grade': '4to'},
    {'num': 11, 'name': 'FLORES BARRIENTOS LIBERTAD', 'grade': '4to'},
    {'num': 12, 'name': 'GUILLERMO MERCADO DANAE BAYOLET', 'grade': '4to'},
    {'num': 13, 'name': 'HUAYTA ZEA CLAUDIO SEBASTIAN', 'grade': '4to'},
    {'num': 14, 'name': 'HUISA AQUISE GABRIEL DAMIAN', 'grade': '4to'},
    {'num': 15, 'name': 'LAURA MAMANI ALISSON MILAGROS', 'grade': '4to'},
    {'num': 16, 'name': 'LAZO MBELLIDO ANGIELY', 'grade': '4to'},
    {'num': 17, 'name': 'LIZARRAGA SONCCO MAYELY GIMENA', 'grade': '4to'},
    {'num': 18, 'name': 'MAMANI CUTIPA ALISSON ALEXANDRA', 'grade': '4to'},
    {'num': 19, 'name': 'MAMANI MACHACA KEVIN PATRICK', 'grade': '4to'},
    {'num': 20, 'name': 'MERCADO PARI EPRIL YHAJAIRA', 'grade': '4to'},
    {'num': 21, 'name': 'MORALES APAZA JOSEPH ABNER', 'grade': '4to'},
    {'num': 22, 'name': 'MORALES RAMOS CAMILA CRISTEL', 'grade': '4to'},
    {'num': 23, 'name': 'OCHOCHOQUE MAMANI SOL AMEERA', 'grade': '4to'},
    {'num': 24, 'name': 'PACARA JARA WALDO EMMANUEL', 'grade': '4to'},
    {'num': 25, 'name': 'PAUCAR CCASA ANDREA LETICIA', 'grade': '4to'},
    {'num': 26, 'name': 'PAXI ROJAS ANTUANETH FERNANDA', 'grade': '4to'},
    {'num': 27, 'name': 'PERALTA TIPULA CARLOS GUSTAVO', 'grade': '4to'},
    {'num': 28, 'name': 'QUENAYA YTO ZAYDA MARISIEL', 'grade': '4to'},
    {'num': 29, 'name': 'QUISPE MAMANI DARLYNE NICOLL', 'grade': '4to'},
    {'num': 30, 'name': 'RAMOS TICONA ISAIME DANIELA', 'grade': '4to'},
    {'num': 31, 'name': 'ROJAS RAMOS HARLI ALROAL', 'grade': '4to'},
    {'num': 32, 'name': 'SARCCO QUISPE DANNARY ROUSH', 'grade': '4to'},
    {'num': 33, 'name': 'TIPULA MAMANI ESTEFANY PAOLA', 'grade': '4to'},
    {'num': 34, 'name': 'VILLAVICENCIO GALES CÁLEB JOSE', 'grade': '4to'},
  ];
  final tercero = [
    {'num': 1, 'name': 'APAZA CCASO HENDRIX BRANDY', 'grade': '3ero'},
    {'num': 2, 'name': 'APAZA QUISPE HELEN ESTHEFANNY ARIANA', 'grade': '3ero'},
    {'num': 3, 'name': 'AYAMAMANI CORIMAYHUA KARIM RIBÉRY', 'grade': '3ero'},
    {'num': 4, 'name': 'CCOYA MAMANI ANGELO MILAN', 'grade': '3ero'},
    {'num': 5, 'name': 'CHAMBI MAMANI EMILY JHERALDINE', 'grade': '3ero'},
    {'num': 6, 'name': 'CHAVEZ YUCRA JOSUE CALEB', 'grade': '3ero'},
    {'num': 7, 'name': 'CHOQUECHAMBI YANAPA MATHIAS ANGEL', 'grade': '3ero'},
    {'num': 8, 'name': 'CHURA FRISANCHO ERWIN DOMINIG', 'grade': '3ero'},
    {'num': 9, 'name': 'CILCAPAZA CCALLO JOSE FERNANDO', 'grade': '3ero'},
    {'num': 10, 'name': 'CORNEJO QUISPE ESMERALDA SOLEDAD', 'grade': '3ero'},
    {'num': 11, 'name': 'CRUZ PARICAHUA JAIRO SINOÉ', 'grade': '3ero'},
    {'num': 12, 'name': 'FLORES GUEVARA EDUARDO RASEC', 'grade': '3ero'},
    {'num': 13, 'name': 'GONZALES SUCARI MILAGROS YANETH', 'grade': '3ero'},
    {'num': 14, 'name': 'HUALLPA MARROQUIN SULLY NATANYEL', 'grade': '3ero'},
    {'num': 15, 'name': 'LARICO LAURA JHANDY ABIGAIL', 'grade': '3ero'},
    {'num': 16, 'name': 'MAMANI ORTIZ SOFIA NICOLLE', 'grade': '3ero'},
    {'num': 17, 'name': 'MAMANI RIOS ALEXANDRA MILAGROS', 'grade': '3ero'},
    {'num': 18, 'name': 'MENDOZA CATACORA WILIAM GUSTAVO', 'grade': '3ero'},
    {'num': 19, 'name': 'MERMA MAMANI DAYLIN FABIANNE', 'grade': '3ero'},
    {'num': 20, 'name': 'MONRROY CAHUAPAZA ANGHELY NAYELHY', 'grade': '3ero'},
    {'num': 21, 'name': 'MONTESINOS SONCCO ALIMS ABDIEL', 'grade': '3ero'},
    {'num': 22, 'name': 'MULLISACA MAMANI CAMILA ABIGAIL', 'grade': '3ero'},
    {'num': 23, 'name': 'MULLISACA QUEA AXEL REYMOND', 'grade': '3ero'},
    {'num': 24, 'name': 'QUILLA CARCAUSTO DAVID DORIANN', 'grade': '3ero'},
    {'num': 25, 'name': 'QUISPE COAQUIRA ANGIE NIKOL', 'grade': '3ero'},
    {'num': 26, 'name': 'QUISPE TACO VALERY FERNANDA', 'grade': '3ero'},
    {'num': 27, 'name': 'QUISPE YUCRA BRITANI ELORIAM', 'grade': '3ero'},
    {'num': 28, 'name': 'SANCA QUISPE PAULA VALENTINA', 'grade': '3ero'},
    {'num': 29, 'name': 'TOLA GOMEZ JADEL JOAQUIN', 'grade': '3ero'},
    {'num': 30, 'name': 'VILLASANTE PURACA JEREMY SAMUEL', 'grade': '3ero'},
    {'num': 31, 'name': 'YANA RUELAS SHEYLA NADINE', 'grade': '3ero'},
    {'num': 32, 'name': 'YAULI ROQUE ESCARLETD ANYELI', 'grade': '3ero'},
    {'num': 33, 'name': 'YERBA MERCADO MAGDIEL ESTRELLA', 'grade': '3ero'},
    {'num': 34, 'name': 'ZARATE TAPARA JHORDANS JOSUE', 'grade': '3ero'},
  ];
  final segundo = [
    {'num': 1, 'name': 'CABANA HUALLA NATALY GIULIANA', 'grade': '2do'},
    {'num': 2, 'name': 'CACERES QUISPE BRITNEY DAYANA', 'grade': '2do'},
    {'num': 3, 'name': 'CAHUAPAZA YUPA YAJAIRA KAMIL', 'grade': '2do'},
    {
      'num': 4,
      'name': 'CHAVEZ AMESQUITA NAYARA ABIGAIL DEL ROSARIO',
      'grade': '2do'
    },
    {'num': 5, 'name': 'CHAVEZ CARRION GOLDY MAYLIN', 'grade': '2do'},
    {'num': 6, 'name': 'CONDORI CALLA GERALD THIAGO', 'grade': '2do'},
    {'num': 7, 'name': 'CRUZ CERPA ALLISON DANNA', 'grade': '2do'},
    {
      'num': 8,
      'name': 'LIZARRAGA MULLISACA FERNANDO NEYMAR MILAN',
      'grade': '2do'
    },
    {'num': 9, 'name': 'LIZARRAGA SONCCO DEYVIS GUILLERMO', 'grade': '2do'},
    {'num': 10, 'name': 'MAMANI COLQUE JOSE GABRIEL', 'grade': '2do'},
    {'num': 11, 'name': 'MAMANI PILCO BRYAN DAYRON', 'grade': '2do'},
    {'num': 12, 'name': 'MANSILLA RAMOS MATHIUS EDU', 'grade': '2do'},
    {'num': 13, 'name': 'MENDOZA RAMIREZ CARLOS ADRIANO', 'grade': '2do'},
    {'num': 14, 'name': 'MULLISACA MAMANI FERNANDA DAMARIS', 'grade': '2do'},
    {'num': 15, 'name': 'PURACA VILCA DAYRO JULIAN', 'grade': '2do'},
    {'num': 16, 'name': 'QUISPE MERMA JOSHIMAR THIAGO', 'grade': '2do'},
    {'num': 17, 'name': 'SALAS BALLEJOS SHAYNE BRITHANY', 'grade': '2do'},
    {'num': 18, 'name': 'TISNADO BARRIOS MAYRA ABIGAIL', 'grade': '2do'},
    {'num': 19, 'name': 'TORRES PACSI DHAYRON YORD', 'grade': '2do'}
  ];

  final primero = [
    {'num': 1, 'name': 'ACSARA MAMANI SHAMELY', 'grade': '1ero'},
    {'num': 2, 'name': 'AGUILAR CONDORI CRISLIAN GABRIELA', 'grade': '1ero'},
    {'num': 3, 'name': 'AGUILAR YUCRA ABY ENYD', 'grade': '1ero'},
    {'num': 4, 'name': 'CARI ESPINOZA JHOSEP ANDRE', 'grade': '1ero'},
    {'num': 5, 'name': 'CHAMBI YERBA LIANA DANAE', 'grade': '1ero'},
    {'num': 6, 'name': 'CHOQUEHUANCA CASTILLO THIAGO JOSUÉ', 'grade': '1ero'},
    {'num': 7, 'name': 'CHURA ZEVALLOS ANDY LIONEL', 'grade': '1ero'},
    {'num': 8, 'name': 'CONDORI APAZA EDDY LIHAN', 'grade': '1ero'},
    {'num': 9, 'name': 'CONDORI CHAYÑA DANIEL ALESSANDRO', 'grade': '1ero'},
    {'num': 10, 'name': 'CONDORI PACO NAYDELY JOHANA', 'grade': '1ero'},
    {'num': 11, 'name': 'GUEVARA ROQUE JUAN PABLO DAMIAN', 'grade': '1ero'},
    {'num': 12, 'name': 'HUANCCO MAMANI JOSHUA JAVIER', 'grade': '1ero'},
    {'num': 13, 'name': 'LOPEZ QUISPE NIKOOL ROMINA', 'grade': '1ero'},
    {'num': 14, 'name': 'MAMANI CUTIPA JHULIA ALEXA', 'grade': '1ero'},
    {'num': 15, 'name': 'MOROCCO COAQUIRA JOAQUIN GABRIEL', 'grade': '1ero'},
    {'num': 16, 'name': 'PACORI HUAMAN MIGUEL STIFF', 'grade': '1ero'},
    {'num': 17, 'name': 'QUISPE APAZA RONALD JUNIOR', 'grade': '1ero'},
    {'num': 18, 'name': 'RAMOS TURPO HEIDY XHIOMARA', 'grade': '1ero'},
    {'num': 19, 'name': 'RODRIGUEZ SUAREZ JOORGE ANDREY', 'grade': '1ero'},
    {'num': 20, 'name': 'ROJAS RAMOS XAVI RAUL', 'grade': '1ero'},
    {'num': 21, 'name': 'SOTO ALIAGA ANGIE GINEBRA', 'grade': '1ero'},
    {'num': 22, 'name': 'TICONA NEYRA JEICOB RASEC', 'grade': '1ero'},
    {'num': 23, 'name': 'VILCA YANAPA LUANA IVETT', 'grade': '1ero'},
    {'num': 24, 'name': 'YUJRA APAZA ITZEL BRIANA', 'grade': '1ero'},
    {'num': 25, 'name': 'ZARATE PACSI JAIRO AMIR', 'grade': '1ero'},
    {'num': 26, 'name': 'ZEA CHARCA ANYELA ABRIL', 'grade': '1ero'},
    {'num': 27, 'name': 'ZELA YUPANQUI MILAN NAYMAR', 'grade': '1ero'}
  ];*/
  final TextEditingController searchCtrl = TextEditingController();
  Document? _student;

  Document? get student => _student;

  /* void createStudent() async {
    for (var element in primero) {
      await _dataRepository.createStudent(map: element);
    }
  }*/

  void search() async {
    _student = await _dataRepository.getStusN(
        name: searchCtrl.text.trim().toUpperCase());
    update(['student']);
    /*debugPrint('stdtsn sum ${stdtsn.sum}');
    debugPrint('stdtsn name ${stdtsn.documents[0].data['name']}');
    final stdts = await _dataRepository.getStus(grade: '5to');
    debugPrint('stdts sum ${stdts.sum}');
    debugPrint('stdts name ${stdts.documents[0].data['name']}');*/
  }

  void goQualifications(String idStudent) {
    Get.rootDelegate.toNamed(Routes.qualifications(idStudent));
  }

  void goTasks(String idStudent) {
    Get.rootDelegate.toNamed(Routes.tasks(idStudent));
  }

  void goAssistances(String idStudent) {
    Get.rootDelegate.toNamed(Routes.assistances(idStudent));
  }
}
