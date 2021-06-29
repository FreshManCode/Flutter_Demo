
import 'package:flutter/material.dart';

// 监听ListView的滚动通知,然后显示当前滚动进度百分比

class MyMointorListViewScrollRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyMointorListViewScrollRouteState();
  }
}

class _MyMointorListViewScrollRouteState
    extends State<MyMointorListViewScrollRoute> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          //重新构建
          setState(() {
            final my_progress =  (progress * 100).toInt();
            if (my_progress >= 0 && my_progress <= 100) {
              _progress = "$my_progress%";
            }
          });
          print("BottomEdge: ${notification.metrics.extentAfter == 0}");
          return true;
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("$index"));
                }),
            CircleAvatar(
              //显示进度百分比
              radius: 30.0,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
