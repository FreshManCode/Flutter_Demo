import 'package:flutter/material.dart';

/** SingleChildScrollView
 * 通常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，这是因为SingleChildScrollView不支持基于Sliver的延迟实例化模型，
 * 所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用SingleChildScrollView将会非常昂贵（性能差），
 * 此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView。
 * 
 */

class MySinglechildScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: str.split("").map((e) {
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  e,
                  textScaleFactor: 2.0,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
