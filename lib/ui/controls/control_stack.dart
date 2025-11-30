import 'package:flutter/material.dart';

class ControlStack extends StatelessWidget {
  const ControlStack({super.key, required this.size, required this.orientation});

  final Size size;
  final bool orientation;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: size.height / 2,
            left: size.width / 5,
            child: Container(color: Colors.red, child: Text("LButtons"),)
          ),
          Positioned(
            top: size.height / 2,
            left: 4 * size.width / 5,
            child: Container(color: Colors.red, child: Text("RButtons"),)
          ),
          Positioned(
            top: 2 * size.height / 3,
            left: size.width / 3,
            child: Container(color: Colors.red, child: Text("LStick"),)
          ),
          Positioned(
            top: 2 * size.height / 3,
            left: 2 * size.width / 3,
            child: Container(color: Colors.red, child: Text("RStick"),)
          ),
          Positioned(
            top: size.height / 4,
            left: size.width / 4,
            child: Container(color: Colors.red, child: Text("LSandT"),)
          ),
          Positioned(
            top: size.height / 4,
            left: 3 * size.width / 4,
            child: Container(color: Colors.red, child: Text("RSandT"),)
          ),
        ],
      ),
    );
  }
}