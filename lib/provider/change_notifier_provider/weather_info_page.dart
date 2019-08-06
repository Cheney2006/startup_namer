import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/log_util.dart';

import 'weather_info.dart';
import 'weather_info_page2.dart';

/// @desc 使用Provider.of(context)，简单易用，但是要数据发生变化时，会进行页面级别rebuild，相当于stfulWidget
/// //此方法将从BuildContext关联的小部件树中查找，它将返回找到的最近的类型变量T
///Provider.of<T>( BuildContext context,
///     {bool listen = true}//listen：默认true监听状态变化，false为不监听状态改变
///)
///也可以使用Consumer组件获取，Consumer可用在没有context的地方，还可以优化性能
///Consumer<T>({
///    @required this.builder,//这边写布局
///    this.child,//可以控制刷新性能优化，当数据数据发生改变，不会重新build，
///  })
/// @time 2019-07-19 16:49
/// @author chenyun

class WeatherInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage build");
    return ChangeNotifierProvider(
      builder: (context) => WeatherInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Provider demo${Random().nextInt(100)}"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "我在ChangeNotifierProvider中，看我变不变${Random().nextInt(100)}"),
              ),
              MyHeader(),
              MyHeaderListenerFalse(),
              MyContent(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WeatherInfoPage2();
                    }));
                  },
                  child: Text("consumer 例子"),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(),
      ),
    );
    //全局状态
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Provider demo${Random().nextInt(100)}"),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.all(8.0),
//              child: Text("看我变不变${Random().nextInt(100)}"),
//            ),
//            MyHeader(),
//            MyContent(),
//            Padding(
//              padding: EdgeInsets.all(8.0),
//              child: RaisedButton(
//                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) {
//                    return WeatherInfoPage2();
//                  }));
//                },
//                child: Text("consumer 例子"),
//              ),
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: MyFloatingActionButton(),
//    );
  }
}

class MyHeaderListenerFalse extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage MyHeader build");

    WeatherInfo weatherInfo = Provider.of<WeatherInfo>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "我是类中的temperatureType=${weatherInfo.temperatureType}",
        style: TextStyle(
          color: decideColor(weatherInfo),
          fontSize: 20,
        ),
      ),
    );
  }
}

class MyHeader extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage MyHeader build");

    WeatherInfo weatherInfo = Provider.of<WeatherInfo>(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "我是类中的temperatureType=${weatherInfo.temperatureType}",
        style: TextStyle(
          color: decideColor(weatherInfo),
          fontSize: 20,
        ),
      ),
    );
  }
}

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage MyContent build");

    WeatherInfo weatherInfo = Provider.of<WeatherInfo>(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("我是类中的temperatureVal=${weatherInfo.temperatureVal}"),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage MyFloatingActionButton build");
    WeatherInfo weatherInfo = Provider.of<WeatherInfo>(context);
    return FloatingActionButton(
      backgroundColor: decideColor(weatherInfo),
      onPressed: () {
        String newWeatherType =
            "celcius" == weatherInfo.temperatureType ? "far" : "celcius";
        weatherInfo.temperatureType = newWeatherType;
        weatherInfo.temperatureVal = ++weatherInfo.temperatureVal;
      },
      tooltip: "change type",
      child: Icon(Icons.change_history),
    );
  }
}
