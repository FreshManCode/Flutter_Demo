import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:async';
// 数据存储
import 'package:path_provider/path_provider.dart';
// 文件操作
// APP目录
// PathProvider (opens new window)插件提供了一种平台透明的方式来访问设备文件系统上的常用位置。
// 该类当前支持访问两个文件系统位置：
/**
 * 临时目录: 可以使用 getTemporaryDirectory() 来获取临时目录； 系统可随时清除的临时目录（缓存）。在iOS上，
 这对应于NSTemporaryDirectory() (opens new window)返回的值

 * 文档目录: 可以使用getApplicationDocumentsDirectory()来获取应用程序的文档目录，该目录用于存储只有自己可以访问的文件。
 只有当应用程序被卸载时，系统才会清除该目录。在iOS上，这对应于NSDocumentDirectory
 
 */

class MyFileOperationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFileOperationRouteState();
  }
}

class _MyFileOperationRouteState extends State<MyFileOperationRoute> {
  int? _counter;
  @override
  void initState() {
    super.initState();
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取本地保存的数据
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    } catch (e) {
      print("e is:$e");
      return 0;
    } 
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      if (_counter == null) {
        _counter = 1;
      } else {
        _counter = _counter! + 1;
      }
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Text('点击了 $_counter 次'),
          ),
          Container(
            child: FloatingActionButton(
              child: Text(
                "Add",
              ),
              onPressed: _incrementCounter,
            ),
          ),
        ],
      ),
    );
  }
}
