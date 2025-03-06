import 'package:dusty_dust/model/status_model.dart';
import 'package:flutter/material.dart';

const statusLevels = [
  StatusModel(
    level: 0,
    label: '최고',
    primaryColor: Color(0xFF2196F3),
    darkColor: Color(0xFF0069C0),
    lightColor: Color(0xFF6EC6FF),
    fontColor: Colors.black,
    imagePath: 'assets/images/best.png',
    comment: '우와! 100년에 한번 오는날!',
    minPM10: 0,
    minPM25: 0,
    minO3: 0,
    minNO2: 0,
    minCO: 0,
    minSO2: 0,
  ),
  StatusModel(
    level: 1,
    label: '좋음',
    primaryColor: Color(0xFF03a9f4),
    darkColor: Color(0xFF007ac1),
    lightColor: Color(0xFF67daff),
    fontColor: Colors.black,
    imagePath: 'assets/images/good.png',
    comment: '공기가 좋아요! 외부활동 해도 좋아요!',
    minPM10: 16,
    minPM25: 9,
    minO3: 0.02,
    minNO2: 0.02,
    minCO: 1,
    minSO2: 0.01,
  ),
  StatusModel(
    level: 2,
    label: '양호',
    primaryColor: Color(0xFF00bcd4),
    darkColor: Color(0xFF008ba3),
    lightColor: Color(0xFF62efff),
    fontColor: Colors.black,
    imagePath: 'assets/images/ok.png',
    comment: '공기가 좋은 날이예요!',
    minPM10: 31,
    minPM25: 16,
    minO3: 0.03,
    minNO2: 0.03,
    minCO: 2,
    minSO2: 0.02,
  ),
  StatusModel(
    level: 3,
    label: '보통',
    primaryColor: Color(0xFF009688),
    darkColor: Color(0xFF00675b),
    lightColor: Color(0xFF52c7b8),
    fontColor: Colors.black,
    imagePath: 'assets/images/mediocre.png',
    comment: '나쁘지 않네요!',
    minPM10: 41,
    minPM25: 21,
    minO3: 0.06,
    minNO2: 0.05,
    minCO: 5.5,
    minSO2: 0.04,
  ),
  StatusModel(
    level: 4,
    label: '나쁨',
    primaryColor: Color(0xFFffc107),
    darkColor: Color(0xFFc79100),
    lightColor: Color(0xFFfff350),
    fontColor: Colors.black,
    imagePath: 'assets/images/bad.png',
    comment: '공기가 안좋아요...',
    minPM10: 51,
    minPM25: 26,
    minO3: 0.09,
    minNO2: 0.06,
    minCO: 9,
    minSO2: 0.05,
  ),
  StatusModel(
    level: 5,
    label: '상당히 나쁨',
    primaryColor: Color(0xFFff9800),
    darkColor: Color(0xFFc66900),
    lightColor: Color(0xFFffc947),
    fontColor: Colors.black,
    imagePath: 'assets/images/very_bad.png',
    comment: '공기가 나빠요! 외부활동을 자제해주세요!',
    minPM10: 76,
    minPM25: 38,
    minO3: 0.12,
    minNO2: 0.13,
    minCO: 12,
    minSO2: 0.1,
  ),
  StatusModel(
    level: 6,
    label: '매우 나쁨',
    primaryColor: Color(0xFFf44336),
    darkColor: Color(0xFFba000d),
    lightColor: Color(0xFFff7961),
    fontColor: Colors.black,
    imagePath: 'assets/images/worse.png',
    comment: '매우 안좋아요! 나가지 마세요!',
    minPM10: 101,
    minPM25: 51,
    minO3: 0.15,
    minNO2: 0.2,
    minCO: 15,
    minSO2: 0.15,
  ),
  StatusModel(
    level: 7,
    label: '최악',
    primaryColor: Color(0xFF212121),
    darkColor: Color(0xFF000000),
    lightColor: Color(0xFF484848),
    fontColor: Colors.white,
    imagePath: 'assets/images/worst.png',
    comment: '역대급 최악의날! 집에만 계세요!',
    minPM10: 151,
    minPM25: 76,
    minO3: 0.38,
    minNO2: 1.1,
    minCO: 32,
    minSO2: 0.16,
  ),
];
