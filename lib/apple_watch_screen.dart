import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  final random = Random();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();
  late final CurvedAnimation _curve =
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
  // 첫번째 코드 챌린지 end -> random.nextDouble() * 2.0 변경
  // 두번째 코드 챌린지 end -> Progress변수를 3가지로 추가
  late Animation<double> _redProgress =
      Tween(begin: 0.005, end: random.nextDouble() * 2.0).animate(_curve);
  late Animation<double> _greenProgress =
      Tween(begin: 0.005, end: random.nextDouble() * 2.0).animate(_curve);
  late Animation<double> _blueProgress =
      Tween(begin: 0.005, end: random.nextDouble() * 2.0).animate(_curve);
  void _animateValue() {
    // 두번째 코드 챌린지 end -> Progress변수를 3가지로 추가
    final newRedBegin = _redProgress.value;
    final newRedEnd = random.nextDouble() * 2.0;

    final newGreenBegin = _greenProgress.value;
    final newGreenEnd = random.nextDouble() * 2.0;

    final newBlueBegin = _blueProgress.value;
    final newBlueEnd = random.nextDouble() * 2.0;
    setState(() {
      // 두번째 코드 챌린지 end -> Progress변수를 3가지로 추가
      _redProgress = Tween(begin: newRedBegin, end: newRedEnd).animate(_curve);
      _greenProgress =
          Tween(begin: newGreenBegin, end: newGreenEnd).animate(_curve);
      _blueProgress =
          Tween(begin: newBlueBegin, end: newBlueEnd).animate(_curve);
    });
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Apple Watch"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              size: const Size(400, 400),
              painter: AppleWatchPainter(
                  redProgress: _redProgress.value,
                  greenProgress: _greenProgress.value,
                  blueProgress: _blueProgress.value),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValue,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  // 두번째 코드 챌린지 end -> Progress변수를 3가지로 추가
  double redProgress;
  double greenProgress;
  double blueProgress;
  AppleWatchPainter(
      {required this.redProgress,
      required this.greenProgress,
      required this.blueProgress});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final startingAngle = -0.5 * pi;
    // draw red
    final redCirclePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    final redCurlceRadius = (size.width / 2) * 0.9;
    canvas.drawCircle(center, redCurlceRadius, redCirclePaint);
    // draw green
    final blueCirclePaint = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    final greenCurlceRadius = (size.width / 2) * 0.76;
    canvas.drawCircle(center, greenCurlceRadius, blueCirclePaint);
    // draw blue
    final greenCirclePaint = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;
    final blueCurlceRadius = (size.width / 2) * 0.62;
    canvas.drawCircle(center, blueCurlceRadius, greenCirclePaint);

    // red arc
    final redArcRect = Rect.fromCircle(center: center, radius: redCurlceRadius);
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
        redArcRect, startingAngle, redProgress * pi, false, redArcPaint);
    // green arc
    final greenArcRect =
        Rect.fromCircle(center: center, radius: greenCurlceRadius);
    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
        greenArcRect, startingAngle, greenProgress * pi, false, greenArcPaint);
    // blud arc
    final blueArcRect =
        Rect.fromCircle(center: center, radius: blueCurlceRadius);
    final blueArcPaint = Paint()
      ..color = Colors.blue.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(
        blueArcRect, startingAngle, blueProgress * pi, false, blueArcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
