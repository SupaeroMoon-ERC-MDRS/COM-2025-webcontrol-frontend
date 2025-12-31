import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/control_data.dart';
import 'package:supaeromoon_webcontrol/ui/controls/control_painters.dart';

class ControlStack extends StatelessWidget {
  const ControlStack({super.key, required this.size, required this.orientation});

  final Size size;
  final bool orientation;

  @override
  Widget build(BuildContext context) {
    final Size button4Size = Size.square(size.height / 5);
    return SizedBox.fromSize(
      size: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: size.height / 2 - button4Size.height / 2,
            left: size.width / 5 - button4Size.width / 2,
            child: Button4(
              size: button4Size,
              onUpdate: (final Button4State state) {
                controlData.update((final ControlData data){
                  data.lBottom = state.b;
                  data.lLeft = state.l;
                  data.lRight = state.r;
                  data.lTop = state.t;

                  data.eStop = data.lLeft && data.rRight;
                });
              },
            )
          ),
          Positioned(
            top: size.height / 2 - button4Size.height / 2,
            left: 4 * size.width / 5 - button4Size.width / 2,
            child: Button4(
              size: button4Size,
              onUpdate: (final Button4State state) {
                controlData.update((final ControlData data){
                  data.rBottom = state.b;
                  data.rLeft = state.l;
                  data.rRight = state.r;
                  data.rTop = state.t;

                  data.eStop = data.lLeft && data.rRight;
                });
              },
            )
          ),
          Positioned(
            top: 2 * size.height / 3 - button4Size.height / 2,
            left: 2 * size.width / 5 - button4Size.width / 2,
            child: Stick(
              size: button4Size,
              onUpdate: (final StickState state){
                controlData.update((final ControlData data){
                  data.thumbLeftX = (state.r * cos(state.a)).truncate() + 128;
                  data.thumbLeftY = -(state.r * sin(state.a)).truncate() + 128;
                });
              }
            )
          ),
          Positioned(
            top: 2 * size.height / 3 - button4Size.height / 2,
            left: 3 * size.width / 5 - button4Size.width / 2,
            child: Stick(
              size: button4Size,
              onUpdate: (final StickState state){
                controlData.update((final ControlData data){
                  data.thumbRightX = (state.r * cos(state.a)).truncate() + 128;
                  data.thumbRightY = -(state.r * sin(state.a)).truncate() + 128;
                });
              }
            )
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