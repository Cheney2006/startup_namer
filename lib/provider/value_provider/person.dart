import 'package:flutter/material.dart';

/// @desc todo
/// @time 2019-07-22 12:08
/// @author chenyun
// 自定义实体类
class Person extends ValueNotifier<String> {
  Person(String name) : super(name);
  String get getPersonName => value;

  void setPersonName(String name) {
    value = name;
    notifyListeners();
  }
}
