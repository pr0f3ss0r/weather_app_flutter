import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
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
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '300.67°C',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Icon(
                        Icons.cloud,
                        size: 50,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Rain',
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //weather forecast
            const Column(
              children: [
                Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecast(),
                      HourlyForecast(),
                      HourlyForecast(),
                      HourlyForecast(),
                      HourlyForecast(),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //additional information
            SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  children: [
                    Icon(Icons.water_drop_rounded),
                    Text('Humidity'),
                    Text('94')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            Text('09:10',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 8,
            ),
            Icon(
              Icons.cloud,
              size: 30,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '30.17',
              style: TextStyle(fontSize: 25),
            )
          ]),
        ),
      ),
    );
  }
}
