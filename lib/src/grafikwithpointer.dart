import 'package:flutter/material.dart';

class GraphWithPointer extends StatefulWidget {
  final int index;
  final double maxY;
  final double minY;
  final int totalSegmentY;
  final List dataSet;
  final Color backgroundColor;
  final Color lineColor;
  final Color segmentYColor;

  GraphWithPointer(
      {this.index,
      this.minY,
      this.maxY,
      this.totalSegmentY,
      this.dataSet,
      this.backgroundColor,
      this.lineColor,
      this.segmentYColor});

  @override
  _GraphWithPointerState createState() => _GraphWithPointerState();
}

class _GraphWithPointerState extends State<GraphWithPointer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ClipRect(
        child: CustomPaint(
          painter: Graphic(
              index: widget.index,
              maxData: widget.maxY,
              minData: widget.minY,
              countLine: widget.totalSegmentY,
              dataSet: widget.dataSet,
              bgColor: widget.backgroundColor,
              lineColor: widget.lineColor,
              helperLineColor: widget.segmentYColor),
        ),
      ),
    );
  }
}

class Graphic extends CustomPainter {
  final double minData;
  final double maxData;
  final int countLine;
  final List dataSet;
  final int index;
  final Color bgColor;
  final Color helperLineColor;
  final Color lineColor;

  Graphic(
      {this.index,
      this.minData,
      this.maxData,
      this.dataSet,
      this.countLine,
      this.bgColor,
      this.helperLineColor,
      this.lineColor});

  double _maxDataY;
  double _maxRangeY;
  int _numberLine;
  double _drawRatioY;
  double _maxRangeX;
  double _numberSeperationX;
  double _segmentSpaceX;
  double _segmentSpaceY;
  @override
  void paint(Canvas canvas, Size size) {
    _maxDataY = maxData - minData;
    _maxRangeY = size.height - 30;
    _numberLine = countLine;
    _drawRatioY = _maxDataY * 1.1 / _maxRangeY;
    _maxRangeX = size.width - 30;
    _numberSeperationX = dataSet.length.toDouble();
    _segmentSpaceX = _maxRangeX / _numberSeperationX;
    _segmentSpaceY = _maxRangeY / _numberLine;

    drawArea(canvas, size);
    drawData(canvas, size);
    drawPosition(canvas, size);
  }

  double originConvertX(double x) {
    return x + 30;
  }

  double originConvertY(double y, double height) {
    return -1 * y + (height - 30);
  }

  void drawPosition(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;

    canvas.drawRect(
        Rect.fromLTRB(
            originConvertX((index - 1) * _segmentSpaceX),
            0,
            originConvertX((index + 3 * dataSet.length / 100) * _segmentSpaceX),
            size.height - 30),
        paint);
  }

  void drawData(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = lineColor;

    Path trace = Path();
    trace.moveTo(originConvertX((0) * _segmentSpaceX),
        originConvertY((dataSet[0] - minData) / _drawRatioY, size.height));

    for (int p = 0; p < dataSet.length; p++) {
      double plotPoint =
          originConvertY((dataSet[p] - minData) / _drawRatioY, size.height);
      trace.lineTo(originConvertX(p.toDouble() * _segmentSpaceX), plotPoint);
    }

    canvas.drawPath(trace, paint);
  }

  void drawArea(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = helperLineColor;
    canvas.drawLine(Offset(30, 0), Offset(30, size.height - 30), paint);
    canvas.drawLine(Offset(30, size.height - 30),
        Offset(size.width, size.height - 30), paint);

    for (int i = 0; i < countLine; i++) {
      canvas.drawLine(
          Offset(originConvertX(-5.0),
              originConvertY(i * _segmentSpaceY, size.height)),
          Offset(0.0, originConvertY(i * _segmentSpaceY, size.height)),
          paint);

      canvas.drawLine(
          Offset(originConvertX(0.0),
              originConvertY(i * _segmentSpaceY, size.height)),
          Offset(size.width, originConvertY(i * _segmentSpaceY, size.height)),
          paint);
      TextPainter text = TextPainter(
        text: TextSpan(
          text:
              ((_drawRatioY * i * _segmentSpaceY) + minData).toStringAsFixed(1),
        ),
        textDirection: TextDirection.ltr,
      );
      text.layout(minWidth: 0, maxWidth: size.width);
      text.paint(
        canvas,
        Offset(
          originConvertX(-15.0),
          originConvertY(i * _segmentSpaceY, size.height),
        ),
      );
    }
  }

  @override
  bool shouldRepaint(Graphic oldDelegate) {
    return oldDelegate.index != index;
  }
}
