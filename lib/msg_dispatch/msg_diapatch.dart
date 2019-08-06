import 'package:flutter/material.dart';
import 'package:startup_namer/msg_dispatch/inherited_widget/inhritagecontainer.dart';
import 'package:startup_namer/msg_dispatch/value_notifier/value_notifier_communication.dart';

/// @desp: Flutter中消息传递
/// https://xsfelvis.github.io/2019/01/12/%20Flutter中消息传递/
/// @time 2019/3/28 12:03 PM
/// @author chenyun
class MsgDispatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Msg DisPatch'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('InheritedWidget从上往下传递数据'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InheritedWidgetTestContainer();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('ValueNotifier从上往下传递数据'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ValueNotifierCommunication();
                  }));
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('Notification从下往上数据传递'),
                onPressed: () {
                  Navigator.pushNamed(
                      context, "MsgPatchMsgPage/NotificationDisPatchMsgPage");
                }),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: new RaisedButton(
                textColor: Colors.black,
                child: new Text('EventBus 使用'),
                onPressed: () {
//                  Navigator.pushNamed(context, "/GlobalKeyFromPage");
                }),
          ),
        ],
      ),
    );
  }
}
