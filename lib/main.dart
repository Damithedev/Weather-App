import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'components/weatherapi.dart';
import 'package:lottie/lottie.dart';
import 'package:geocoding/geocoding.dart';
import 'pages/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Loadingdetails(),
  ));
}
