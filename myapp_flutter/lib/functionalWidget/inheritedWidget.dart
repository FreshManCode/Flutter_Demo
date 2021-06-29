import 'package:flutter/material.dart';

/**
 * InheritedWidget是Flutter中非常重要的一个功能型组件，它提供了一种数据在widget树中从上到下传递、共享的方式，
  比如我们在应用的根widget中通过InheritedWidget共享了一个数据，那么我们便可以在任意子widget中来获取该共享的数据！
  这个特性在一些需要在widget树中共享数据的场景中非常方便！
  如Flutter SDK中正是通过InheritedWidget来共享应用主题（Theme）和Locale (当前语言环境)信息的。
 
 * didChangeDependencies
 State对象有一个didChangeDependencies回调，它会在“依赖”发生变化时被Flutter Framework调用
 而这个“依赖”指的就是子widget是否使用了父widget中InheritedWidget的数据！如果使用了，则代表子widget依赖有依赖InheritedWidget；
 如果没有使用则代表没有依赖。这种机制可以使子组件在所依赖的InheritedWidget变化时来更新自身！
 */

class MyShareDataWidget extends InheritedWidget {
// 需要在子树中保存的数据,保存点击次数
  final int data;
  MyShareDataWidget({required this.data, required Widget child})
      : super(child: child);

  // 定义一个便捷方法,方便子树中的widget获取共享数据
  static MyShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyShareDataWidget>();
  }

  @override
  bool updateShouldNotify(covariant MyShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class MyTestWidgetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTestWidgetRouteState();
  }
}

class _MyTestWidgetRouteState extends State<MyTestWidgetRoute> {
  @override
  Widget build(BuildContext context) {
    final text =  MyShareDataWidget.of(context) != null ? MyShareDataWidget.of(context)!.data.toString() : "";
    return Text(text);
  }

  @override
  void didChangeDependencies() {
    // 父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    super.didChangeDependencies();
    print("Dependencies change");
  }
}

// 最后，我们创建一个按钮，每点击一次，就将ShareDataWidget的值自增：
class MyInheritedWidgetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyInheritedWidgetRoute();
  }
}

/* 注意:
 * 如果 MyTestWidgetRoute build方法中没有使用MyShareDataWidget 的数据,那么它的didChangeDependencies()将不会被调用,
 * 因为它没并没有依赖MyShareDataWidget. 
 * 
 */

class _MyInheritedWidgetRoute extends State<MyInheritedWidgetRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: MyTestWidgetRoute(),
            ),
            RaisedButton(
              child: Text("Increment"),
              //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}
