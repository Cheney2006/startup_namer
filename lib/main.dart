import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:startup_namer/FirstDemo.dart';
import 'package:startup_namer/LcfarmSizeTest.dart';
import 'package:startup_namer/MyLayout.dart';
import 'package:startup_namer/custom_keyboard.dart';
import 'package:startup_namer/lifecycle_page.dart';
import 'package:startup_namer/msg_dispatch/msg_diapatch.dart';
import 'package:startup_namer/toast/toast.dart';
import 'package:startup_namer/utils/log_util.dart';

import 'provider/provider_example.dart';

void main() {
//  debugPaintSizeEnabled = true;

  LogUtil.init(isDebug: true);

  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //如果状态管理放在顶层 MaterialApp 之上，它的作用域是全局，任何界面都可以获取;
//    return ChangeNotifierProvider<WeatherInfo>(
//      builder: (_) => WeatherInfo(),
//      child: MaterialApp(
//        title: '首页',
//        home: _HomeApp(),
//      ),
//    );
//
    return MaterialApp(
      title: '首页',
      home: _HomeApp(),
    );
  }
}

class _HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('Fist Demo'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyApp();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('布局 demo'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyLayout();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('屏幕适配'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LcfarmSizeTest();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('Toast'),
                onPressed: () {
                  Toast.show(context: context, message: '两秒后消失');
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('自定义键盘'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CustomKeyboardDemo();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('消息传递'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MsgDispatch();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('生命周期'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LifecyclePage();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('Provider'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProviderExample();
                  }));
                }),
          ),
        ],
      ),
    );
  }
}
