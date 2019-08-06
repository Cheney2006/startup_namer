import 'package:flutter/material.dart';
import 'package:startup_namer/utils/log_util.dart';

/// @desp: todo
/// @time 2019/4/12 5:00 PM
/// @author chenyun
class LifecycleAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LifecycleAppPageState('构造函数');
  }
}

class _LifecycleAppPageState extends State<LifecycleAppPage>
    with WidgetsBindingObserver {
  String str;

  int count = 0;

  _LifecycleAppPageState(this.str);

  @override
  void initState() {
    LogUtil.v(str);
    LogUtil.v('initState');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    LogUtil.v('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(LifecycleAppPage oldWidget) {
    LogUtil.v('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    LogUtil.v('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    LogUtil.v('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        LogUtil.v('AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
        LogUtil.v('AppLifecycleState.paused');
        break;
      case AppLifecycleState.resumed:
        LogUtil.v('AppLifecycleState.resumed');
        break;
      case AppLifecycleState.suspending:
        LogUtil.v('AppLifecycleState.suspending');
        break;
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v('build');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('lifecycle 学习'),
        centerTitle: true,
      ),
      body: new OrientationBuilder(
        builder: (context, orientation) {
          return new Center(
            child: new Text(
              '当前计数值：$count',
              style: new TextStyle(
                  color: orientation == Orientation.portrait
                      ? Colors.blue
                      : Colors.red),
            ),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Text('click'),
          onPressed: () {
            count++;
            setState(() {});
          }),
    );
  }
}

class LifecyclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new LifecycleAppPage(),
    );
  }
}
