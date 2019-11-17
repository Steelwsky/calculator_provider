import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String str;
  final Function func;
  MyButton({this.str, this.func});

  @override
  Widget build(BuildContext context) {
//    final CalcController calcController = Provider.of<CalcController>(context);
    return  Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: BoxConstraints.tight(Size(64.0, 64.0)),
          onPressed: () {
            func(str);
          },
          child: new Text(
            '$str',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.indigo,
          padding: const EdgeInsets.all(0.0),
        ));
  }
}
