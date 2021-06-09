import 'package:flutter/material.dart';

/**
 * 该页面点击左上角的返回按钮可以返回,点击下面的返回值Button也可以返回,区别就是左上角默认返回动作没有携带任何参数
 * 下面的button返回可以携带相关参数(本例中携带的是"我是返回值")
 */

class TipRoute extends StatelessWidget {
  TipRoute({required Key key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text('返回'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
