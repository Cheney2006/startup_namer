import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/log_util.dart';

import 'person_user.dart';
import 'user.dart';

/// @desc ValueListenableProvider，它只支持单一数据的监听，
/// 有两种方式，一种ValueListenableProvider.value()，另一种ValueListenableProvider()，两种方式几乎是相同的。
/// @time 2019-07-19 20:46
/// @author chenyun
class ValueProviderObjExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffoldValueProvider();
  }

  ///todo 这里不生效
  Widget _buildScaffoldValueProvider() {
    final PersonUser person = PersonUser(User("张三", 21));
    return ValueListenableProvider<User>.value(
      value: person,
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
                  LogUtil.v("=====${person.getPersonName}");
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
              //这里必须重新生成一个新对象,不能使用 val，不然不会生效。。。
              User user = User("李四${Random().nextInt(100)}", ++val.age);
              LogUtil.v("age=${user.age},name=${user.name}");
//              person.value = user;
              person.setPersonName("李四${Random().nextInt(100)}");
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
