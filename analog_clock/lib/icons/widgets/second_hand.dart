import 'package:analog_clock/icons/widgets/animated_container_hand.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class SecondHand extends StatelessWidget {
  const SecondHand({
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
        offset: Offset(0.0, -4 * unit),
        child: Semantics.fromProperties(
          properties: SemanticsProperties(
              value: '${_now.second}',
              label:
                  'Seconds hand of the clock at position ${_now.second} sec.'),
          child: Container(
            width: unit / 2,
            height: double.infinity,
            decoration: BoxDecoration(
              color: customTheme.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
