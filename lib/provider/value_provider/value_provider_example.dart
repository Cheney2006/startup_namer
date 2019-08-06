import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/provider/value_provider/person.dart';
import 'package:startup_namer/utils/log_util.dart';

/// @desc ValueListenableProvider，它只支持单一数据的监听，
/// 有两种方式，一种ValueListenableProvider.value()，另一种ValueListenableProvider()，两种方式几乎是相同的。
/// @time 2019-07-19 20:46
/// @author chenyun
class ValueProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildScaffoldValueProvider();
  }

  Widget _buildBodyValueProvider() {
    ValueNotifier<int> count = ValueNotifier(0);
    return Scaffold(
      appBar: AppBar(
        title: Text("ValueProviderExample"),
      ),
      body: ValueListenableProvider.value(
        value: count,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<int>(
                builder: (context, val, _) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("当前下标为$val"),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<int>(builder: (context, val, _) {
        return FloatingActionButton(
          backgroundColor: decideColor(val),
          onPressed: () {
            count.value = ++val;
          },
          child: Icon(Icons.change_history),
        );
      }),

      //这里取不到 状态，因为没有包含在里面
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          count.value += 1;
//        },
//        child: Icon(Icons.change_history),
//      ),
    );
  }

  Widget _buildSimpleScaffoldValueProvider() {
    ValueNotifier<int> count = ValueNotifier(0);
    return ValueListenableProvider<int>.value(
      value: count,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ValueProviderExample"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<int>(
                builder: (context, val, _) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("当前下标为$val"),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Consumer<int>(builder: (context, val, _) {
          return FloatingActionButton(
            backgroundColor: decideColor(val),
            onPressed: () {
              count.value = ++val;
            },
            child: Icon(Icons.change_history),
          );
        }),
      ),
    );
  }

  Widget _buildScaffoldValueProvider() {
//    ValueNotifier<int> count = ValueNotifier(0);
    final Person person = Person("张三");
    return ValueListenableProvider<String>.value(
      value: person,
      updateShouldNotify: (String previous, String current) {
        return previous != current;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("ValueProviderExample"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<String>(
                builder: (context, val, _) {
                  LogUtil.v("=====${person.getPersonName}");
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("当前用户为$val"),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Consumer<String>(builder: (context, val, _) {
          return FloatingActionButton(
            backgroundColor: decideColor(Random().nextInt(100)),
            onPressed: () {
//              val.age = ++val.age;
//              val.setName("李四${Random().nextInt(100)}");
//              LogUtil.v("age=${val.age},name=${val.name}");
//              person.value = val;
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
