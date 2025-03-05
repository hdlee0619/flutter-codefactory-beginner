enum Region {
  seoul,
  busan,
  daegu,
  incheon,
  gwangju,
  daejeon,
  ulsan,
  sejong,
  gyeonggi,
  gangwon,
  chungbuk,
  chungnam,
  jeonbuk,
  jeonnam,
  gyeongbuk,
  gyeongnam,
  jeju;

  String get krName {
    switch (this) {
      case Region.seoul:
        return '서울';
      case Region.busan:
        return '부산';
      case Region.daegu:
        return '대구';
      case Region.incheon:
        return '인천';
      case Region.gwangju:
        return '광주';
      case Region.daejeon:
        return '대전';
      case Region.ulsan:
        return '울산';
      case Region.sejong:
        return '세종';
      case Region.gyeonggi:
        return '경기';
      case Region.gangwon:
        return '강원';
      case Region.chungbuk:
        return '충북';
      case Region.chungnam:
        return '충남';
      case Region.jeonbuk:
        return '전북';
      case Region.jeonnam:
        return '전남';
      case Region.gyeongbuk:
        return '경북';
      case Region.gyeongnam:
        return '경남';
      case Region.jeju:
        return '제주';
    }
  }
}

enum ItemCode {
  SO2,
  CO,
  O3,
  NO2,
  PM10,
  PM25;

  String get krName {
    switch (this) {
      case ItemCode.SO2:
        return '이황산가스';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
    }
  }
}

class StatModel {
  // 지역
  final Region region;

  // 통계값
  final double stat;

  // 날짜
  final DateTime dateTime;

  // 미세먼지 / 초미세먼지
  final ItemCode itemCode;

  StatModel({
    required this.region,
    required this.stat,
    required this.dateTime,
    required this.itemCode,
  });
}
