import 'package:flutter/material.dart';
import 'package:startup_namer/keyboard/keyboard_controller.dart';
import 'package:startup_namer/keyboard/keyboard_label.dart';
import 'package:startup_namer/keyboard/security_keyboard.dart';
import 'package:startup_namer/utils/lcfarm_color.dart';
import 'package:startup_namer/utils/lcfarm_icon.dart';
import 'package:startup_namer/utils/lcfarm_size.dart';
import 'package:startup_namer/utils/lcfarm_style.dart';

/// @desp: 字母键盘
/// @time 2019/4/3 10:44 AM
/// @author chenyun
class AlphabetKeyboard extends StatelessWidget {
  /// 键盘字母表
  static final List<String> alphabets = [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm'
  ];

  ///字母键盘 padding(左、右)
  static double keyboardPadding = LcfarmSize.dp(5);

  ///字母按钮间距
  static double keyPadding = LcfarmSize.dp(4);

  ///字母按钮间距
  static double rowPadding = LcfarmSize.dp(8);

  ///字母按键宽度=屏幕宽度-（左、右）键盘间距- （第一行10个按键）9个按键间距
  static double keyWidth =
      ((LcfarmSize.screenWidth - 2 * keyboardPadding - 9 * keyPadding) / 10);

  ///字母按键高度，按键下间距为8dp
  static double keyHeight = LcfarmSize.dp(38);

  ///算出大小写切换，回退按键大小
  static double shiftWidth = ((LcfarmSize.screenWidth -
          keyWidth * 7 -
          keyPadding * 8 -
          keyboardPadding * 2) /
      2);

  ///数字、标点切换按键宽度
  static double switchWidth = shiftWidth + keyWidth + keyPadding;

  ///空格按键宽度
  static double spaceWidth = LcfarmSize.screenWidth -
      switchWidth * 2 -
      keyboardPadding * 2 -
      keyPadding * 2;

  ///键盘监听类
  final KeyboardController controller;

  ///当前键盘类型
  final SecurityKeyboardType keyboardType;

  ///键盘切换回调
  final KeyboardSwitch keyboardSwitch;

  const AlphabetKeyboard(
      this.controller, this.keyboardType, this.keyboardSwitch);

  bool get isUpperCase => keyboardType == SecurityKeyboardType.textUpperCase;

  @override
  Widget build(BuildContext context) {
    return __buildKeyboard();
  }

  ///字母键盘
  Widget __buildKeyboard() {
    return Material(
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          KeyboardLabel(controller),
          Padding(padding: EdgeInsets.only(bottom: rowPadding)),
          _buildFirstRow(),
          Padding(padding: EdgeInsets.only(bottom: rowPadding)),
          _buildSecondRow(),
          Padding(padding: EdgeInsets.only(bottom: rowPadding)),
          _buildThirdRow(),
          Padding(padding: EdgeInsets.only(bottom: rowPadding)),
          _buildFourRow(),
          Padding(padding: EdgeInsets.only(bottom: rowPadding)),
        ],
      ),
    );
  }

  ///字母键盘第一行（10个q-p）
  Widget _buildFirstRow() {
    List<Widget> childWidgets = [];
    List<String> keys = alphabets.sublist(0, 10);
//    firstRowKeys.forEach((key) {});
    ///左边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    for (int i = 0, len = keys.length; i < len; i++) {
      childWidgets.add(__buildKey(keys[i]));
      if (i < keys.length - 1) {
        ///最后一个无需设置边距，外层已经设置了左右边间
        childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));
      }
    }

    ///右边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    return Row(
      ///单独使用可以起作用，但放在键盘里面就不行。。。
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childWidgets,
    );
  }

  ///字母键盘第二行（9个a-l）
  Widget _buildSecondRow() {
    List<Widget> childWidgets = [];

    ///左边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    List<String> keys = alphabets.sublist(10, 19);
    for (int i = 0, len = keys.length; i < len; i++) {
      childWidgets.add(__buildKey(keys[i]));
      if (i < keys.length - 1) {
        ///最后一个无需设置边距，外层已经设置了左右边间
        childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));
      }
    }

    ///右边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: childWidgets,
    );
  }

  ///字母键盘第三行（大写切换、7个z-m、回退）
  Widget _buildThirdRow() {
    List<Widget> childWidgets = [];

    ///左边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));

    ///大小写切换
    childWidgets.add(_buildShift());
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));

    ///字母 z-m
    List<String> keys = alphabets.sublist(19);
    for (int i = 0, len = keys.length; i < len; i++) {
      childWidgets.add(__buildKey(keys[i]));
      childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));
    }

    ///回退按键
    childWidgets.add(_buildBackspace());

    ///右边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childWidgets,
    );
  }

  ///字母键盘第四行数字切换键+空格键+符号切换键
  Widget _buildFourRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: keyboardPadding)),
        _buildSwitch('123', SecurityKeyboardType.number),
        Padding(padding: EdgeInsets.only(left: keyPadding)),
        _buildSpace(),
        Padding(padding: EdgeInsets.only(left: keyPadding)),
        _buildSwitch('#+=', SecurityKeyboardType.symbol),
        Padding(padding: EdgeInsets.only(left: keyboardPadding)),
      ],
    );
  }

  ///字母键盘中数字切换键
  Widget _buildSwitch(String txt, SecurityKeyboardType type) {
    return Container(
      height: keyHeight,
      width: switchWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(LcfarmSize.dp(5))),
        color: LcfarmColor.colorFFFFFF,
        border: Border.all(
            color: LcfarmColor.colorC3C3C3, width: LcfarmSize.dp(0.5)),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(
            txt,
            style: LcfarmStyle.style333333_16,
          ),
        ),
        onTap: () {
          keyboardSwitch(type);
        },
      ),
    );
  }

  ///字母键盘中数字切换键
  Widget _buildSpace() {
    ///使用Expanded 报错，单独使用可以起作用，但放在键盘里面就不行。。
    return Container(
      height: keyHeight,
      width: spaceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(LcfarmSize.dp(5))),
        color: LcfarmColor.colorFFFFFF,
        border: Border.all(
            color: LcfarmColor.colorC3C3C3, width: LcfarmSize.dp(0.5)),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(
            '空格',
            style: LcfarmStyle.style333333_16,
          ),
        ),
        onTap: () {
          controller.addText(" ");
        },
      ),
    );
  }

  ///数字键盘回退按键
  Widget _buildShift() {
    return Container(
      height: keyHeight,
      width: shiftWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(LcfarmSize.dp(5))),
        color: LcfarmColor.colorD6D9DE,
        border: Border.all(
            color: LcfarmColor.colorC3C3C3, width: LcfarmSize.dp(0.5)),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Icon(
            isUpperCase
                ? LcfarmIcon.icon_shift_pressed
                : LcfarmIcon.icon_shift_normal,
            color: LcfarmColor.color333333,
            size: LcfarmSize.dp(18),
          ),
        ),
        onTap: () {
          keyboardSwitch(SecurityKeyboardType.textUpperCase);
        },
      ),
    );
  }

  ///字母键盘回退按键
  Widget _buildBackspace() {
    return Container(
      height: keyHeight,
      width: shiftWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(LcfarmSize.dp(5))),
        color: LcfarmColor.colorD6D9DE,
        border: Border.all(
            color: LcfarmColor.colorC3C3C3, width: LcfarmSize.dp(0.5)),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Icon(
            Icons.backspace,
            color: LcfarmColor.color333333,
            size: LcfarmSize.dp(18),
          ),
        ),
        onTap: () {
          controller.deleteOne();
        },
      ),
    );
  }

  /// 字母按键,最后一个没有右边距
  Widget __buildKey(String title, {String value}) {
    if (value == null) {
      value = title;
    }
    return Container(
      width: keyWidth,
      height: keyHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(LcfarmSize.dp(5))),
        color: LcfarmColor.colorFFFFFF,
        border: Border.all(
            color: LcfarmColor.colorC3C3C3, width: LcfarmSize.dp(0.5)),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(
            isUpperCase ? title.toUpperCase() : title,
            style: LcfarmStyle.style333333_22,
          ),
        ),
        onTap: () {
          controller.addText(isUpperCase ? value.toUpperCase() : value);
        },
      ),
    );
  }
}
