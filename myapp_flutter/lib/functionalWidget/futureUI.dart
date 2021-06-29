import 'package:flutter/material.dart';
/*
 * 但由于在实际开发中依赖异步数据更新UI的这种场景非常常见，因此Flutter专门提供了FutureBuilder和StreamBuilder两个组件来快速实现这种功能。 
 
 * FutureBuilder 相关参数简介
 future：FutureBuilder依赖的Future，通常是一个异步耗时任务。
 initialData：初始数据，用户设置默认数据。
 builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用：

 */

class MyFutureBuilderRoute extends StatelessWidget {
  Future<String> mockNetworkData() async {
    return Future.delayed(
        Duration(seconds: 2), () => "MockRequestFromNetworkData");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(snapshot.hasError
                ? "Error: ${snapshot.error}"
                : "Contents: ${snapshot.data}");
          } else {
            // 请求未结束,显示Loading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

// StreamBuilder
// StreamBuilder正是用于配合Stream来展示流上事件（数据）变化的UI组件

class MyStreamBuilderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyStreamBuilderRouteState();
  }
}

class _MyStreamBuilderRouteState extends State<MyStreamBuilderRoute> {
  Stream<int> counter() {
    return Stream.periodic(Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream已关闭');
          }
          return Container();
        },
        stream: counter(),
      ),
    );
  }
}
