import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MainApp extends StatefulWidget {
  final int isday;
  final String location;
  final Position position;
  final String weatherData;
  final List<String> timelist;
  final List<double> temperaturelist;
  final List<int> WMO;
  const MainApp({
    Key? key,
    required this.isday,
    required this.location,
    required this.position,
    required this.weatherData,
    required this.timelist,
    required this.temperaturelist,
    required this.WMO,
  }) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('HH:00').format(now);
    print(currentTime);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: FractionallySizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 520,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: widget.isday == 1
                          ? Image.asset(
                              'images/day.jpg',
                              fit: BoxFit.cover,
                            )
                          : Lottie.asset(
                              'animation/night.json',
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 24,
                              color: widget.isday == 1
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.weatherData,
                                  style: TextStyle(
                                    fontSize: 37,
                                    color: widget.isday == 1
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: widget.isday == 1
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Today",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        "7 days >",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: widget.temperaturelist.length,
                    itemBuilder: (context, index) {
                      String img = "";
                      switch (widget.WMO[index]) {
                        case 0:
                          img = "WMO/0.png";
                          break;
                        case 1:
                        case 3:
                          img = "WMO/1_3.png";
                          break;
                        case 2:
                        case 45:
                        case 48:
                          img = "WMO/2_45_48.png";
                          break;
                        case 51:
                        case 53:
                          img = "WMO/51_53.png";
                          break;
                        case 55:
                        case 56:
                        case 57:
                          img = "WMO/55_56_57.png";
                          break;
                        case 61:
                        case 63:
                        case 66:
                        case 80:
                        case 81:
                          img = "WMO/61_63_66_80_81.png";
                          break;
                        case 65:
                        case 67:
                        case 82:
                          img = "WMO/65_67_82.png";
                          break;
                        case 71:
                        case 73:
                        case 75:
                        case 77:
                        case 85:
                        case 86:
                          img = "WMO/71_73_75_77_85_86.png";
                          break;
                        case 80:
                        case 81:
                        case 82:
                          img = "WMO/80_81_82.png";
                          break;
                        case 95:
                          img = "WMO/95.png";
                          break;
                        case 96:
                        case 99:
                          img = "WMO/96_99.png";
                          break;
                        default:
                          img =
                              ""; // Default image link if none of the cases match
                          break;
                      }

                      String timedate = widget.timelist[index];
                      String time = timedate.substring(timedate.length - 5);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 70,
                          decoration: BoxDecoration(
                            color: currentTime == time
                                ? Colors.blueAccent
                                : Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            children: [
                              Text(time),
                              Flexible(child: Image.asset(img)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${widget.temperaturelist[index]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
