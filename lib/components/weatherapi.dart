import 'package:http/http.dart' as http;
import 'dart:convert';

class weatherapi {
  final double long;
  final double lat;
  weatherapi({required this.long, required this.lat});

  final url = "https://api.open-meteo.com/v1/forecast?";

  getCurrenttemperature() async {
    final response = await http.get(
        Uri.parse(url + "latitude=$lat&longitude=$long&current_weather=true"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  gethourlytemp() async {
    final response = await http.get(Uri.parse(url +
        "latitude=$lat&longitude=$long&hourly=temperature_2m&forecast_days=1&hourly=weathercode&timezone=auto"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
//"https://assets3.lottiefiles.com/packages/lf20_4yabI8pgm7.json"
//"https://assets7.lottiefiles.com/packages/lf20_K9Tklk7NSO.json",