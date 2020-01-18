import 'package:flutter/material.dart';

import 'animated_container_hand.dart';

class SecondHandCircle extends StatelessWidget {
  const SecondHandCircle({
    Key key,
    @required DateTime now,
    @required this.unit,
    @required this.customTheme,
  })  : _now = now,
        super(key: key);

  final DateTime _now;
  final double unit;
  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerHand(
      now: _now.second,
      size: 0.6,
      child: Transform.translate(
        offset: Offset(0.0, 4 * unit),
        child: Container(
          width: 2 * unit,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: customTheme.accentColor,
          ),
        ),
      ),
    );
  }
}
