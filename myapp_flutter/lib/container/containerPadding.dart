import 'package:flutter/material.dart';
import 'package:myapp_flutter/two.dart';

class MyContainerPaddingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      // 上下左右各添加16个像素补白
      padding: EdgeInsets.all(16.0),
      child: Column(
        // 显示指定对齐方式为左对齐,排除对齐干扰
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.red,
            child: Padding(
              // 左边添加8像素
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Hello world',
                style: TextStyle(backgroundColor: Colors.white54),
              ),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Hello world',
                  style: TextStyle(backgroundColor: Colors.red)),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Padding(
              // 分别从四个方向补白
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text('Hello world',
                  style: TextStyle(backgroundColor: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }
}
