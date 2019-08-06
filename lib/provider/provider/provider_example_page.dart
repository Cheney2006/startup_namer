import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/provider/value_provider/user.dart';
import 'package:startup_namer/utils/log_util.dart';

/// @desc 由于 Provider 只能提供恒定的数据，不能通知依赖它的子部件刷新,
/// Provider 中提供了可监听对象（Listenable 或者 Stream）及其子类的话，就会报下面这个异常警告
/// Provider()与Provider.value()区别是Provider()有一个dispose参数传递一个方法可以帮助我们销毁的时候释放资源
/// @time 2019-07-19 20:46
/// @author chenyun
class ProviderExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffoldValueProvider();
  }

  Widget _buildScaffoldValueProvider() {
    final User user = User("张三", 21);
    return Provider<User>.value(
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
