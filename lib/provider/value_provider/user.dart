/// @desc todo
/// @time 2019-07-22 13:34
/// @author chenyun
class User {
  //with ChangeNotifier
  String name;
  int age;

  User(this.name, this.age);

  void setName(String name) {
    this.name = name;
//    notifyListeners();
  }

  String get getName => this.name;
}
