import 'dart:convert';

import 'package:date_format/date_format.dart';
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

  //@override
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
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
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
                            Icon(
                              condition == 'Clear' ? Icons.sunny : Icons.cloud,
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
                //ListView Builder is used to replace SingleChildScrollView
                //for performance reasons. It only build the UI in view not
                // all the UIs at once.
                SizedBox(
                  height: 151,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        String timeStamp =
                            (data['list'][index]['dt_txt']).toString();
                        String timeStampNow = formatDate(
                            DateTime.parse(timeStamp), [HH, ':', nn]);
                        return HourlyForecast(
                            time: timeStampNow,
                            icon: condition == 'Clear'
                                ? Icons.sunny
                                : Icons.cloud,
                            temp: (data['list'][index]['main']['temp'])
                                .toString());
                      }),
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         HourlyForecast(
                //             time: (data['list'][i + 1]['dt']).toString(),
                //             icon: condition == 'Clear'
                //                 ? Icons.sunny
                //                 : Icons.cloud,
                //             temp: (data['list'][i + 1]['main']['temp'])
                //                 .toString())
                //     ],
                //   ),
                // )
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
