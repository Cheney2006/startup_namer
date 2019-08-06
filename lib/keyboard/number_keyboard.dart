import 'package:flutter/material.dart';
import 'package:startup_namer/keyboard/keyboard_controller.dart';
import 'package:startup_namer/keyboard/keyboard_label.dart';
import 'package:startup_namer/keyboard/security_keyboard.dart';
import 'package:startup_namer/utils/lcfarm_color.dart';
import 'package:startup_namer/utils/lcfarm_size.dart';
import 'package:startup_namer/utils/lcfarm_style.dart';

/// @desp: 数字键盘
/// @time 2019/4/3 10:27 AM
/// @author chenyun
class NumberKeyboard extends StatelessWidget {
  ///数字键盘高度
  static double keyboardHeight = LcfarmSize.dp(192);

  ///数字按键宽度
  static double keyWidth = (LcfarmSize.screenWidth / 3);

  ///数字按键高度
  static double keyHeight = LcfarmSize.dp(48);

  ///键盘监听类
  final KeyboardController controller;

  ///当前键盘类型
  final SecurityKeyboardType currentKeyboardType;

  ///键盘切换回调
  KeyboardSwitch keyboardSwitch;

  NumberKeyboard(this.controller, this.currentKeyboardType,
      {this.keyboardSwitch});

  bool get isNumber => currentKeyboardType == SecurityKeyboardType.number;

  bool get isNumberSimple =>
      currentKeyboardType == SecurityKeyboardType.numberSimple;

  @override
  Widget build(BuildContext context) {
    return _buildDigitKeyboard();
  }

  ///数字键盘
  Widget _buildDigitKeyboard() {
    List<Widget> childWidgets = [];
    if (!isNumberSimple) {
      childWidgets.add(KeyboardLabel(controller));
    }
    childWidgets.add(_buildKeys());
    return Material(
        child: Column(
      children: childWidgets,
    ));
  }

  Widget _buildKeys() {
    return Container(
      height: keyboardHeight,
      width: LcfarmSize.screenWidth,
      decoration: BoxDecoration(
        ///线条颜色
        color: LcfarmColor.colorC3C3C3,
      ),
      child: GridView.count(
          childAspectRatio: (keyWidth / keyHeight),
          mainAxisSpacing: LcfarmSize.dp(0.5),
          crossAxisSpacing: LcfarmSize.dp(0.5),
          padding: EdgeInsets.all(0.0),
          crossAxisCount: 3,
          children: <Widget>[
            _buildKey('1'),
            _buildKey('2'),
            _buildKey('3'),
            _buildKey('4'),
            _buildKey('5'),
            _buildKey('6'),
            _buildKey('7'),
            _buildKey('8'),
            _buildKey('9'),
            _buildDone(),
            _buildKey('0'),
            _buildBackspace(),
          ]),
    );
  }

  ///数字键盘回退按键
  Widget _buildBackspace() {
    return Container(
      color: LcfarmColor.colorD6D9DE,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Icon(Icons.backspace),
        ),
        onTap: () {
          controller.deleteOne();
        },
      ),
    );
  }

  ///纯数字键盘完成按键
  Widget _buildDone() {
    return Container(
      color: LcfarmColor.colorD6D9DE,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(
            isNumber ? 'ABC' : '完成',
            style: LcfarmStyle.style333333_16,
          ),
        ),
        onTap: () {
          if (isNumber) {
            if (keyboardSwitch != null) {
              keyboardSwitch(SecurityKeyboardType.text);
            }
          } else {
            controller.doneAction();
          }
        },
      ),
    );
  }

  ///数字按键
  Widget _buildKey(String title, {String value}) {
    if (value == null) {
      value = title;
    }
//    return Material(
//      color: LcfarmColor.colorFFFFFF,
//      child: InkWell(
//        highlightColor: LcfarmColor.colorD6D9DE,
//        child: Center(
//          child: Text(
//            title,
//            style: LcfarmStyle.style333333_24,
//          ),
//        ),
//        onTap: () {
//          controller.addText(value);
//        },
//      ),
//    );
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(
            title,
            style: LcfarmStyle.style333333_24,
          ),
        ),
        onTap: () {
          controller.addText(value);
        },
      ),
    );
  }
}
