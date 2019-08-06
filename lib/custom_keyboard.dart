import 'package:flutter/material.dart';
import 'package:startup_namer/keyboard/keyboard_manager.dart';
import 'package:startup_namer/keyboard/keyboard_media_query.dart';
import 'package:startup_namer/keyboard/security_keyboard.dart';

class CustomKeyboardDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomKeyboardDemoState();
  }
}

class CustomKeyboardDemoState extends State<CustomKeyboardDemo> {
  @override
  Widget build(BuildContext context) {
//    return SecurityKeyboard();
    ///用于键盘弹出的时候页面可以滚动到输入框的位置
    return WillPopScope(
        child: KeyboardMediaQuery(
          child: Builder(builder: (ctx) {
            ///初始化键盘监听并且传递当前页面的context
            KeyboardManager.init(ctx);
            return Scaffold(
                appBar: AppBar(
                  title: Text("Custom Keyboard Demo"),
                ),
                body: ListView(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.text,
                    ),
                    Container(
                      height: 100.0,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: '演示键盘'),
                      keyboardType: SecurityKeyboard.number,
                    ),
                    Container(
                      height: 200.0,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: '演示键盘弹出后滚动'),
                      keyboardType: SecurityKeyboard.numberSimple,
                    ),
                  ],
                ));
          }),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    bool b = true;
    if (KeyboardManager.isShowKeyboard) {
      KeyboardManager.hideKeyboard();
      b = false;
    }
    return Future.value(b);
  }
}
