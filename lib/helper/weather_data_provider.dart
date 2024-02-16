import 'dart:convert';
import 'package:notes_assignment/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider {
   Future<WeatherModel> getWeatherData(String city) async {
    try {
      final response = await  http.get(Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$city&APPID=e66b9525a392e2daa8baa8791fd00baf"));
      final weatherData = jsonDecode(response.body);
      if (weatherData['cod'] != '200') {
        throw 'somthing went wrong';
      }
      return WeatherModel.fromJson(weatherData['list'][0]);
    } catch (e) {
      throw e.toString();
    }
  }
}