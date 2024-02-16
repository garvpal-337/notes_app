part of 'weather_bloc.dart';


sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class LoadingWeatherData extends WeatherState{}


final class FailedToGetWeatherData extends WeatherState{
  String error;
  FailedToGetWeatherData(this.error);
}


final class SucceccToGetWeatherData extends WeatherState{
  WeatherModel weatherData;
  SucceccToGetWeatherData(this.weatherData);
}
