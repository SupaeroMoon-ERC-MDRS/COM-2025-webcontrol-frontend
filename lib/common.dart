import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> mainWindowNavigatorKey = GlobalKey<NavigatorState>();

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }
  (context as Element).visitChildren(rebuild);
}

String representNumber(final num? v, {int targetChar = 10}){
  if(v == null){
    return "";
  }
  String ret = v.toStringAsPrecision(targetChar);
  if(ret.contains('.')){
    while(ret.endsWith('0') && ret.length >= 2){
      ret = ret.substring(0, ret.length - 1);
    }
  }
  if(ret.endsWith('.')){
    ret = ret.substring(0, ret.length - 1);
  }
  return ret;
}