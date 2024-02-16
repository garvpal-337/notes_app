part of 'weather_bloc.dart';


sealed class WeatherEvent {}

class GetWeatherData extends WeatherEvent{
  String? city;
  GetWeatherData({this.city = 'delhi'});
}
