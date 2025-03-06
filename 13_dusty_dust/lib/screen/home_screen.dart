import 'package:dusty_dust/components/category_stat.dart';
import 'package:dusty_dust/components/hourly_stat.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Region region = Region.seoul;

  @override
  void initState() {
    super.initState();

    getCount();

    StatRepository.fetchData();
  }

  getCount() async {
    print(await GetIt.I<Isar>().statModels.count());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
      future:
          GetIt.I<Isar>().statModels
              .filter()
              .regionEqualTo(region)
              .itemCodeEqualTo(ItemCode.PM10)
              .sortByDateTimeDesc()
              .findFirst(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(body: CircularProgressIndicator());
        }

        final statModel = snapshot.data!;
        final statusModel = StatusUtils.getStatusModelFromStat(
          statModel: statModel,
        );

        return Scaffold(
          drawer: Drawer(
            backgroundColor: statusModel.darkColor,
            child: ListView(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  child: Text(
                    '지역 선택',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                ...Region.values
                    .map(
                      (region) => ListTile(
                        selected: this.region == region,
                        tileColor: Colors.white,
                        selectedTileColor: statusModel.lightColor,
                        selectedColor: Colors.white,
                        onTap: () {
                          setState(() {
                            this.region = region;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text(region.krName),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: statusModel.primaryColor,
            surfaceTintColor: statusModel.primaryColor,
          ),
          backgroundColor: statusModel.primaryColor,
          body: SingleChildScrollView(
            child: FutureBuilder<List<StatModel>>(
              future: StatRepository.fetchDataByItemCode(
                itemCode: ItemCode.PM10,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                }

                return Column(
                  children: [
                    MainStat(region: region),
                    CategoryStat(
                      region: region,
                      darkColor: statusModel.darkColor,
                      lightColor: statusModel.lightColor,
                    ),
                    HourlyStat(
                      region: region,
                      darkColor: statusModel.darkColor,
                      lightColor: statusModel.lightColor,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
