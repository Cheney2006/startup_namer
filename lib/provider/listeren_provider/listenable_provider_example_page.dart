import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/log_util.dart';

import 'user.dart';

/// @desc ListenableProvider 提供（provide）的对象是继承了 Listenable 抽象类的子类。由于无法混入
/// 所以通过继承来获得 Listenable 的能力，同时必须实现其 addListener / removeListener 方法，手动管理收听者。
/// ListenableProvider()与ValueListenableProvider()差不多，但ListenableProvider()多了一个dispose参数，需要自己传，在销毁的时候调用释放资源
/// ListenableProvider是ChangeNotifierProvider的父类， ListenableProvider.value()和ChangeNotifierProvider.value()功能一样
/// @time 2019-07-19 20:46
/// @author chenyun
class ListenableProviderExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffoldValueProvider();
  }

  Widget _buildScaffoldValueProvider() {
    final User user = User("张三", 21);
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
