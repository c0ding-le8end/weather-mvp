abstract class WeatherEvent
{

}

class FetchWeather extends WeatherEvent
{
  String city;

  FetchWeather(this.city): assert(city != null);
}