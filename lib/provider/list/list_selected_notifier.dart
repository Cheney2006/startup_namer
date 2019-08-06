import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';

/// @desc 列表选中项监听
/// @time 2019-08-01 11:03
/// @author chenyun
class ListSelectedNotifier extends ChangeNotifier {
  Set _saved = Set<WordPair>();

  Set get saved => _saved;

  set saved(Set value) {
    _saved = value;
    notifyListeners();
  }
}
