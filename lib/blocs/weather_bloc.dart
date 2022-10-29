import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_mvp/data/repositories/weather_repository.dart';

import 'events.dart';
import 'states.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  WeatherRepository _weatherRepository = WeatherRepository();

  WeatherBloc() : super(WeatherEmpty()) {

    on<FetchWeather>((event, emit) async {
      try
      {
        emit(WeatherLoading());
        final weather = await _weatherRepository.getWeather(event.city);
        emit(WeatherLoaded(weather));
      }
     catch(e)
      {
        emit(WeatherError());
      }
    });
  }


}
