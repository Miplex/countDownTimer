import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/down_timer.dart';
//import 'package:flutter_application_1/screen/screen_height_color.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'scroll.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> animation =
      Tween<double>(begin: 0.0, end: height()).animate(_controller);

  double height() {
    double _height = MediaQuery.of(context).size.height;

    return _height;
  }

  int changeSecond() {
    int second = (context).read<DownTimer>().getData;
    // print(second);
    return second;
  }

  void changeBackground() {
    if (animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Container(
                  height: animation.value,
                  width: _width,
                  color: kPrimaryColor,
                  child: child,
                );
              },
              //child: HeightColor())
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Scrolling(),
              SizedBox(
                height: 100.0,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: (context).watch<DownTimer>().getScrollOpacity,
        child: Visibility(
          visible: (context).watch<DownTimer>().getVisibleButton,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 120.0),
            child: FloatingActionButton(
              onPressed: () {
                // _clicked == true;
                int index = (context).read<DownTimer>().getIndex;

                (context).read<DownTimer>().countDownTime();
                (context).read<DownTimer>().addIndex(index);
                // changeBackground();
                // changeSecond();
                //context.read<DownTimer>().screenHeightColor();
                print(_controller.value);
              },
              backgroundColor: kPrimaryColor,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
