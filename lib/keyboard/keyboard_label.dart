import 'package:flutter/material.dart';
import 'package:startup_namer/keyboard/keyboard_controller.dart';
import 'package:startup_namer/utils/lcfarm_color.dart';
import 'package:startup_namer/utils/lcfarm_size.dart';
import 'package:startup_namer/utils/lcfarm_style.dart';

/// @desp: 键盘标题提示
/// @time 2019/4/3 10:39 AM
/// @author chenyun
class KeyboardLabel extends StatelessWidget {
  ///总键盘高度=键盘提示文本高度+数字键盘高度
  ///键盘提示文本高度
  static double keyboardTipHeight = LcfarmSize.dp(40);

  ///键盘监听类
  final KeyboardController controller;

  KeyboardLabel(this.controller);

  @override
  Widget build(BuildContext context) {
    return _buildKeyboardTip();
  }

  ///安全键盘提示
  Widget _buildKeyboardTip() {
    return Container(
      decoration: BoxDecoration(
        color: LcfarmColor.colorF8F9FB,
        border: Border(
          top: BorderSide(
            width: LcfarmSize.dp(0.5),
            color: LcfarmColor.colorC3C3C3,
          ),
          bottom: BorderSide(
            width: LcfarmSize.dp(0.5),
            color: LcfarmColor.colorC3C3C3,
          ),
        ),
      ),
      width: LcfarmSize.screenWidth,
      height: keyboardTipHeight,
      padding:
          EdgeInsets.only(left: LcfarmSize.dp(20), right: LcfarmSize.dp(20)),
      child: Row(
        children: <Widget>[
          Image.asset('icons/keyboard/logo_icon.png'),
          Padding(
            padding: EdgeInsets.only(left: LcfarmSize.dp(8)),
          ),
          Expanded(
            child: Text(
              '布谷农场专用键盘',
              style: LcfarmStyle.style999999_14,
            ),
          ),
          Container(
            child: GestureDetector(
              child: Center(
                child: Text(
                  '完成',
                  style: LcfarmStyle.style10BFC7_14,
                ),
              ),
              onTap: () {
                controller.doneAction();
              },
            ),
          )
        ],
      ),
    );
  }
}
