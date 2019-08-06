import 'package:flutter/material.dart';

import 'user.dart';

/// @desc todo
/// @time 2019-07-22 12:08
/// @author chenyun
// 自定义实体类
class PersonUser extends ValueNotifier<User> {
  PersonUser(User user) : super(user);
  String get getPersonName => value.name;

  void setPersonName(String name) {
//    value.name = name;
    //这里新建一个对象重新赋值给 value 可以通知更新，单独给 value 的属性赋值将不会通知
    value = User(name, value.age++);
    notifyListeners();
  }
}
