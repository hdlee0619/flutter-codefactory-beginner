import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/model/status_model.dart';

class StatusUtils {
  static StatusModel getStatusModelFromStat({required StatModel statModel}) {
    final itemCode = statModel.itemCode;
    final index = statusLevels.indexWhere((e) {
      switch (itemCode) {
        case ItemCode.PM10:
          return statModel.stat < e.minPM10;
        case ItemCode.PM25:
          return statModel.stat < e.minPM25;
        case ItemCode.CO:
          return statModel.stat < e.minCO;
        case ItemCode.NO2:
          return statModel.stat < e.minNO2;
        case ItemCode.O3:
          return statModel.stat < e.minO3;
        case ItemCode.SO2:
          return statModel.stat < e.minSO2;
      }
    });

    if (index < 0) {
      throw Exception('통계수치에 에러가 있습니다.');
    }

    return statusLevels[index - 1];
  }
}
