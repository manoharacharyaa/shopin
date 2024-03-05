import 'package:flutter/material.dart';
import 'package:shopin/colors/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: blue,
          strokeWidth: 6,
        ),
      ),
    );
  }
}
