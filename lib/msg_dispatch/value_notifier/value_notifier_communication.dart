import 'package:flutter/material.dart';
import 'package:startup_namer/msg_dispatch/value_notifier/value_notifier_data.dart';

/// @desp: todo
/// @time 2019/3/28 5:06 PM
/// @author chenyun
class ValueNotifierCommunication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifierData valueNotifierData = ValueNotifierData('Hello World');
    return Scaffold(
      appBar: AppBar(
        title: Text('Value Notifier Communication'),
      ),
      body: ValueNotifierWidget(data: valueNotifierData),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            valueNotifierData.value = 'Yes';
          }),
    );
  }
}

class ValueNotifierWidget extends StatefulWidget {
  final ValueNotifierData data;

  ValueNotifierWidget({@required this.data});

  @override
  _ValueNotifierWidgetState createState() => _ValueNotifierWidgetState();
}

class _ValueNotifierWidgetState extends State<ValueNotifierWidget> {
  String info;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.data.addListener(_handleValueChanged);
  }

  @override
  void initState() {
    super.initState();
    info = 'Initial mesage: ' + widget.data.value;
  }

  @override
  void dispose() {
    super.dispose();
    widget.data.removeListener(_handleValueChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(info),
    );
  }

  void _handleValueChanged() {
    setState(() {
      info = 'Message changed to: ' + widget.data.value;
    });
  }
}
