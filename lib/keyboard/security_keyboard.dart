import 'package:flutter/material.dart';
import 'package:startup_namer/keyboard/alphabet_keyboard.dart';
import 'package:startup_namer/keyboard/keyboard_controller.dart';
import 'package:startup_namer/keyboard/keyboard_manager.dart';
import 'package:startup_namer/keyboard/number_keyboard.dart';
import 'package:startup_namer/keyboard/symbol_keyboard.dart';
import 'package:startup_namer/utils/lcfarm_size.dart';

/// @desp: 自定义键盘
/// @time 2019/3/28 4:50 PM
/// @author chenyun

typedef KeyboardSwitch = Function(SecurityKeyboardType type);

enum SecurityKeyboardType {
  text,
  textUpperCase,
  number,
  numberOnly,
  numberSimple,
  symbol
}

class SecurityKeyboard extends StatefulWidget {
  ///用于控制键盘输出的Controller
  final KeyboardController controller;

  ///键盘类型,默认文本
  final SecurityKeyboardType keyboardType;

  ///定义InputType类型
  static const SecurityTextInputType inputType =
      const SecurityTextInputType(name: 'SecurityKeyboardInputType');

  SecurityKeyboard({this.controller, this.keyboardType});

  ///文本输入类型
  static SecurityTextInputType text =
      SecurityKeyboard._inputKeyboard(SecurityKeyboardType.text);

  ///数字输入类型
  static SecurityTextInputType number =
      SecurityKeyboard._inputKeyboard(SecurityKeyboardType.number);

  ///仅数字输入类型
  static SecurityTextInputType numberOnly =
      SecurityKeyboard._inputKeyboard(SecurityKeyboardType.numberOnly);

  ///仅数字输入类型,且没有键盘提示
  static SecurityTextInputType numberSimple =
      SecurityKeyboard._inputKeyboard(SecurityKeyboardType.numberSimple);

  ///初始化键盘类型，返回输入框类型
  static SecurityTextInputType _inputKeyboard(
      SecurityKeyboardType securityKeyboardType) {
    ///注册键盘的方法
    String inputType = securityKeyboardType.toString();
    SecurityTextInputType securityTextInputType =
        SecurityTextInputType(name: inputType);
    KeyboardManager.addKeyboard(
      securityTextInputType,
      KeyboardConfig(
        builder: (context, controller) {
          return SecurityKeyboard(
            controller: controller,
            keyboardType: securityKeyboardType,
          );
        },
        getHeight: () {
          return SecurityKeyboard.getHeight(securityKeyboardType);
        },
      ),
    );

    return securityTextInputType;
  }

  ///键盘类型
  SecurityKeyboardType get _keyboardType => keyboardType;

  ///编写获取高度的方法
  static double getHeight(SecurityKeyboardType securityKeyboardType) {
//    MediaQueryData mediaQuery = MediaQuery.of(ctx);
//    return mediaQuery.size.width / 3 / 2 * 4;

//    return LcfarmSize.dp(48) * 4 + LcfarmSize.dp(40);
    return securityKeyboardType == SecurityKeyboardType.numberSimple
        ? LcfarmSize.dp(192)
        : LcfarmSize.dp(232);
  }

  ///注册键盘的方法
  static register() {
//    KeyboardManager.addKeyboard(
//      inputType,
//      KeyboardConfig(
//        builder: (context, controller) {
//          return SecurityKeyboard(controller: controller);
//        },
//        getHeight: SecurityKeyboard.getHeight,
//      ),
//    );
  }

  @override
  _SecurityKeyboardState createState() => _SecurityKeyboardState();
}

class _SecurityKeyboardState extends State<SecurityKeyboard> {
  ///当前键盘类型
  SecurityKeyboardType currentKeyboardType;

  @override
  void initState() {
    super.initState();
    currentKeyboardType = widget._keyboardType;
  }

  @override
  Widget build(BuildContext context) {
    Widget keyboard;
    switch (currentKeyboardType) {
      case SecurityKeyboardType.number:
        keyboard = NumberKeyboard(
          widget.controller,
          currentKeyboardType,
          keyboardSwitch: (SecurityKeyboardType keyboardType) {
            setState(() {
              currentKeyboardType = keyboardType;
            });
          },
        );
        break;
      case SecurityKeyboardType.numberOnly:
      case SecurityKeyboardType.numberSimple:
        keyboard = NumberKeyboard(widget.controller, currentKeyboardType);
        break;
      case SecurityKeyboardType.symbol:
        keyboard = SymbolKeyboard(widget.controller,
            (SecurityKeyboardType keyboardType) {
          setState(() {
            currentKeyboardType = keyboardType;
          });
        });
        break;
      case SecurityKeyboardType.text:
      case SecurityKeyboardType.textUpperCase:
        keyboard = AlphabetKeyboard(widget.controller, currentKeyboardType,
            (SecurityKeyboardType keyboardType) {
          setState(() {
            currentKeyboardType = keyboardType;
          });
        });
        break;
    }
    return keyboard;
  }
}
