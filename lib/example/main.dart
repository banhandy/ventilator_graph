import 'package:ventilatorgraph/ventilatorgraph.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Ventilator Graph Display Example",
      home: GraphVentilator(),
    );
  }
}

class GraphVentilator extends StatefulWidget {
  static String id = 'Graph Ventilator';

  @override
  _GraphVentilatorState createState() => _GraphVentilatorState();
}

class _GraphVentilatorState extends State<GraphVentilator> {
  int index = 0;
  double maxData = 1;
  double minData = -1;
  int dataWidth = 100;
  int lineSegment = 2;
  List dataSetPressure = List();
  List dataSetFlow = List();
  double radians = 0.0;
  Timer _timer;

  ///generate sample data using sines and cosines wave
  _generateData(Timer t) {
    var sv = sin((radians * pi));
    var cv = cos((radians * pi));

    ///move the pointer along the grapht and add data to the current pointer
    setState(() {
      index++;
      if (index == dataWidth) {
        index = 0;
      }
      dataSetPressure[index.toInt()] = sv;
      dataSetFlow[index.toInt()] = cv;
    });

    radians += 0.05;
    if (radians >= 2.0) {
      radians = 0.0;
    }
  }

  List generateDataSet(int maxData) {
    List dataSet = List();
    for (int i = 0; i < dataWidth; i++) {
      dataSet.add(maxData);
    }
    return dataSet;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// populate our data set
    dataSetPressure = generateDataSet(maxData.toInt());
    dataSetFlow = generateDataSet(maxData.toInt());

    /// start moving the pointer
    _timer = Timer.periodic(Duration(milliseconds: 60), _generateData);
  }

  @override
  Widget build(BuildContext context) {
    //dataSet = generateDataSet(maxData.toInt());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GraphWithPointer(
                index: index,
                maxY: maxData,
                minY: minData,
                totalSegmentY: lineSegment,
                dataSet: dataSetPressure,
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                lineColor: Colors.blueAccent,
                segmentYColor: Colors.white,
              ),
            ),
            Expanded(
              child: GraphWithPointer(
                index: index,
                maxY: maxData,
                minY: minData,
                totalSegmentY: lineSegment,
                dataSet: dataSetFlow,
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                lineColor: Colors.yellowAccent,
                segmentYColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
