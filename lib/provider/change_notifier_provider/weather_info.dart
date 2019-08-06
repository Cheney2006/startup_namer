import 'package:flutter/foundation.dart';

/// @desc 创建共享数据类
/// @time 2019-07-19 16:44
/// @author chenyun
class WeatherInfo with ChangeNotifier {
  String _tempType = "celcius";
  int _temperatureVal = 25;

  String get temperatureType => _tempType;

  set temperatureType(String value) {
    _tempType = value;
    notifyListeners();
  }

  int get temperatureVal => _temperatureVal;

  set temperatureVal(int value) {
    _temperatureVal = value;
    notifyListeners();
  }
}
