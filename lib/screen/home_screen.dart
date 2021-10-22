import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/down_timer.dart';
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
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  height: _controller.value * _height,
                  width: _width,
                  color: kPrimaryColor,
                  child: child,
                );
              },
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
                int index = (context).read<DownTimer>().getIndex;

                (context).read<DownTimer>().addIndex(index);

                _controller.forward();

                Future.delayed(const Duration(seconds: 1), () {
                  _controller.duration =
                      Duration(seconds: (context).read<DownTimer>().getData);
                  _controller.reverse();
                  _controller.duration = Duration(seconds: 1);
                });
                if (_controller.isAnimating) {
                  (context).read<DownTimer>().countDownTime();
                }
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
