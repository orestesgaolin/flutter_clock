import 'package:flutter/material.dart';

class AnimatedClockIcon extends StatelessWidget {
  const AnimatedClockIcon({
    Key key,
    @required this.unit,
    @required this.icon,
    @required this.customTheme,
  }) : super(key: key);

  final double unit;
  final IconData icon;
  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5 * unit),
      child: Center(
        child: ClipOval(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Transform.translate(
                offset: Offset(7 * unit, 3 * unit),
                child: Center(
                  child: AnimatedSwitcher(
                      duration: Duration(seconds: 2),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, anim) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: FadeTransition(
                            opacity: anim,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        icon,
                        size: 17 * unit,
                        color: customTheme.errorColor,
                        key: ValueKey(icon),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
