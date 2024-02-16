class WeatherModel {
  dynamic currentTemperature;
  String? currentSky;
  dynamic currentPressure;
  dynamic currentWindSpeed;
  dynamic currentHumidity;

  WeatherModel(
      {this.currentTemperature,
      this.currentSky,
      this.currentPressure,
      this.currentWindSpeed,
      this.currentHumidity});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    currentTemperature = json['main']['temp'];
    currentSky = json['weather'][0]['main'];
    currentPressure = json['main']['pressure'];
    currentWindSpeed = json['wind']['speed'];
    currentHumidity = json['main']['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp'] = currentTemperature;
    data['currentSky'] = currentSky;
    data['currentPressure'] = currentPressure;
    data['currentWindSpeed'] = currentWindSpeed;
    data['currentHumidity'] = currentHumidity;
    return data;
  }
}


