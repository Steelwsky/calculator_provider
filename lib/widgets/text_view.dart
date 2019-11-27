import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_calc_expanded/calc_controller.dart';

class TextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CalcController calcController = Provider.of<CalcController>(context);
    return ValueListenableBuilder<CalcState>(
        valueListenable: calcController.state,
        builder: (_, newState, __) {
          return Container(
            child: Text(
              '${newState.currentResult}',
              key: ValueKey('textViewResult'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60.0,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 134, right: 68, bottom: 16),
          );
        });
  }
}
