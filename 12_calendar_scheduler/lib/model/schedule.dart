class Schedule {
  // 1) 식별 가능한 ID
  final int id;
  // 2) 시작 시간
  final int startTime;
  // 3) 종료 시간
  final int endTime;
  // 4) 내용
  final String content;
  // 5) 색상
  final String color;
  // 6) 날짜
  final DateTime date;
  // 7) 일정 생성 날짜 시간
  final DateTime createdAt;

  Schedule({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    required this.date,
    required this.createdAt,
  });
}
