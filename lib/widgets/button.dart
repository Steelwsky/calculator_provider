import 'package:flutter/material.dart';
import 'package:provider_calc_expanded/settings/button_settings.dart';

class MyButton extends StatelessWidget {
  final String str;
  final Function func;
  final ButtonSettings buttonSettings;

  MyButton({this.str, this.func, this.buttonSettings});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: str == '0'
              ? BoxConstraints.tight(Size(160.0, 78.0))
              : BoxConstraints.tight(Size(78.0, 78.0)),
          key: ValueKey('button$str'),
          onPressed: () {
            (str == 'AC' || str == '.' || str == '+-' || str == '%')
                ? func()
                : func(str);
          },
          child: new Text(
            str == '.' ? ',' : str == '-' ? '\u2014' : str == '*' ? '\u00D7' : '$str',
            style: TextStyle(
                fontSize: str == '*' || str == '+' || str == '=' ? 40 : 35,
                color: buttonSettings.fontColor,
                fontWeight: FontWeight.w500),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          elevation: 2.0,
          fillColor: buttonSettings.backgroundColor,
          padding: str == '0'
              ? const EdgeInsets.only(right: 84)
              : const EdgeInsets.all(0.0),
        ));
  }
}
