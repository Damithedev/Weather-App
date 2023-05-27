import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/components/locate.dart';
import 'package:weatherapp/components/weatherapi.dart';
import 'package:weatherapp/pages/home.dart';

class Loadingdetails extends StatefulWidget {
  const Loadingdetails({super.key});

  @override
  State<Loadingdetails> createState() => _LoadingdetailsState();
}

class _LoadingdetailsState extends State<Loadingdetails> {
  Position? position;
  String weatherData = "_ _";
  String location = "";
  int isday = 1;
  List<String> timeList = [];
  List<double> temperatureList = [];
  List<int> WMO = [];
  void initState() {
    super.initState();
    print("init started");
    getLocation().then((_) {
      getWeatherData().then((_) {
        getLocationName().then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainApp(
                position: position as Position,
                weatherData: weatherData,
                location: location,
                isday: isday,
                timelist: timeList,
                temperaturelist: temperatureList,
                WMO: WMO,
              ),
            ),
          );
        }).catchError((error) {
          print('Error retrieving location: $error');
        });
      }).catchError((error) {
        print('Error retrieving weather data: $error');
      });
    }).catchError((error) {
      print('Error retrieving location: $error');
    });
  }

  Future<void> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    try {
      Position? currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        position = currentPosition;
      });
      print(position);
    } catch (e) {
      // Handle location retrieval error
      throw ('Error retrieving location: $e');
    }
  }

  Future<void> getLocationName() async {
    if (position != null) {
      double latitude = position!.latitude;
      double longitude = position!.longitude;

      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);
        if (placemarks != null && placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          setState(() {
            location =
                "${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
          });
          return;
        } else {
          setState(() {
            location = "Unknown Location";
          });
        }
      } catch (e) {
        print('Error: $e');
        throw ('Error retrieving location: $e');
      }
    }
  }

  Future<void> getWeatherData() async {
    if (position != null) {
      double latitude = position!.latitude;
      double longitude = position!.longitude;

      try {
        final currentWeatherData =
            await weatherapi(long: longitude, lat: latitude)
                .getCurrenttemperature();
        final hourlyweatherdata =
            await weatherapi(long: longitude, lat: latitude).gethourlytemp();

        setState(() {
          weatherData =
              currentWeatherData['current_weather']['temperature'].toString();
          isday = currentWeatherData['current_weather']['is_day'];
          timeList = List<String>.from(hourlyweatherdata['hourly']['time']);
          WMO = List<int>.from(hourlyweatherdata['hourly']["weathercode"]);
          temperatureList =
              List<double>.from(hourlyweatherdata['hourly']['temperature_2m']);
        });
        print(weatherData);
      } catch (e) {
        // Handle weather data retrieval error
        throw ('Error retrieving weather data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Weather App",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            Lottie.asset("animation/loading.json"),
          ],
        ),
      ),
    );
  }
}
