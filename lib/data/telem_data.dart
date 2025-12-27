import 'dart:typed_data';
import 'notifiers.dart';

final UpdateableValueNotifier<TelemetryData> telemetryData = UpdateableValueNotifier(TelemetryData());

class TelemetryData {
  double current = 0;
  double voltage = 0;

  Uint8List toBytes(){
    Uint8List bytes = Uint8List(4);

    final int currentRep = (current / 0.00030517578125).round(); // 0-20 range float to 16 bit ADC constant (20 / 65536)
    final int voltageRep = (current / 0.00030517578125).round();

    bytes[0] = currentRep & 0xFF;
    bytes[1] = (currentRep >> 8) & 0xFF;
    bytes[2] = voltageRep & 0xFF;
    bytes[3] = (voltageRep >> 8) & 0xFF;

    return bytes;
  }

  void updateFromBytes(final Uint8List bytes){
    if (bytes.length != 4) {
      return;
    }

    final int currentRep = bytes[0] | (bytes[1] << 8);
    final int voltageRep = bytes[2] | (bytes[3] << 8);

    current = currentRep * 0.00030517578125;
    voltage = voltageRep * 0.00030517578125;
  }

  void pprint(){
    // ignore: avoid_print
    print( """LT $current\n
              LB $voltage\n""");
  }
}