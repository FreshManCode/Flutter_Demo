
import 'package:flutter/material.dart';
// 回调相关学习

// 声明两个回调函数
typedef SexFunc = void Function(String sex);

typedef AgeFunc(int age);

typedef ClickEvent();

class MyCallBackLearnRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCallBackLearnRouteState();
  }
}

class _MyCallBackLearnRouteState extends State<MyCallBackLearnRoute> {
  Future _showAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('TouchMe'),
            actions: [
              RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('知道了'))
            ],
          );
        });
  }

  Widget explainWidget = Text(
    '本例是讲解关于回调函数的知识',
    style: TextStyle(color: Colors.red),
  );
  String? sexStr;
  int? ageInt;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            explainWidget,
            Container(
              child: Text('李白的性别是:${sexStr ?? ""}'),
            ),
            Container(
              child: Text('李白的年龄是:${ageInt ?? ""}'),
            ),
            TestBottomView(
              ageCallBack: (int age) {
                setState(() {
                  ageInt = age;
                });
              },
              sexCallBack: (String sex) {
                setState(() {
                  sexStr = sex;
                });
              },
              name: "李白",
              // 回调组件事件
              DidClickAdd: () async {
                await _showAlert(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TestBottomView extends StatelessWidget {
  final SexFunc sexCallBack;
  final AgeFunc ageCallBack;
  final ClickEvent DidClickAdd;
  TestBottomView(
      {String? name,
      required this.sexCallBack,
      required this.ageCallBack,
      required this.DidClickAdd});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            onPressed: () {
              sexCallBack('男');
            },
            child: Text('调查性别'),
          ),
          RaisedButton(
            onPressed: () => {ageCallBack(10)},
            child: Text("调查年龄"),
          ),
          RaisedButton(
            onPressed: () => {DidClickAdd()},
            child: Text("AddMe"),
          )
        ],
      ),
    );
  }
}
