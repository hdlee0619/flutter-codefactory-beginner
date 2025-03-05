import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
    MaterialApp(theme: ThemeData(fontFamily: 'NotoSansKR'), home: HomeScreen()),
  );
}
