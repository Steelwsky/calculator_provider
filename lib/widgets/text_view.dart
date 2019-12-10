import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(400, 100)),
              child: SizedBox(
                child: AutoSizeText(
                  '${newState.result}',
                  style: TextStyle(
                    fontSize: 56.0,
                    color: Colors.white,
                  ),
                  maxFontSize: 56.0,
                  maxLines: 1,
//                textAlign: TextAlign.center,
                  key: ValueKey('textViewResult'),
                ),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 120, right: 54, bottom: 12, left: 54),
          );
        });
  }
}