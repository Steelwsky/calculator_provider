import 'package:flutter/material.dart';
import 'package:provider_calc_expanded/calc_controller.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalcController calcController = Provider.of<CalcController>(context);
    return ValueListenableBuilder<CalcState>(
        valueListenable: calcController.state,
        builder: (_, newState, __) {
          return Container(
            child: SizedBox(
              child: AutoSizeText(
                '${newState.result}',
                style: TextStyle(
                  fontSize: 56.0,
                ),
                maxFontSize: 56.0,
                maxLines: 1,
//                textAlign: TextAlign.center,
                key: ValueKey('textViewResult'),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 120, right: 54, bottom: 12, left: 54),
          );
        });
  }
}

//Text(
////              newState.isFirst ? '${newState.num1}': '${newState.num2}',
//'${newState.result}',
//key: ValueKey('textViewResult'),
//textAlign: TextAlign.center,
//style: TextStyle(
//fontSize: 60.0,
//color: Colors.white,
//),
//maxLines: 1,
//),
//alignment: Alignment.centerRight,
//padding: EdgeInsets.only(top: 134, right: 68, bottom: 16),
