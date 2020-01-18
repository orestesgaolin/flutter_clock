import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

import 'container_hand.dart';

class AnimatedContainerHand extends StatelessWidget {
  const AnimatedContainerHand({
    Key key,
    @required int now,
    @required Widget child,
    @required double size,
  })  : _now = now,
        _child = child,
        _size = size,
        super(key: key);

  final int _now;
  final Widget _child;
  final double _size;

  @override
  Widget build(BuildContext context) {
    if (_now == 0) {
      return TweenAnimationBuilder<double>(
        key: ValueKey('special_case_when_overflowing'),
        duration: Duration(milliseconds: 300),
        tween: Tween<double>(
          begin: value(_now - 1),
          end: value(_now),
        ),
        curve: Curves.easeInQuint,
        builder: (context, anim, child) {
          return ContainerHand(
            color: Colors.transparent,
            size: _size,
            angleRadians: anim,
            child: child,
          );
        },
        child: _child,
      );
    }
    return TweenAnimationBuilder<double>(
      key: ValueKey('normal_case'),
      duration: Duration(milliseconds: 300),
      tween: Tween<double>(
        begin: value(_now - 1),
        end: value(_now),
      ),
      curve: Curves.easeInQuint,
      builder: (context, anim, child) {
        return ContainerHand(
          color: Colors.transparent,
          size: _size,
          angleRadians: anim,
          child: child,
        );
      },
      child: _child,
    );
  }

  double value(int second) {
    return second * radiansPerTick;
  }
}
