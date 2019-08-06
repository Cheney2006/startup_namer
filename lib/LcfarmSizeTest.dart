/**
 * @desp:
 * @time 2019/3/11 5:10 PM
 * @author chenyun
 */

import 'package:flutter/material.dart';
import 'package:startup_namer/LcfarmSize.dart';

class LcfarmSizeTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_ScreenUtil',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'FlutterScreenUtil Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    LcfarmSize.instance = LcfarmSize(width: 750, height: 1334)..init(context);
    print('设备宽度:${LcfarmSize.screenWidth}'); //Device width
    print('设备高度:${LcfarmSize.screenHeight}'); //Device height
    print('设备的像素密度:${LcfarmSize.pixelRatio}'); //Device pixel density
    print(
        '底部安全区距离:${LcfarmSize.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        '状态栏高度:${LcfarmSize.statusBarHeight}px'); //Status bar height , Notch will be higher Unit px

    print('实际宽度的dp与设计稿px的比例:${LcfarmSize.getInstance().scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${LcfarmSize.getInstance().scaleHeight}');

    print(
        '宽度和字体相对于设计稿放大的比例:${LcfarmSize.getInstance().scaleWidth * LcfarmSize.pixelRatio}');
    print(
        '高度相对于设计稿放大的比例:${LcfarmSize.getInstance().scaleHeight * LcfarmSize.pixelRatio}');
    print('系统的字体缩放比例:${LcfarmSize.textScaleFactory}');

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'LcfarmSize.getInstance().width：${LcfarmSize.getInstance().width}');
          print('LcfarmSize().width：${LcfarmSize().width}');
        },
        child: Icon(Icons.accessible_forward),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: LcfarmSize.getInstance().setWidth(375),
                  height: LcfarmSize.getInstance().setHeight(200),
                  color: Colors.red,
                  child: Text(
                    '我的宽度:${LcfarmSize.getInstance().setWidth(375)}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: LcfarmSize.getInstance().setSp(24),
                    ),
                  ),
                ),
                Container(
                  width: LcfarmSize.getInstance().setWidth(375),
                  height: LcfarmSize.getInstance().setHeight(200),
                  color: Colors.blue,
                  child:
                      Text('我的宽度:${LcfarmSize.getInstance().setWidth(375)}dp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: LcfarmSize.getInstance().setSp(24),
                          )),
                ),
              ],
            ),
            Text('设备宽度:${LcfarmSize.screenWidth}px'),
            Text('设备高度:${LcfarmSize.screenHeight}px'),
            Text('设备的像素密度:${LcfarmSize.pixelRatio}'),
            Text('底部安全区距离:${LcfarmSize.bottomBarHeight}px'),
            Text('状态栏高度:${LcfarmSize.statusBarHeight}px'),
            Text(
              '实际高度的dp与设计稿px的比例:${LcfarmSize.getInstance().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度的dp与设计稿px的比例:${LcfarmSize.getInstance().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            Text(
              '宽度和字体相对于设计稿放大的比例:${LcfarmSize.getInstance().scaleWidth * LcfarmSize.pixelRatio}',
              textAlign: TextAlign.center,
            ),
            Text(
              '高度相对于设计稿放大的比例:${LcfarmSize.getInstance().scaleHeight * LcfarmSize.pixelRatio}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: LcfarmSize.getInstance().setHeight(100),
            ),
            Text('系统的字体缩放比例:${LcfarmSize.textScaleFactory}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('我的文字大小在设计稿上是25px，不会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: LcfarmSize.getInstance().setSp(24))),
                Text('我的文字大小在设计稿上是25px，会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize:
                            LcfarmSize(allowFontScaling: true).setSp(24))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
