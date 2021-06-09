import 'package:flutter/material.dart';
import "shoppingList.dart";
import 'learnWidgetList.dart';

class MyScaffold extends StatelessWidget {
  var tapCount = 0;

  buttonTap(context) {
    tapCount++;
    print("tap One:$tapCount");
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('InCrement'),
        ),
        body: new ShoppingList(
          key: Key("1111"),
          products: <Product>[
            new Product(name: 'Eggs'),
            new Product(name: 'Flour'),
            new Product(name: 'Chocolate chips'),
          ],
        ),
      );
    }));
  }

  learnWidget(context) {
    print("组件学习列表");
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title:new Text("组件列表"),
        ),
        body: new WidgetList(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: [
          new Expanded(
              child: new Center(
            child: new Text('Hello,world! $tapCount'),
          )),
          new Expanded(
              child: new Center(
                  child: FloatingActionButton(
                      child: Text(
                        "TouchMe",
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        buttonTap(context);
                      }))),
          new Expanded(
            child: new Center(
              child: MyButton(
                buttonClick: () {},
                title: "+|-",
                callBack: false,
              ),
            ),
          ),
          new Expanded(
            child: new Center(
              child: MyButton(
                buttonClick: () {
                  learnWidget(context);
                },
                title: "组件学习",
                callBack: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef void ButtonClick();

// GestureDetector widget并不具有显示效果,而是检测由用户做出的手势.当用户点击Container时,GestureDetector会调用它的onTap回调,
// 在回调中,将消息打印到控制台,你可以使用GestureDetector 来检测各种输入手势,包括点击,拖动和缩放.
// 许多Widget都会使用一个GestureDetector为其他widget提供可选的回调.例如,IconButton,RaisedButton和FloatingActionButton,
// 它们都有一个onPressed回调,它会在用户点击该widget时被触发.
class MyButton extends StatelessWidget {
  MyButton(
      {required this.title, required this.buttonClick, required this.callBack});
  final ButtonClick buttonClick;
  final String title;
  final bool callBack;
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _changeWidget(context);
      },
      child: new Container(
        height: 36,
        width: 100,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: new Center(
          child: new Text(this.title.length > 0 ? this.title : "可变Widget"),
        ),
      ),
    );
  }

  _changeWidget(BuildContext context) {
    if (this.callBack) {
      this.buttonClick();
      return;
    }
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('InCrement'),
        ),
        body: new MyCounter(),
      );
    }));
  }
}

// 根据用户输入改变widget
// StatefullWidget是特殊的widget,它知道如何生成State对象.然后用它来保持状态.如下例:
class MyCounter extends StatefulWidget {
  @override
  // 1.重写createState 方法
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCounterState();
  }
}

// 2.声明一个类继承 State 并且遵从继承StatefulWidget 的类
class MyCounterState extends State<MyCounter> {
  int _counter = 0;
  _increment() {
    setState(() {
      _counter++;
    });
  }

  _decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        new Center(),
        new RaisedButton(
          onPressed: _increment,
          child: new Text("Increment"),
        ),
        new Text('Count:$_counter'),
        new RaisedButton(
          onPressed: _decrement,
          child: new Text("Decrement"),
        ),
      ],
    );
  }
}
