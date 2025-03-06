# 📌 플러터 프로젝트

코드팩토리 강의를 통해 다양한 프로젝트를 진행하며 플러터를 배울 수 있었습니다. 각 프로젝트별로 배웠던 주요 기능과 사용한 패키지를 정리하였습니다.

## 4. Web View 프로젝트

### 🖼️ 화면
<img src="https://i.imgur.com/blU60jS.png" height="700"/>

### ✨ 주요 기능
- `webview_flutter: ^4.10.0` 패키지를 활용하여 웹사이트를 앱 내에서 표시
    
- 개인 블로그를 앱 화면에서 띄우는 기능 구현

## 6. Image Carousel 프로젝트

### 🖼️ 화면
![](https://i.imgur.com/0XiTJfL.gif)

### ✨ 주요 기능
- `PageView()` 및 `PageController()`를 활용하여 이미지 슬라이더 구현
- `Duration`을 활용한 자동 넘김 기능 추가

## 7. U And I 프로젝트

### 🖼️ 화면
<img src="https://i.imgur.com/oI0g173.png" height="700"/>

### ✨ 주요 기능
- 다양한 폰트 등록 및 적용
- `ThemeData()`를 활용한 공통 `TextStyle()` 정의
- `CupertinoDatePicker()`를 활용하여 날짜 선택 및 사귄 날 계산 기능 구현

## 8. Random Number 프로젝트

### 🖼️ 화면
![](https://i.imgur.com/Tgh3hjp.gif)

### ✨ 주요 기능
- `Slider()`를 활용하여 랜덤 숫자의 최대 범위 지정
- 랜덤 숫자 3개를 생성하고, 해당 숫자에 매핑된 이미지 표시

## 9. Video Player 프로젝트
### 🖼️ 화면
![](https://i.imgur.com/fRDwJhk.png)

### ✨ 주요 기능
- `video_player: ^2.9.3`와 `image_picker: ^1.1.2`를 활용하여 비디오 선택 및 재생 기능 구현
- `videoPlayerController`를 이용한 비디오 제어 기능 추가

## 10. Check Attendance 프로젝트

### 🖼️ 화면
![](https://i.imgur.com/7MotmLP.png)

### ✨ 주요 기능
- `google_maps_flutter: ^2.10.1`, `geolocator: ^13.0.2`를 활용한 기기 위치 추적
- 특정 지역 도착 시 출석 체크 활성화 기능 구현

## 11. Video Call 프로젝트

### 🖼️ 화면
![](https://i.imgur.com/8ZeQOFr.png)

### ✨ 주요 기능
- `agora_rtc_engine: ^6.3.0`, `permission_handler: ^11.4.0`을 활용한 영상 통화 기능 구현
- Agora 서버와 연결하여 실시간 화상 통화 제공

## 12. Calender Scheduler 프로젝트

### 🖼️ 화면
![](https://i.imgur.com/cJCzGbl.png)

### ✨ 주요 기능
- `drift`와 SQLite를 활용하여 로컬 일정 저장 기능 구현
- `get_it`을 활용한 DI 적용으로 전역 접근성 강화
- `intl`을 활용하여 `table_calendar`의 한국어 지원 적용

### 📦 사용한 패키지
```yaml
dpendencies:
  table_calendar: ^3.2.0
  intl: ^0.20.2
  drift: ^2.16.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.0.0
  path: ^1.9.0
  get_it: ^8.0.3
dev_dependencies:
  flutter_lints: ^5.0.0
  drift_dev: ^2.16.2
  build_runner: ^2.4.8
```

## 13. Dusty Dust 프로젝트

### 🖼️ 화면
![](https://i.imgur.com/rAQt4t6.png)

### ✨ 주요 기능
- 한국환경공단 API를 활용하여 시도별 대기오염 통계 데이터 제공
- `dio`를 활용한 HTTP 통신 및 API 데이터 처리
- `isar`를 활용한 NoSQL 데이터 저장 및 중복 요청 방지

### 📦 사용한 패키지
```yaml
dependencies:
  dio: ^5.8.0+1
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5
  get_it: ^8.0.3
dev_dependencies:
  isar_generator: ^3.1.0+1
  build_runner: ^2.4.13
```
