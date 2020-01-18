import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

import 'container_hand.dart';

class HourHand extends StatelessWidget {
  const HourHand({
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
      child: ContainerHand(
        color: Colors.transparent,
        size: 0.5,
        angleRadians:
            _now.hour * radiansPerHour + (_now.minute / 60) * radiansPerHour,
        child: Transform.translate(
          offset: Offset(0.0, -3 * unit),
          child: Semantics.fromProperties(
            properties: SemanticsProperties(
                value: '${_now.hour}',
                label: 'Hour hand of the clock at position ${_now.hour} hrs.'),
            child: Container(
              width: 1.5 * unit,
              height: 7 * unit,
              decoration: BoxDecoration(
                color: customTheme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
