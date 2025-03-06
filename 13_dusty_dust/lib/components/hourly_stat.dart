import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/date_utils.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HourlyStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;

  const HourlyStat({
    required this.region,
    required this.darkColor,
    required this.lightColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          ItemCode.values
              .map(
                (itemCode) => FutureBuilder<List<StatModel>>(
                  future:
                      GetIt.I<Isar>().statModels
                          .filter()
                          .regionEqualTo(region)
                          .itemCodeEqualTo(itemCode)
                          .sortByDateTimeDesc()
                          .limit(24)
                          .findAll(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Center(child: Text('데이터가 없습니다'));
                    }

                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    final stats = snapshot.data!;

                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          color: lightColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    topRight: Radius.circular(16.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    '시간별 ${itemCode.krName} 통계',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              ...stats.map(
                                (stat) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 4.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${DateUtils.padInteger(number: stat.dateTime.hour)}시',
                                        ),
                                      ),
                                      Expanded(
                                        child: Image.asset(
                                          StatusUtils.getStatusModelFromStat(
                                            statModel: stat,
                                          ).imagePath,
                                          height: 20.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          StatusUtils.getStatusModelFromStat(
                                            statModel: stat,
                                          ).label,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              .toList(),
    );
  }
}
