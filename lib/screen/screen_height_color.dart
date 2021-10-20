import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/down_timer.dart';
import 'package:provider/src/provider.dart';
import '../constants.dart';

class HeightColor extends StatefulWidget {
  @override
  State<HeightColor> createState() => _HeightColorState();
}

class _HeightColorState extends State<HeightColor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: (context).watch<DownTimer>().getData),
    vsync: this,
  );
  late final Animation<double> animation =
      Tween<double>(begin: 0.0, end: height()).animate(_controller);

  height() {
    double _height = MediaQuery.of(context).size.height;

    return _height;
  }

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: Duration(seconds: (context).read<DownTimer>().getData),
    //   vsync: this,
    // );

    // _controller.forward();

    print((context).read<DownTimer>().getData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    //double _height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Container(
              height: animation.value,
              width: _width,
              color: kPrimaryColor,
              child: child,
            );
          },
        ),
      ],
    );
  }
}


// Center(
//           child: TextButton(
//               onPressed: () {
//                 if (animation.status == AnimationStatus.completed) {
//                   _controller.reverse();
//                 } else {
//                   _controller.forward();
//                 }
//                 print(_controller.value);
//               },
//               child: Text('click')),
//         ),