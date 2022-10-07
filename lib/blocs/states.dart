import 'package:weather_mvp/data/models/weather_forecast_object.dart';

abstract class WeatherState
{
}


class WeatherEmpty extends WeatherState
{}

class WeatherLoading extends WeatherState
{}

class WeatherLoaded extends WeatherState
{
  final WeatherForecastObject weatherForecastObject;

  WeatherLoaded(this.weatherForecastObject);
}
class WeatherError extends WeatherState
{
}
