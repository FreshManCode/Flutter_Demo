
import 'package:flutter/material.dart';


class MyAlertDialogRoute extends StatelessWidget {
  var _withTree = false;

  Future<bool?> _showAlrtDialogOne(BuildContext context) {
    print("ShowDialog");
    // showDialog 弹出对话框
    return showDialog<bool?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text("您确定要删除当前文件吗?"),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  //执行删除操作 关闭对话框
                  Navigator.of(context).pop(true);
                },
                child: Text('删除'),
              ),
            ],
          );
        });
  }

  Future _showListDialogAlert(BuildContext context) {
    return showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("请选择语言"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('英式英语'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 3);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美式英语'),
                ),
              ),
            ],
          );
        });
  }

// 自定義Alert,在点击遮罩的时候不会消失
  Future<bool?> _showCustomDialogAlert(BuildContext context) {
    return showGeneralDialog<bool?>(
        context: context,
        // 自定义遮罩颜色
        barrierColor: Colors.black87,
        transitionDuration: const Duration(milliseconds: 150),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  Future<bool?> _showAlertDialogManageState(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("提示"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
              )
            ],
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("您确定要删除当前文件吗?"),
                Row(
                  children: [
                    Text("同时删除子目录？"),
                    MyStatefullBuilder(builder: (context, _setState) {
                      return Checkbox(
                          value: _withTree,
                          onChanged: (bool? value) {
                            // 此时context为对话框UI的根Element，我们 直接将对话框UI对应的Element标记为dirty
                            (context as Element).markNeedsBuild();
                            _withTree = !_withTree;
                          });
                    }),
                  ],
                ),
              ],
            ),
          );
        });
  }

// 底部弹出选择框
  Future<int?> _showBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              );
            },
            itemCount: 30,
          );
        });
  }

  PersistentBottomSheetController<int?> _showBottomSheet(BuildContext context) {
    return showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text("$index"),
                onTap: () {
                  print("$index");
                  Navigator.of(context).pop(index);
                });
          });
        });
  }

  _showLoadingAndDialogAlert(BuildContext context) {
    showDialog(
        context: context,
        // 点击遮罩是否关闭对话框
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 26.0),
                  child: Text("正在加载，请稍后..."),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          RaisedButton(
            onPressed: () async {
              // 返回值是一个可选型的bool类型
              bool isDelete = await _showAlrtDialogOne(context) ?? false;
              print(isDelete ? "Delete" : "Cancel");
            },
            child: Text('对话框1'),
          ),
          RaisedButton(
            onPressed: () async {
              int index = await _showListDialogAlert(context);
              print("index is:$index");
            },
            child: Text("列表对话框"),
          ),
          RaisedButton(
            onPressed: () async {
              bool result = await _showCustomDialogAlert(context) ?? false;
              print(result ? "Delete" : "Cancel");
            },
            child: Text("自定义列表对话框"),
          ),
          RaisedButton(
            onPressed: () async {
              bool result = await _showAlertDialogManageState(context) ?? false;
              print(result && _withTree
                  ? "删除的时候同时删除子目录"
                  : result
                      ? "只删除不包含子目录"
                      : "取消哦");
            },
            child: Text("对话框状态管理"),
          ),
          RaisedButton(
            onPressed: () async {
              int type = await _showBottomModalSheet(context) ?? -100;
              print("type is:$type");
            },
            child: Text("底部弹出对话框"),
          ),
          RaisedButton(
            onPressed: () async {
              _showBottomSheet(context);
            },
            child: Text("底部弹出对话框2"),
          ),
          RaisedButton(
            onPressed: () async {
              await _showLoadingAndDialogAlert(context);
            },
            // 其实Loading框可以直接通过showDialog+AlertDialog来自定义：
            child: Text("Loading框"),
          ),
        ],
      ),
    );
  }
}

// 2.对话框打开动画及遮罩
// showDialog方法，它是Material组件库中提供的一个打开Material风格对话框的方法.
// 如何打开一个普通风格的对话框呢（非Material风格）？ Flutter 提供了一个showGeneralDialog方法
// 下面我们自己封装一个showCustomDialog方法，它定制的对话框动画为缩放动画，并同时制定遮罩颜色为Colors.black87：
// 参照:_showCustomDialogAlert 自定义对话框

// 3.对话框状态管理
// 我们在用户选择删除一个文件时，会询问是否删除此文件；在用户选择一个文件夹是，应该再让用户确认是否删除子文件夹。
// 为了在用户选择了文件夹时避免二次弹窗确认是否删除子目录，我们在确认对话框底部添加一个“同时删除子目录？”的复选框

// 使用StatefulBuilder 方法
class MyStatefullBuilder extends StatefulWidget {
  const MyStatefullBuilder({Key? key, required this.builder})
      : assert(builder != null),
        super(key: key);
  // 做个转发
  final StatefulWidgetBuilder builder;
  @override
  State<StatefulWidget> createState() {
    return _MyStatefullBuilder();
  }
}

class _MyStatefullBuilder extends State<MyStatefullBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}

class MyTestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
