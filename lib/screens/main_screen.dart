
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_mvp/blocs/events.dart';
import 'package:weather_mvp/blocs/states.dart';
import 'package:weather_mvp/blocs/weather_bloc.dart';
import 'package:weather_mvp/data/models/weather_forecast_object.dart';


class WeatherForecastData extends StatefulWidget {
  String cityName;

  WeatherForecastData({this.cityName = "mumbai"});

  @override
  _WeatherForecastDataState createState() => _WeatherForecastDataState();
}

class _WeatherForecastDataState extends State<WeatherForecastData> {
  late Future<WeatherForecastObject> data;
  String _cityName = WeatherForecastData().cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  keyboardType: TextInputType.text,
                  onSubmitted: (value) {
                    _cityName = value;
                    BlocProvider.of<WeatherBloc>(context)
                        .add(FetchWeather(_cityName));
                  },
                  decoration: InputDecoration(
                      hintText: "Enter city",
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gapPadding: 4.0))),
            ),
            // SearchableDropdown(items:searchCities(), onChanged: null,keyboardType: TextInputType.text,),
            SizedBox(
              height: 15,
            ),

            SizedBox(
              height: 20,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherLoading) {
                return CircularProgressIndicator();
              }
              if (state is WeatherLoaded) {
                return Column(
                  children: [
                    Text(
                      "${state.weatherForecastObject.city?.name},${state.weatherForecastObject.city?.country} ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "${state.weatherForecastObject.list?[0].main?.temp} K, ${state.weatherForecastObject.list?[0].weather?[0].description}",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                );
              }

              if(state is WeatherError)
                {
                  return  Text(
                    "ERROR",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  );
                }
              return Container();
            })
          ],
        ),
      ],
    ));
  }
}
