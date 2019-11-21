import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String str;
  final Function func;

  MyButton({this.str, this.func});

  @override
  Widget build(BuildContext context) {
//    final CalcController calcController = Provider.of<CalcController>(context);
    //              newState.isFirst ? '${newState.num1}': '${newState.num2}',
    bool isZero = false;
    if (str == '0') {
      isZero = true;
    }
    print('str : $str, isZero: $isZero');
    return Container(
        margin: const EdgeInsets.all(4.0),
        child: RawMaterialButton(
          constraints: isZero == true
              ? BoxConstraints.tight(Size(152.0, 72.0))
              : BoxConstraints.tight(Size(72.0, 72.0)),
          key: ValueKey('btn$str'),
          onPressed: () {
            func(str);
          },
          child: new Text(
            '$str',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0)),
          elevation: 2.0,
          fillColor: Colors.indigo,
          padding: isZero == true
              ? const EdgeInsets.only(right: 84)
              : const EdgeInsets.all(0.0),
        ));
  }
}
