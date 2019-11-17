import 'package:flutter/material.dart';
import 'package:provider_calc_expanded/calc_controller.dart';
import 'package:provider/provider.dart';

class TextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalcController calcController = Provider.of<CalcController>(context);
    return ValueListenableBuilder<CalcState>(
        valueListenable: calcController.state,
        builder: (context, newState, child) {
          return Container(
            child: Text(
//              newState.isFirst ? '${newState.num1}': '${newState.num2}',
            newState.operator == null ? '${newState.num1}' : newState.operator != '' ? '${newState.num2}' : '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60.0,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 134, right: 16, bottom: 16),
          );
        });
  }
}