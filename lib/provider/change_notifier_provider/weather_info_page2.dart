import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/log_util.dart';

import '../../MyLayout.dart';
import 'weather_info.dart';

/// @desc 使用Consumer，Consumer比Provider.of(context)复杂一点，但是对于app性能的提高却有些很好的作用，
/// 当状态发生变化时，widget树会更新指定的节点，极小程度进行控件刷新，不会进行整颗widget树的更新
/// @time 2019-07-19 16:49
/// @author chenyun

class WeatherInfoPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage2 build");
    WeatherInfo weatherInfo = WeatherInfo();
    return ChangeNotifierProvider(
      builder: (context) => weatherInfo,
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
//              _buildHeader(),
//              MyContent(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyLayout();
                    }));
                  },
                  child: Text("其它界面"),
                ),
              ),
            ],
          ),
        ),
//        floatingActionButton: MyFloatingActionButton(),
        floatingActionButton: Consumer<WeatherInfo>(
          builder: (BuildContext context, WeatherInfo info, Widget child) {
            return FloatingActionButton(
              backgroundColor: _decideColor(info),
              onPressed: () {
                String newWeatherType = "celcius" == weatherInfo.temperatureType
                    ? "far"
                    : "celcius";
                weatherInfo.temperatureType = newWeatherType;
                weatherInfo.temperatureVal = ++weatherInfo.temperatureVal;
              },
              child: Icon(Icons.change_history),
            );
          },
        ),
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
//          ],
//        ),
//      ),
//      floatingActionButton: MyFloatingActionButton(),
//    );
  }
}

Widget _buildHeader() {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("我在Consumer外层，看我变不变${Random().nextInt(100)}"),
      ),
      Consumer<WeatherInfo>(
        builder: (context, weatherInfo, child) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                child,
                Text(
                  "我是方法中的temperatureType=${weatherInfo.temperatureType}",
                  style: TextStyle(
                    color: _decideColor(weatherInfo),
                    fontSize: 20,
                  ),
                )
              ],
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("我在Consumer的 child，看我变不变${Random().nextInt(100)}"),
        ),
      ),
    ],
  );
}

Color _decideColor(WeatherInfo info) {
  return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
}

class MyHeader extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage2 MyHeader build");

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("我在Consumer外层，看我变不变${Random().nextInt(100)}"),
        ),
        Consumer<WeatherInfo>(
          builder: (context, weatherInfo, child) {
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
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("=====我在Consumer的 child，看我变不变${Random().nextInt(100)}"),
          ),
        ),
      ],
    );
  }
}

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage2 MyContent build");

    return Consumer<WeatherInfo>(
      builder: (BuildContext context, WeatherInfo weatherInfo, Widget child) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("我是类中的temperatureVal=${weatherInfo.temperatureVal}"),
        );
      },
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("WeatherInfoPage2 MyFloatingActionButton build");
    return Consumer<WeatherInfo>(
      builder: (BuildContext context, WeatherInfo weatherInfo, Widget child) {
        return FloatingActionButton(
          backgroundColor: decideColor(weatherInfo),
          onPressed: () {
            String newWeatherType =
                "celcius" == weatherInfo.temperatureType ? "far" : "celcius";
            weatherInfo.temperatureType = newWeatherType;
            weatherInfo.temperatureVal = ++weatherInfo.temperatureVal;
          },
          child: Icon(Icons.change_history),
        );
      },
    );
  }
}
