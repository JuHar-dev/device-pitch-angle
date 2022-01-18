import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Vector3 _acceleration = Vector3.zero();

  @override
  void initState() {
    super.initState();
    motionSensors.accelerometer.listen((event) {
      setState(() {
        _acceleration.setValues(event.x, event.y, event.z);
      });
    });
  }

  double calcPitch() {
    // https://stackoverflow.com/questions/9888413/how-to-find-the-angle-from-pitch-roll-and-yaw
    return math.atan2(_acceleration.z, _acceleration.y) / (math.pi / 180.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(calcPitch().toStringAsFixed(3)),
      ),
    );
  }
}
