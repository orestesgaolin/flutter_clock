import 'package:flutter/material.dart';

class InnerShadows extends StatelessWidget {
  const InnerShadows({
    Key key,
    @required this.unit,
    @required this.customTheme,
  }) : super(key: key);

  final double unit;
  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(1.5 * unit),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: customTheme.backgroundColor,
              gradient: RadialGradient(
                colors: [
                  darkMode
                      ? customTheme.backgroundColor.withOpacity(0.0)
                      : Colors.white.withOpacity(0.0),
                  customTheme.dividerColor,
                ],
                center: AlignmentDirectional(0.1, 0.1),
                focal: AlignmentDirectional(0.0, 0.0),
                radius: 0.65,
                focalRadius: 0.001,
                stops: [0.3, 1.0],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: customTheme.backgroundColor,
              gradient: RadialGradient(
                colors: [
                  darkMode
                      ? customTheme.backgroundColor.withOpacity(0.0)
                      : Colors.white.withOpacity(0.0),
                  darkMode ? Colors.white.withOpacity(0.3) : Colors.white,
                ],
                center: AlignmentDirectional(-0.1, -0.1),
                focal: AlignmentDirectional(0.0, 0.0),
                radius: 0.67,
                focalRadius: 0.001,
                stops: [0.75, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
