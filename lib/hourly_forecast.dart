import "package:flutter/material.dart";

class HourlyForecast extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourlyForecast(
      {super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Text(time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 8,
            ),
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              temp,
              style: const TextStyle(fontSize: 25),
            )
          ]),
        ),
      ),
    );
  }
}
