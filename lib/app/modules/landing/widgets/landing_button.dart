import 'package:flutter/material.dart';
import 'package:waroengsederhana/colors.dart';

class LandingButton extends StatelessWidget {
  final VoidCallback ontap;
  const LandingButton({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: ontap,
        child: const Text(
          'SELANJUTNYA',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
