import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({required ItemCode itemCode}) async {
    final itemCodeStr = itemCode == ItemCode.PM25 ? 'PM2.5' : itemCode.name;

    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            'M/eqF5D2PJkVIfZxzZVyjJpBctpYMozqI+yN+h1v+0O2MAFSKWftBPbYG59QOBQ+3HFy428jpknzPMM8PzKXyQ==',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCodeStr,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    final rawItemsList = response.data['response']['body']['items'];

    List<StatModel> stats = [];

    final List<String> skipKeys = ['dataGubun', 'dataTime', 'itemCode'];

    for (Map<String, dynamic> item in rawItemsList) {
      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final stat = double.parse(item[regionStr]);
        final region = Region.values.firstWhere((e) => e.name == regionStr);
        final dateTime = DateTime.parse(item['dataTime']);

        final statModel =
            StatModel()
              ..region = region
              ..stat = stat
              ..dateTime = dateTime
              ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        final count =
            await isar.statModels
                .filter()
                .regionEqualTo(region)
                .dateTimeEqualTo(dateTime)
                .itemCodeEqualTo(itemCode)
                .count();

        if (count > 0) {
          continue;
        }

        await isar.writeTxn(() async {
          await isar.statModels.put(statModel);
        });
      }
    }

    return stats;
  }
}
