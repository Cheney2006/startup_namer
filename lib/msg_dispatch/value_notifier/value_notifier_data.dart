import 'package:flutter/material.dart';

/// @desp: ValueNotifier是一个包含单个值的变更通知器，当它的值改变的时候，会通知它的监听
/// @time 2019/3/28 5:03 PM
/// @author chenyun
class ValueNotifierData extends ValueNotifier<String> {
  ValueNotifierData(String value) : super(value);
}
