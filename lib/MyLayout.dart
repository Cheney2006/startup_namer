import 'package:flutter/material.dart';

class MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //图片部分
    Widget imageSection = new Image.asset(
      'images/lake.jpg',
      width: 600,
      height: 240,
      fit: BoxFit.fill,
    );

    //文本行
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              //左边两行文本
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  //控制文本间距
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    //第一行文本
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  //第二行文本
                  'Kandersteg, Switzerland',
                  style: new TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
//          new Icon(
//            //星标
//            Icons.star,
//            color: Colors.red[500],
//          ),
//          new Text(//星期数字
//              '41'
//          ),
          new FavoriteStatefulWidget(),
        ],
      ),
    );

    //按钮行
    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildBottomColumn(color, Icons.call, 'CALL'),
          _buildBottomColumn(color, Icons.near_me, 'ROUTE'),
          _buildBottomColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    ///文本行
    Widget textSection = new Container(
      padding: const EdgeInsets.all(32),
      child: new Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return new MaterialApp(
        title: 'Flutter layout demo',
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Flutter layout demo'),
          ),
          body: new ListView(
            children: <Widget>[
              imageSection,
              titleSection,
              buttonSection,
              textSection,
            ],
          ),
        ));
  }

  ///生成按钮组
  Widget _buildBottomColumn(Color color, IconData icon, String label) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center, //与当前控件垂直的轴
      children: <Widget>[
        new Icon(
          icon,
          color: color,
        ),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

class FavoriteStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FavoriteState();
  }
}

class _FavoriteState extends State<FavoriteStatefulWidget> {
  bool _isFavorite = true;

  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
//          decoration: new BoxDecoration(
//            color: Colors.blue,
//          ),
          padding: const EdgeInsets.all(0),
//          margin: const EdgeInsets.only(right: 10.0),
          child: new SizedBox(
            width: 24,
            height: 24,
            child: new IconButton(
              icon: _isFavorite
                  ? new Icon(Icons.star)
                  : new Icon(Icons.star_border),
              padding: const EdgeInsets.all(0.0),
              color: Colors.red[500],
              onPressed: _toggleFavorite,
            ),
          ),
        ),
        new SizedBox(
          width: 18.0,
          child: new Container(
//            decoration: new BoxDecoration(
//              color: Colors.red,
//            ),
            child: new Text(
              '$_favoriteCount',
//              style: new TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favoriteCount -= 1;
      } else {
        _favoriteCount += 1;
      }
      _isFavorite = !_isFavorite;
    });
  }
}
