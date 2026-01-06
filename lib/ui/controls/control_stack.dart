import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/control_data.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/ui/controls/control_painters.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

class ControlStack extends StatelessWidget {
  const ControlStack({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final Size button4Size = Size.square(size.height / 5);
    final Size shoulderSize = Size(size.width / 12, size.height / 4);
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
            top: size.height / 4 - shoulderSize.height / 2,
            left: size.width / 3 - shoulderSize.width / 2,
            child: Shoulder(
              size: shoulderSize,
              onUpdate: (final ShoulderState state){
                controlData.update((final ControlData data){
                  data.lShoulder = state.button;
                  data.leftTrigger = state.trigger;
                });
              }
            )
          ),
          Positioned(
            top: size.height / 4 - shoulderSize.height / 2,
            left: 2 * size.width / 3 - shoulderSize.width / 2,
            child: Shoulder(
              size: shoulderSize,
              onUpdate: (final ShoulderState state){
                controlData.update((final ControlData data){
                  data.rShoulder = state.button;
                  data.rightTrigger = state.trigger;
                });
              }
            )
          ),
        ],
      ),
    );
  }
}

class SimplifiedControlStack extends StatelessWidget {
  const SimplifiedControlStack({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final Size stickSize = Size.square(size.height / 2);
    return SizedBox.fromSize(
      size: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 1 * size.height / 7 - size.height / 21, left: 0,
            child: SizedBox(
              width: 4 * size.width / 9,
              child: TextButton(
                onPressed: (){},
                child: Text(Loc.get("switch_arm_movement_mode"), style: ThemeManager.subTitleStyle,),
              ),
            )
          ),
          Positioned(
            top: 2 * size.height / 7 - size.height / 21, left: 0,
            child: SizedBox(
              width: 4 * size.width / 9,
              child: TextButton(
                onPressed: (){},
                child: Text(Loc.get("toggle_grip"), style: ThemeManager.subTitleStyle,),
              ),
            )
          ),
          Positioned(
            top: 3 * size.height / 7 - size.height / 21, left: 0,
            child: SizedBox(
              width: 4 * size.width / 9,
              child: TextButton(
                onPressed: (){},
                child: Text(Loc.get("move_arm_in_view"), style: ThemeManager.subTitleStyle,),
              ),
            )
          ),
          Positioned(
            top: 4 * size.height / 7 - size.height / 21, left: 0,
            child: SizedBox(
              width: 4 * size.width / 9,
              child: TextButton(
                onPressed: (){},
                child: Text(Loc.get("move_arm_above_sample_container"), style: ThemeManager.subTitleStyle,),
              ),
            )
          ),
          Positioned(
            top: 5 * size.height / 7 - size.height / 21, left: 0,
            child: SizedBox(
              width: 4 * size.width / 9,
              child: TextButton(
                onPressed: (){
                  controlData.update((final ControlData data){
                    data.rBottom = true;
                  });
                },
                child: Text(Loc.get("soft_stop"), style: ThemeManager.subTitleStyle,),
              ),
            )
          ),
          Positioned( // TODO confirm dialog for this one
            top: 6 * size.height / 7 - size.height / 21, left: 0,
            child: SizedBox(
              width: 4 * size.width / 9,
              child: TextButton(
                onPressed: (){
                  controlData.update((final ControlData data){
                    data.lLeft = true;
                    data.rRight = true;
                  });
                },
                child: Text(Loc.get("emergency_stop"), style: ThemeManager.subTitleStyle,),
              ),
            )
          ),
          ///////////////////////////////////////////////////////////////////////////
          Positioned(
            top: size.height / 10,
            left: size.width / 2,
            child: Container(
              width: 1,
              height: 8 * size.height / 10,
              color: ThemeManager.globalStyle.primaryColor,
            )
          ),
          ///////////////////////////////////////////////////////////////////////////
          Positioned(
            top: size.height / 2 - stickSize.height / 2,
            left: 3 * size.width / 4 - stickSize.width / 2,
            child: Stick(
              size: stickSize,
              onUpdate: (final StickState state){
                controlData.update((final ControlData data){
                  data.thumbRightX = (state.r * cos(state.a)).truncate() + 128;
                  data.thumbRightY = -(state.r * sin(state.a)).truncate() + 128;
                });
              }
            )
          ),
        ],
      ),
    );
  }
}