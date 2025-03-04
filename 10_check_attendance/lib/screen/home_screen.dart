import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCheckIn = false;
  bool canCheckIn = false;

  final double companyDistance = 100;

  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(37.5214, 126.924652),
    zoom: 15,
  );

  checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      throw Exception('위치 기능을 활성화 해주세요.');
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
    }

    if (checkedPermission != LocationPermission.always &&
        checkedPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한이 없습니다.');
    }
  }

  @override
  void initState() {
    super.initState();

    Geolocator.getPositionStream().listen((event) {
      final start = LatLng(37.5214, 126.924652);
      final end = LatLng(event.latitude, event.longitude);

      final distance = Geolocator.distanceBetween(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );

      setState(() {
        if (distance > companyDistance) {
          canCheckIn = false;
        } else {
          canCheckIn = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘도 출근'),
        actions: [
          IconButton(
            onPressed: handleMyLocation,
            icon: Icon(Icons.my_location),
          ),
        ],
      ),
      body: FutureBuilder(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return Column(
            children: [
              Expanded(
                flex: 3,
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    this.controller = controller;
                  },
                  initialCameraPosition: initialPosition,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  markers: {
                    Marker(
                      markerId: MarkerId('123'),
                      position: LatLng(37.5214, 126.9246),
                    ),
                  },
                  circles: {
                    Circle(
                      circleId: CircleId('inDistance'),
                      center: LatLng(37.5214, 126.9246),
                      radius: companyDistance,
                      fillColor:
                          canCheckIn
                              ? Colors.blue.withAlpha(100)
                              : Colors.red.withAlpha(100),
                      strokeColor: canCheckIn ? Colors.blue : Colors.red,
                      strokeWidth: 1,
                    ),
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isCheckIn ? Icons.check : Icons.timelapse_outlined,
                        color: isCheckIn ? Colors.green : Colors.blue,
                      ),
                      SizedBox(height: 16.0),
                      if (!isCheckIn && canCheckIn)
                        CupertinoButton(
                          onPressed: handleCheckIn,
                          child: Text(
                            '출근하기',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  late final GoogleMapController controller;

  handleMyLocation() async {
    final location = await Geolocator.getCurrentPosition();

    controller.animateCamera(
      CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude)),
    );
  }

  handleCheckIn() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니까?'),
          actions: [
            CupertinoButton(
              child: Text('취소', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            CupertinoButton(
              child: Text('승인', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (result) {
      setState(() {
        isCheckIn = true;
      });
    }
  }
}
