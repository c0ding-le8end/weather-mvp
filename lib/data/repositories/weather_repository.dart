import 'dart:convert';

import 'package:weather_mvp/blocs/weather_bloc.dart';
import 'package:weather_mvp/data/data_providers/weather_provider.dart';
import 'package:weather_mvp/data/models/weather_forecast_object.dart';

class WeatherRepository
{
  WeatherProvider weatherProvider=WeatherProvider();
  Future getWeather(String city)async
  {
    var data=await weatherProvider.getWeatherJson(city);
    print(data);

    return WeatherForecastObject.fromJson(json.decode(data));
  }
}