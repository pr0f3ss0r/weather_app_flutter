import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData icon;
  final String info;
  final String value;
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.info,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        Text(info,
            style: const TextStyle(
              fontSize: 20,
            )),
        Text(value.toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
