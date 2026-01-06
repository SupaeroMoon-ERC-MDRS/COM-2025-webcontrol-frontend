import 'dart:typed_data';

import 'package:supaeromoon_webcontrol/data/notifiers.dart';

final UpdateableValueNotifier<ControlData> controlData = UpdateableValueNotifier(ControlData());

class ControlData {
  bool lTop = false;
  bool lBottom = false;
  bool lRight = false;
  bool lLeft = false;    
  bool rTop = false;
  bool rBottom = false;
  bool rRight = false;
  bool rLeft = false;
  bool lShoulder = false;
  bool rShoulder = false;
  bool eStop = false;
  int leftTrigger = 0;
  int rightTrigger = 0;
  int thumbLeftX = 128;
  int thumbLeftY = 128;
  int thumbRightX = 128;
  int thumbRightY = 128;

  Uint8List toBytes(){
    final Uint8List bytes = Uint8List(8);

    if (lTop) bytes[0] |= 1 << 0;
    if (lBottom) bytes[0] |= 1 << 1;
    if (lRight) bytes[0] |= 1 << 2;
    if (lLeft) bytes[0] |= 1 << 3;
    if (rTop) bytes[0] |= 1 << 4;
    if (rBottom) bytes[0] |= 1 << 5;
    if (rRight) bytes[0] |= 1 << 6;
    if (rLeft) bytes[0] |= 1 << 7; 
    if (lShoulder) bytes[1] |= 1 << 0;
    if (rShoulder) bytes[1] |= 1 << 1;
    if (eStop) bytes[1] |= 1 << 2;

    bytes[2] = leftTrigger;
    bytes[3] = rightTrigger;
    bytes[4] = thumbLeftX;
    bytes[5] = thumbLeftY;
    bytes[6] = thumbRightX;
    bytes[7] = thumbRightY;
    return bytes;
  }

  void updateFromBytes(final Uint8List bytes){
    if (bytes.length != 8) {
      return;
    }

    lTop = (bytes[0] & (1 << 0)) != 0;
    lBottom = (bytes[0] & (1 << 1)) != 0;
    lRight = (bytes[0] & (1 << 2)) != 0;
    lLeft = (bytes[0] & (1 << 3)) != 0;
    rTop = (bytes[0] & (1 << 4)) != 0;
    rBottom = (bytes[0] & (1 << 5)) != 0;
    rRight = (bytes[0] & (1 << 6)) != 0;
    rLeft = (bytes[0] & (1 << 7)) != 0;
    lShoulder = (bytes[1] & (1 << 0)) != 0;
    rShoulder = (bytes[1] & (1 << 1)) != 0;
    eStop = (bytes[1] & (1 << 2)) != 0;

    leftTrigger = bytes[2];
    rightTrigger = bytes[3];
    thumbLeftX = bytes[4];
    thumbLeftY = bytes[5];
    thumbRightX = bytes[6];
    thumbRightY = bytes[7];
  }

  void pprint(){
    // ignore: avoid_print
    print( """LT $lTop
              LB $lBottom
              LR $lRight
              LL $lLeft
              RT $rTop
              RB $rBottom
              RR $rRight
              RL $rLeft
              LS $lShoulder
              RS $rShoulder
              ES $eStop
              LTrig $leftTrigger
              RTrig $rightTrigger
              TLX $thumbLeftX
              TLY $thumbLeftY
              TRX $thumbRightX
              TRY $thumbRightY""");
  }
}