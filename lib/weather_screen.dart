import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secret_code.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  int humidity = 0;
  int pressure = 0;
  double windSpeed = 0;
  String condition = '';

  @override
  // void initState() {
  //   super.initState();
  //   getCurrentWeather();
  // }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Ilorin';
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&APPID=2e88917180f32c12cf529dd257e972b3'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'unexpected error';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final data = snapshot.data!;
          temp = (data['list'][0]['main']['temp']);
          condition = (data['list'][0]['weather'][0]['main']);
          humidity = (data['list'][0]['main']['humidity']);
          pressure = (data['list'][0]['main']['pressure']);
          windSpeed = (data['list'][0]['wind']['speed']);
          
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Builder(builder: (context) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Column(
                          children: [
                            Text(
                              '$temp\u2103',
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Icon(
                              Icons.cloud,
                              size: 50,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              condition,
                              style: const TextStyle(fontSize: 30),
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //weather forecast
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          HourlyForecast(
                              time: '06:33', icon: Icons.cloud, temp: '14.67'),
                          HourlyForecast(
                              time: '09:43', icon: Icons.foggy, temp: '14.42'),
                          HourlyForecast(
                              time: '17:10', icon: Icons.sunny, temp: '34.29'),
                          HourlyForecast(
                              time: '03:35', icon: Icons.cloud, temp: '12.12'),
                          HourlyForecast(
                              time: '13:10', icon: Icons.sunny, temp: '44.22'),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //additional information
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                        icon: Icons.water_drop_rounded,
                        info: 'Humidity',
                        value: (humidity.toString())),
                    AdditionalInfo(
                        icon: Icons.air,
                        info: 'Wind Speed',
                        value: windSpeed.toString()),
                    AdditionalInfo(
                        icon: Icons.beach_access,
                        info: 'Pressure',
                        value: pressure.toString()),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
