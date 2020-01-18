// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:analog_clock/icons/widgets/clock_widgets.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'icons/weather_icons_icons.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  WeatherCondition _condition;
  Timer _timer;

  final weatherMap = {
    WeatherCondition.sunny: WeatherIcons.sun,
    WeatherCondition.cloudy: WeatherIcons.cloud_solid,
    WeatherCondition.foggy: WeatherIcons.smog_solid,
    WeatherCondition.rainy: WeatherIcons.cloud_rain_solid,
    WeatherCondition.thunderstorm: WeatherIcons.bolt_solid,
    WeatherCondition.snowy: WeatherIcons.cloud_meatball_solid,
    WeatherCondition.windy: WeatherIcons.wind_solid,
  };

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _condition = widget.model.weatherCondition;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.grey[800],
            // Minute hand.
            highlightColor: Colors.grey[800],
            // Second hand.
            accentColor: Colors.red[800],
            // Tick color
            cursorColor: Colors.grey[900],
            // Shadow color
            canvasColor: Colors.grey[500],
            // Inner shadow color
            dividerColor: Colors.grey[400],
            // Icon color:
            errorColor: Colors.grey[800].withOpacity(0.1),
            backgroundColor: Colors.grey[300],
          )
        : Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.grey[400],
            // Minute hand.
            highlightColor: Colors.grey[400],
            // Second hand.
            accentColor: Colors.red[800],
            // Tick color
            cursorColor: Colors.grey[900],
            // Shadow color
            canvasColor: Colors.grey[900],
            // Inner shadow color
            dividerColor: Colors.grey[900],
            // Icon color:
            errorColor: Colors.grey[400].withOpacity(0.1),
            backgroundColor: Color(0xFF3C4043),
          );

    final time = DateFormat.Hms().format(DateTime.now());

    final icon = weatherMap[_condition];

    return LayoutBuilder(
      builder: (context, constraints) {
        final unit = constraints.biggest.width / 50;

        return Semantics.fromProperties(
          properties: SemanticsProperties(
            label: 'Analog clock with time $time',
            value: time,
          ),
          child: Container(
            padding: EdgeInsets.all(2 * unit),
            color: customTheme.backgroundColor,
            child: Stack(
              children: [
                OuterShadows(customTheme: customTheme, unit: unit),
                AnimatedClockIcon(
                    customTheme: customTheme, unit: unit, icon: icon),
                InnerShadows(customTheme: customTheme, unit: unit),
                ClockTicks(customTheme: customTheme, unit: unit),
                HourHandShadow(customTheme: customTheme, unit: unit, now: _now),
                MinuteHandShadow(
                    customTheme: customTheme, unit: unit, now: _now),
                SecondHandShadow(
                    customTheme: customTheme, unit: unit, now: _now),
                HourHand(customTheme: customTheme, unit: unit, now: _now),
                MinuteHand(customTheme: customTheme, unit: unit, now: _now),
                SecondHand(customTheme: customTheme, now: _now, unit: unit),
                SecondHandCircle(
                    customTheme: customTheme, now: _now, unit: unit),
                ClockPin(customTheme: customTheme, unit: unit),
              ],
            ),
          ),
        );
      },
    );
  }
}
