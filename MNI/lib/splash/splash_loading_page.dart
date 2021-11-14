import 'package:flutter/material.dart';
import 'package:mni/screens/home.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class MySplashLoadingPage extends StatefulWidget {
  @override
  _MySplashLoadingPageState createState() => _MySplashLoadingPageState();
}

class _MySplashLoadingPageState extends State<MySplashLoadingPage> {
  @override
  void initState() {
    _mockCheckForSession().then((status) => {
          if (status)
            {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>Home(),
                ),
              ),
            }
        });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 10000), () {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _AnimatedLiquidCustomProgressIndicator(),
      ),
    );
  }

  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(50, 0)
      ..lineTo(105, 80)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120)
      ..close();
  }

  Path _buildSpeechBubblePath() {
    return Path()
      ..moveTo(50, 0)
      ..quadraticBezierTo(0, 0, 0, 37.5)
      ..quadraticBezierTo(0, 75, 25, 75)
      ..quadraticBezierTo(25, 95, 5, 95)
      ..quadraticBezierTo(35, 95, 40, 75)
      ..quadraticBezierTo(100, 75, 100, 37.5)
      ..quadraticBezierTo(100, 0, 50, 0)
      ..close();
  }
}

class _AnimatedLiquidCustomProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidCustomProgressIndicatorState();
}

class _AnimatedLiquidCustomProgressIndicatorState
    extends State<_AnimatedLiquidCustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: LiquidCustomProgressIndicator(
        value: _animationController.value,
        direction: Axis.vertical,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation(Colors.blue),
        shapePath: _buildOvalPath(),
        center: Text(
          '${percentage.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 18.0,
            decoration: TextDecoration.none,
            color: Colors.blue[100],
          ),
        ),
      ),
    );
  }

  Path _buildOvalPath() {
    return Path()
      ..addOval(Rect.fromLTRB(65, 65, 100, 100).inflate(60))
      ..close();
  }

  Path _buildHeartPath() {
    return Path()
      ..moveTo(55, 15)
      ..cubicTo(55, 12, 50, 0, 30, 0)
      ..cubicTo(0, 0, 0, 37.5, 0, 37.5)
      ..cubicTo(0, 55, 20, 77, 55, 95)
      ..cubicTo(90, 77, 110, 55, 110, 37.5)
      ..cubicTo(110, 37.5, 110, 0, 80, 0)
      ..cubicTo(65, 0, 55, 12, 55, 15)
      ..close();
  }
}
