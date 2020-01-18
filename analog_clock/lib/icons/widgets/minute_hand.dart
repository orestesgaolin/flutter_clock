import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'animated_container_hand.dart';

class MinuteHand extends StatelessWidget {
  const MinuteHand({
    Key key,
    @required this.unit,
    @required DateTime now,
    @required this.customTheme,
  })  : _now = now,
        super(key: key);

  final double unit;
  final DateTime _now;
  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2 * unit),
      child: AnimatedContainerHand(
        size: 0.5,
        now: _now.minute,
        child: Transform.translate(
          offset: Offset(0.0, -8 * unit),
          child: Semantics.fromProperties(
            properties: SemanticsProperties(
                value: '${_now.minute}',
                label:
                    'Minute hand of the clock at position ${_now.minute} min.'),
            child: Container(
              width: unit / 2,
              height: unit * 15,
              decoration: BoxDecoration(
                color: customTheme.highlightColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
