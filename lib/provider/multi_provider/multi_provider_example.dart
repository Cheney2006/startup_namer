import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/provider/change_notifier_provider/weather_info.dart';
import 'package:startup_namer/provider/value_provider/data_info.dart';
import 'package:startup_namer/utils/log_util.dart';

/// @desc 使用MultiProvider
/// @time 2019-07-22 09:24
/// @author chenyun
class MultiProviderExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataInfo dataInfo = DataInfo(0);
    return MultiProvider(
      providers: [
//        ValueListenableProvider<int>.value(value: DataInfo(0)),
        ValueListenableProvider<int>(builder: (_) => dataInfo),
        ChangeNotifierProvider<WeatherInfo>(
          builder: (_) => WeatherInfo(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("MultiProviderExample"),
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
              MyContent(),
              Consumer<int>(
                builder: (context, val, _) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("当前下标为$val"),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: Consumer2<WeatherInfo, int>(
          builder: (BuildContext context, WeatherInfo weatherInfo, int val,
              Widget child) {
            return FloatingActionButton(
              backgroundColor: decideColor(weatherInfo),
              onPressed: () {
                String newWeatherType = "celcius" == weatherInfo.temperatureType
                    ? "far"
                    : "celcius";
                weatherInfo.temperatureType = newWeatherType;
                weatherInfo.temperatureVal = ++weatherInfo.temperatureVal;

                dataInfo.value = ++val;
              },
              child: Icon(Icons.change_history),
            );
          },
        ),
      ),
    );
  }

  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }
}

class MyHeader extends StatelessWidget {
  Color decideColor(WeatherInfo info) {
    return "celcius" == info.temperatureType ? Colors.green : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.v("MyHeader build");

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("我在Consumer外层，看我变不变${Random().nextInt(100)}"),
        ),
        Consumer<WeatherInfo>(
          builder: (context, weatherInfo, _) {
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
            child: Text("我在Consumer的 child，看我变不变${Random().nextInt(100)}"),
          ),
        ),
      ],
    );
  }
}

class MyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.v("MyContent build");

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
    LogUtil.v("MyFloatingActionButton build");

    return Consumer2<WeatherInfo, int>(
      builder: (BuildContext context, WeatherInfo weatherInfo, int val,
          Widget child) {
        return FloatingActionButton(
          backgroundColor: decideColor(weatherInfo),
          onPressed: () {
            String newWeatherType =
                "celcius" == weatherInfo.temperatureType ? "far" : "celcius";
            weatherInfo.temperatureType = newWeatherType;
            weatherInfo.temperatureVal = ++weatherInfo.temperatureVal;

            val = ++val;
          },
          child: Icon(Icons.change_history),
        );
      },
    );
  }
}
