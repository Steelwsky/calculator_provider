import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String str;
  final Function func;

  MyButton({this.str, this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: str == '0'
              ? BoxConstraints.tight(Size(152.0, 74.0))
              : BoxConstraints.tight(Size(74.0, 74.0)),
          key: ValueKey('button$str'),
          onPressed: () {
            (str == 'AC' || str == '.' || str == '+-' || str == '%')
                ? func()
                : func(str);
          },
          child: new Text(
            str == '.' ? ',' : '$str',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0)),
          elevation: 2.0,
          fillColor: Colors.indigo,
          padding: str == '0'
              ? const EdgeInsets.only(right: 84)
              : const EdgeInsets.all(0.0),
        ));
  }
}
