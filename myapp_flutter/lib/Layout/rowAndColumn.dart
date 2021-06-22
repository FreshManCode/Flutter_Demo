import 'package:flutter/material.dart';

/* 特殊情况:
如果Row里面嵌套Row,或者Column嵌套Column,那么只有最外面的Row或者Column 会占用尽可能大的空间,里面Row
或者Column所占用的空间为实际大小,如该例:


*/

class RowAndColumnSpecialRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RowAndColumnSpecialRoute();
  }
}

class _RowAndColumnSpecialRoute extends State<RowAndColumnSpecialRoute> {
  changeMe() {
    setState(() {
      autoFit = !autoFit;
    });
  }

  var autoFit = true;

  @override
  Widget build(BuildContext context) {
    
    final autoFitWidget = Container(
      color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Expanded(
          child: Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
              children: <Widget>[
                Text("hello world "),
                Text("I am Jack "),
                 RaisedButton(
                    onPressed: () {
                      changeMe();
                    },
                    child: Text('ChangeMeToSmall'),
                  )
              ],
            ),
          ),
        ),
      ),
    );

    final smallWidget = Container(
      color: Colors.grey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // 有效,外层Column高度为整个屏幕
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                children: <Widget>[
                  Text("hello world "),
                  Text("I am Jack "),
                  RaisedButton(
                    onPressed: () {
                      changeMe();
                    },
                    child: Text('ChangeMeToBig'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

    return autoFit ? autoFitWidget : smallWidget;
  }
}
