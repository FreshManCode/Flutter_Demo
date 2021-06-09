// 命名路由传递参数
import 'package:flutter/material.dart';

class NameRouteParams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在路由页通过RouteSetting对象获取路由参数：
    var args = ModalRoute.of(context)?.settings?.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('路由命名参数'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("args is:$args"),
          ],
        ),
      ),
    );
  }
}
