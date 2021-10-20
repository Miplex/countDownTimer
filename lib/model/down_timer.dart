import 'dart:async';

import 'package:flutter/material.dart';

class DownTimer with ChangeNotifier {
  int _timerSecond = 1;
  int _index = 0;
  double _scrollOpacity = 1.0;
  double _countdownOpacity = 0.0;
  bool _visible = true;

  bool get getVisibleButton => _visible;

  double get getScrollOpacity => _scrollOpacity;

  double get getCountDownOpacity => _countdownOpacity;

  int get getIndex => _index;

  int get getData => _timerSecond;

  List _list = List.generate(13, (int index) => index == 0 ? 1 : index * 5);

  List get getSecond => _list;

  void countDownTime() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerSecond == 0) {
        _countdownOpacity = 0.0;
        _scrollOpacity = 1.0;
        // _visible = true;
        visibleButton();
        timer.cancel();
        print(_timerSecond);
        notifyListeners();
      } else {
        // _visible = false;
        visibleButton();
        _countdownOpacity = 1.0;
        _scrollOpacity = 0.0;
        _timerSecond--;
        notifyListeners();
      }
    });
  }

  addIndex(int index) {
    _index = index;
    _timerSecond = index == 0 ? 1 : index * 5;
    notifyListeners();
  }

  void visibleButton() {
    if (_scrollOpacity == 1.0) {
      _visible = true;
    } else if (_scrollOpacity == 0.0) {
      _visible = false;
    }
    notifyListeners();
  }
}
