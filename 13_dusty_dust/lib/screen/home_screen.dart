import 'package:dusty_dust/components/category_stat.dart';
import 'package:dusty_dust/components/hourly_stat.dart';
import 'package:dusty_dust/components/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<StatModel>>(
          future: StatRepository.fetchDataByItemCode(itemCode: ItemCode.PM10),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
            }

            return Column(
              children: [
                MainStat(region: region),
                CategoryStat(region: region),
                HourlyStat(region: region),
              ],
            );
          },
        ),
      ),
    );
  }
}
