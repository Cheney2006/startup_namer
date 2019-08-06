import 'package:flutter/material.dart';
import 'package:startup_namer/msg_dispatch/notification/notificationroute.dart';

class NotificationMsgDispatchMsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Notification Msg DisPatch'),
        centerTitle: true,
      ),
      body: NotificationStudy(),
    );
  }
}
