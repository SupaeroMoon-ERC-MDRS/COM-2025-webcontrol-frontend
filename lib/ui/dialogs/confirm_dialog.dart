import 'package:flutter/material.dart';
import 'package:supaeromoon_webcontrol/data/localization.dart';
import 'package:supaeromoon_webcontrol/ui/theme.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key, required this.text, required this.onConfirm, this.onCancel});

  final String text;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: ThemeManager.textStyle,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (){
                  (onCancel ?? (){})();
                  Navigator.of(context).pop();
                },
                child: Text(Loc.get("cancel"), style: ThemeManager.textStyle,)
              ),
              TextButton(
                onPressed: (){
                  onConfirm();
                  Navigator.of(context).pop();
                },
                child: Text(Loc.get("confirm"), style: ThemeManager.textStyle,)
              )
            ],
          )
        ],
      ),
    );
  }
}