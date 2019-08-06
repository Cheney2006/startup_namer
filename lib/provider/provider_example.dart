import 'package:flutter/material.dart';

import 'change_notifier_provider/weather_info_page.dart';
import 'list/list_provider_example.dart';
import 'listeren_provider/listenable_provider_example_page.dart';
import 'multi_provider/multi_provider_example.dart';
import 'multi_provider/multi_provider_nesting_example.dart';
import 'provider/provider_example_page.dart';
import 'value_provider/value_provider_example.dart';
import 'value_provider/value_provider_obj_example.dart';

/// @desc provider 例子
///
/// Provider 仅仅是对 InheritedWidget 的一个升级
/// Provider 只能提供恒定的数据，不能通知依赖它的子部件刷新
///
/// 通过构造器绑定数据并进行监听，当从 Widget Tree 中删除时， 会自动调用dispose 进行销毁；
///
/// 1、ChangeNotifierProvider，发现与 ListenableProvider 和 ValueListenableProvider 的使用基本相同；
///class ChangeNotifierProvider<T extends ChangeNotifier>
///    extends ListenableProvider<T> implements SingleChildCloneableWidget {}
///class ChangeNotifier implements Listenable {}
///
///class ValueListenableProvider<T>
///    extends AdaptiveBuilderWidget<ValueListenable<T>, ValueNotifier<T>>
///    implements SingleChildCloneableWidget {}
///class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T> {}
///      分析源码：ChangeNotifierProvider 继承自 ListenableProvider 且对应的 ChangeNotifier 继承自 listenable；算是 ListenableProvider 的子类；ValueNotifier 继承自 ChangeNotifier 也与 ChangeNotifierProvider 相似；
///
///2、使用 ChangeNotifierProvider 和 ValueListenableProvider 绑定实体类时需要注意分别继承对应的 ChangeNotifier 和 ValueNotifier；
///class User with ChangeNotifier {}
///
///class Person extends ValueNotifier<User> {}
///
///3、无论使用那种 .value 方式，均建议在 dispose 中进行 listener 的关闭；
///@override
///void dispose() {
///    stream.dispose();
///    super.dispose();
///}
/// @time 2019-07-19 21:06
/// @author chenyun
class ProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProviderExample"),
      ),
      body: ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('Provider'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProviderExamplePage();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('ListenableProviderExample'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ListenableProviderExamplePage();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('ChangeNotifierProvider'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WeatherInfoPage();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('ValueProvider'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ValueProviderExample();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('ValueObjProvider'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ValueProviderObjExample();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('MultiProviderExample'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiProviderExample();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('MultiProviderNestingExample'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiProviderNestingExample();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                child: new Text('ListProviderExample'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ListProviderExample();
                  }));
                }),
          ),
        ],
      ),
    );
  }
}
