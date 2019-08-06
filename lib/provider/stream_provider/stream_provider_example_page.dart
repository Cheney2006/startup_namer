import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/log_util.dart';

import 'user.dart';

/// @desc Stream 存在于 Dart:async 库中，主要用于处理异步操作
/// 通过 StreamController()…sink.add() 输入需要处理的数据，通过 StreamController()…stream 输出处理后的数据；
/// 整个过程都需要通过 StreamController 来控制
/// @time 2019-07-19 20:46
/// @author chenyun
class ListenableProviderExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffoldValueProvider();
  }

  Widget _buildScaffoldValueProvider() {
    final User user = User("张三", 21);
    StreamProvider(builder: null);
    return ListenableProvider<User>.value(
      value: user,
//      updateShouldNotify: (User previous, User current) {
//        return previous.name != current.name;
//      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ValueProviderExample"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<User>(
                builder: (context, val, _) {
                  LogUtil.v("=====${user.name}");
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("当前用户为名称=${val.name},年龄=${val.age}"),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Consumer<User>(builder: (context, val, _) {
          return FloatingActionButton(
            backgroundColor: decideColor(val.age),
            onPressed: () {
              user.age = ++val.age;
              user.setName("李四${Random().nextInt(100)}");
            },
            child: Icon(Icons.change_history),
          );
        }),
      ),
    );
  }
}

Color decideColor(int i) {
  return (i % 2 == 0) ? Colors.green : Colors.deepOrange;
}
