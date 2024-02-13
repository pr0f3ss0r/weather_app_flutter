import "package:flutter/material.dart";

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