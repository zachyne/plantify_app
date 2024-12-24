import 'package:plantify_app/models/soil.dart';

class Plant {
  final String plantId;
  final String plantImg;
  final String plantNameEng;
  final String plantNameTag;
  final String plantDes;
  final String plantDep;
  final String plantSpacing;
  final String plantWater;
  final String suitableSoil;

  Plant({
    required this.plantId,
    required this.plantImg,
    required this.plantNameEng,
    required this.plantNameTag,
    required this.plantDes,
    required this.plantDep,
    required this.plantSpacing,
    required this.plantWater,
    required this.suitableSoil,
  });

  factory Plant.fromCSV(List<dynamic> row) {
    return Plant(
      plantId: row[0]?.toString() ?? '',
      plantImg: 'assets/images/plants-no-bg/${row[1]?.toString() ?? ''}',
      plantNameEng: row[2]?.toString() ?? '',
      plantNameTag: row[3]?.toString() ?? '',
      plantDes: row[4]?.toString() ?? '',
      plantDep: row[5]?.toString() ?? '',
      plantSpacing: row[6]?.toString() ?? '',
      plantWater: row[7]?.toString() ?? '',
      suitableSoil: row[8]?.toString() ?? '',
    );
  }

  List<String> getSuitableSoilNames(List<Soil> soilList) {
    return suitableSoil.split(',').map((id) {
      int soilId = int.parse(id.trim());
      return soilList.firstWhere((soil) => soil.id == soilId).name;
    }).toList();
  }
}
