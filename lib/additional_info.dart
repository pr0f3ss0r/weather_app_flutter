import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(
              Icons.water_drop_rounded,
              size: 40,
            ),
            Text('Humidity',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text('94',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Icon(
              Icons.air,
              size: 50,
            ),
            Text('Wind Speed',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text('76.7',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Icon(
              Icons.align_horizontal_right_sharp,
              size: 40,
            ),
            Text('Pressure',
                style: TextStyle(
                  fontSize: 20,
                )),
            Text('1006',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ))
          ],
        )
      ],
    );
  }
}
