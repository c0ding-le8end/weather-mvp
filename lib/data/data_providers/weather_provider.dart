import 'package:http/http.dart';

class WeatherProvider
{
  Future getWeatherJson(String city)async
  {
    Response response=await get(Uri.parse("http://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=94efe6454e663f73a7572c8628c4d037"));
    return response.body;

  }
}