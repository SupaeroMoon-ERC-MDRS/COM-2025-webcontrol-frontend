import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

class Button4State{
  bool t = false;
  bool r = false;
  bool b = false;
  bool l = false;
}

class Button4 extends StatefulWidget {
  const Button4({super.key, required this.size, required this.onUpdate});

  final Size size;
  final void Function(Button4State) onUpdate;

  @override
  State<Button4> createState() => _Button4State();
}

class _Button4State extends State<Button4> {
  final Button4State buttonState = Button4State();

  void _actionAt(final Offset pos, final bool set){
    final int dir = (pos.direction * 2 / pi).round();
    if(dir == 0){
      buttonState.r = set;
    }
    else if(dir == 1){
      buttonState.b = set;
    }
    else if(dir == 2 || dir == -2){
      buttonState.l = set;
    }
    else if(dir == -1){
      buttonState.t = set;
    }
    widget.onUpdate(buttonState);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: GestureDetector(
        onTapDown: (details) => _actionAt(details.localPosition - widget.size.center(Offset.zero), true),
        onTapUp: (details) => _actionAt(details.localPosition - widget.size.center(Offset.zero), false),
        child: CustomPaint(
          painter: _Button4Painter(state: buttonState),
        ),
      ),
    );
  }
}

class _Button4Painter extends CustomPainter {

  final Button4State state;

  _Button4Painter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint secPaint = Paint()..color = ThemeManager.globalStyle.secondaryColor;
    final Paint bgPaint = Paint()..color = ThemeManager.globalStyle.bgColor;
    final Paint activePaint = Paint()..color = ThemeManager.globalStyle.primaryColor;

    final Offset center = size.center(Offset.zero);
    final double halfdim = size.width / 2;
    final double tenthdim = size.width / 10;
    final double fifteenthdim = size.width / 15;

    canvas.drawCircle(center, halfdim, secPaint..style = PaintingStyle.fill);

    final Path left = Path();
    left.moveTo(center.dx - fifteenthdim, center.dy);
    left.lineTo(center.dx - tenthdim - fifteenthdim, center.dy - tenthdim);
    left.lineTo(fifteenthdim, center.dy - tenthdim);
    left.lineTo(fifteenthdim, center.dy + tenthdim);
    left.lineTo(center.dx - tenthdim - fifteenthdim, center.dy + tenthdim);
    left.lineTo(center.dx - fifteenthdim, center.dy);
    if(state.l){
      canvas.drawPath(left, activePaint..style = PaintingStyle.fill);
    }
    else{
      canvas.drawPath(left, bgPaint..style = PaintingStyle.fill);
    }

    final Path top = Path();
    top.moveTo(center.dx, center.dy - fifteenthdim);
    top.lineTo(center.dx + tenthdim, center.dy - tenthdim - fifteenthdim);
    top.lineTo(center.dx + tenthdim, fifteenthdim);
    top.lineTo(center.dx - tenthdim, fifteenthdim);
    top.lineTo(center.dx - tenthdim, center.dy - tenthdim - fifteenthdim);
    top.lineTo(center.dx, center.dy - fifteenthdim);
    if(state.t){
      canvas.drawPath(top, activePaint..style = PaintingStyle.fill);
    }
    else{
      canvas.drawPath(top, bgPaint..style = PaintingStyle.fill);
    }

    final Path right = Path();
    right.moveTo(center.dx + fifteenthdim, center.dy);
    right.lineTo(center.dx + tenthdim + fifteenthdim, center.dy - tenthdim);
    right.lineTo(size.width - fifteenthdim, center.dy - tenthdim);
    right.lineTo(size.width - fifteenthdim, center.dy + tenthdim);
    right.lineTo(center.dx + tenthdim + fifteenthdim, center.dy + tenthdim);
    right.lineTo(center.dx + fifteenthdim, center.dy);
    if(state.r){
      canvas.drawPath(right, activePaint..style = PaintingStyle.fill);
    }
    else{
      canvas.drawPath(right, bgPaint..style = PaintingStyle.fill);
    }

    final Path bottom = Path();
    bottom.moveTo(center.dx, center.dy + fifteenthdim);
    bottom.lineTo(center.dx + tenthdim, center.dy + tenthdim + fifteenthdim);
    bottom.lineTo(center.dx + tenthdim, size.height - fifteenthdim);
    bottom.lineTo(center.dx - tenthdim, size.height - fifteenthdim);
    bottom.lineTo(center.dx - tenthdim, center.dy + tenthdim + fifteenthdim);
    bottom.lineTo(center.dx, center.dy + fifteenthdim);
    if(state.b){
      canvas.drawPath(bottom, activePaint..style = PaintingStyle.fill);
    }
    else{
      canvas.drawPath(bottom, bgPaint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(_Button4Painter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_Button4Painter oldDelegate) => false;
}

/////////////////////////////////////////////////////////////////////////

class StickState{
  double r = 0;
  double a = 0;

  bool get isZero => r == 0 && a == 0;
}

class Stick extends StatefulWidget {
  const Stick({super.key, required this.size, required this.onUpdate});

  final Size size;
  final void Function(StickState) onUpdate;

  @override
  State<Stick> createState() => _StickState();
}

class _StickState extends State<Stick> {
  final StickState stickState = StickState();

  void _actionAt(final Offset pos, final bool set){
    
    if(set){
      stickState.a = atan2(pos.dy, pos.dx);
      stickState.r = (pos.dx / (widget.size.width / 2) * 127 / cos(stickState.a)).clamp(0, 127);
    }
    else{
      stickState.r = 0;
      stickState.a = 0;
    }
    widget.onUpdate(stickState);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: GestureDetector(
        onPanUpdate: (details) => _actionAt(details.localPosition - widget.size.center(Offset.zero), true),
        onPanEnd: (details) => _actionAt(details.localPosition - widget.size.center(Offset.zero), false),
        child: CustomPaint(
          painter: _StickPainter(state: stickState),
        ),
      ),
    );
  }
}

class _StickPainter extends CustomPainter {

  final StickState state;

  _StickPainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint secPaint = Paint()..color = ThemeManager.globalStyle.secondaryColor;
    final Paint bgPaint = Paint()..color = ThemeManager.globalStyle.bgColor;
    final Paint activePaint = Paint()..color = ThemeManager.globalStyle.primaryColor;

    final Offset center = size.center(Offset.zero);
    final double halfdim = size.width / 2;
    final double thirddim = size.width / 3;

    canvas.drawCircle(center, halfdim, secPaint..style = PaintingStyle.fill);

    if(state.isZero){
      canvas.drawCircle(center, thirddim, bgPaint..style = PaintingStyle.fill);
    }
    else{
      final double r = state.r / 127 * halfdim;
      canvas.drawCircle(center + Offset(r * cos(state.a), r * sin(state.a)), thirddim, activePaint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(_StickPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_StickPainter oldDelegate) => false;
}