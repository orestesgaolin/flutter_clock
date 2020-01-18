import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

import 'container_hand.dart';

class HourHandShadow extends StatelessWidget {
  const HourHandShadow({
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
    return Transform.translate(
      offset: Offset(unit / 4, unit / 5),
      child: Padding(
        padding: EdgeInsets.all(2 * unit),
        child: ContainerHand(
          color: Colors.transparent,
          size: 0.5,
          angleRadians:
              _now.hour * radiansPerHour + (_now.minute / 60) * radiansPerHour,
          child: Transform.translate(
            offset: Offset(0.0, -3 * unit),
            child: Container(
              width: 1.5 * unit,
              height: 7 * unit,
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: customTheme.canvasColor,
                    blurRadius: unit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
