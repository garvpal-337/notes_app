import 'package:bloc/bloc.dart';
import 'package:notes_assignment/helper/weather_data_provider.dart';
import 'package:notes_assignment/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeatherData>((event, emit)async  {
      emit(LoadingWeatherData());    
    try {
      final weather = await WeatherDataProvider().getWeatherData(event.city ?? 'delhi');
      emit(SucceccToGetWeatherData(weather));
    } catch (e) {
      emit(FailedToGetWeatherData(e.toString()));
    }
    });
  }
}
