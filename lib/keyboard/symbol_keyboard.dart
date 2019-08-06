import 'package:flutter/material.dart';
import 'package:startup_namer/keyboard/keyboard_controller.dart';
import 'package:startup_namer/keyboard/keyboard_label.dart';
import 'package:startup_namer/keyboard/security_keyboard.dart';
import 'package:startup_namer/utils/lcfarm_color.dart';
import 'package:startup_namer/utils/lcfarm_size.dart';
import 'package:startup_namer/utils/lcfarm_style.dart';

/// @desp: 符号键盘
/// @time 2019/4/3 1:53 PM
/// @author chenyun
class SymbolKeyboard extends StatelessWidget {
  static final List<String> symbols = [
    "[",
    "]",
    "{",
    "}",
    "#",
    "%",
    "^",
    "*",
    "+",
    "=",
    "-",
    "_",
    ":",
    ";",
    "(",
    ")",
    "\$",
    "&",
    "@",
    "~",
    "/",
    "|",
    "\\",
    ",",
    ".",
    "?",
    "'",
    "\"",
    "!",
    "`",
    "<",
    ">"
  ];

  ///符号键盘 padding(左、右)
  static double keyboardPadding = LcfarmSize.dp(5);

  ///符号按钮间距
  static double keyPadding = LcfarmSize.dp(4);

  ///符号按钮间距
  static double rowPadding = LcfarmSize.dp(8);

  ///符号按键宽度=屏幕宽度-（左、右）键盘间距- （第一行10个按键）9个按键间距
  static double keyWidth =
      ((LcfarmSize.screenWidth - 2 * keyboardPadding - 9 * keyPadding) / 10);

  ///符号按键高度，按键下间距为8dp
  static double keyHeight = LcfarmSize.dp(38);

  ///符号键盘回退按键宽度
  static double backspaceWidth = keyWidth * 2 + keyPadding;

  ///数字、字母表切换按键宽度
  static double switchWidth = ((LcfarmSize.screenWidth -
          2 * keyboardPadding -
          4 * keyWidth -
          5 * keyPadding) /
      2);

  ///键盘监听
  final KeyboardController controller;

  ///键盘切换
  final KeyboardSwitch keyboardSwitch;

  const SymbolKeyboard(this.controller, this.keyboardSwitch);

  @override
  Widget build(BuildContext context) {
    return _buildKeyboard();
  }

  Widget _buildKeyboard() {
    return Material(
      child: Column(
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

  ///符号键盘第一行10个符号按键
  Widget _buildFirstRow() {
    List<String> keys = symbols.sublist(0, 10);
    return _buildSymbolRow(keys);
  }

  ///符号键盘第二行10个符号按键
  Widget _buildSecondRow() {
    List<String> keys = symbols.sublist(10, 20);
    return _buildSymbolRow(keys);
  }

  ///符号键盘第三行8个符号按键+回退键
  Widget _buildThirdRow() {
    List<Widget> childWidgets = [];

    ///左边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));

    ///符号按键与间距
    List<String> keys = symbols.sublist(20, 28);
    childWidgets = _buildKeys(childWidgets, keys);

    ///回退按键间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));

    ///回退按键
    childWidgets.add(_buildBackspace());

    ///右边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childWidgets,
    );
  }

  ///符号键盘第四行数字切换键+4个符号按键+字母切换键
  Widget _buildFourRow() {
    List<Widget> childWidgets = [];

    ///左边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));

    ///数字切换按键
    childWidgets.add(_buildSwitch('123', SecurityKeyboardType.number));

    ///数字切换按键间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));

    ///符号按键与间距
    List<String> keys = symbols.sublist(28);
    childWidgets = _buildKeys(childWidgets, keys);

    ///字母切换按键间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));

    ///字母切换按键
    childWidgets.add(_buildSwitch('ABC', SecurityKeyboardType.text));

    ///右边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childWidgets,
    );
  }

  ///符号键盘行
  Widget _buildSymbolRow(List<String> keys) {
    List<Widget> childWidgets = [];

    ///左边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));

    ///符号按键与间距
    childWidgets = _buildKeys(childWidgets, keys);

    ///右边间距
    childWidgets.add(Padding(padding: EdgeInsets.only(left: keyboardPadding)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childWidgets,
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

  ///符号键盘回退键
  Widget _buildBackspace() {
    return Container(
      height: keyHeight,
      width: backspaceWidth,
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

  ///符号按键与间距
  List<Widget> _buildKeys(List<Widget> widgets, List<String> keys) {
    for (int i = 0, len = keys.length; i < len; i++) {
      widgets.add(_buildKey(keys[i]));
      if (i < keys.length - 1) {
        ///最后一个无需设置边距，外层已经设置了左右边间
        widgets.add(Padding(padding: EdgeInsets.only(left: keyPadding)));
      }
    }
    return widgets;
  }

  ///符号按键
  Widget _buildKey(String title, {String value}) {
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
            title,
            style: LcfarmStyle.style333333_22,
          ),
        ),
        onTap: () {
          controller.addText(value);
        },
      ),
    );
  }
}
