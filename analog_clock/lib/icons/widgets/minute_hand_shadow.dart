import 'package:flutter/material.dart';

import 'animated_container_hand.dart';

class MinuteHandShadow extends StatelessWidget {
  const MinuteHandShadow({
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
      offset: Offset(unit / 3, unit / 3),
      child: Padding(
        padding: EdgeInsets.all(2 * unit),
        child: AnimatedContainerHand(
          size: 0.5,
          now: _now.minute,
          child: Transform.translate(
            offset: Offset(0.0, -8 * unit),
            child: Container(
              width: unit / 2,
              height: unit * 15,
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
