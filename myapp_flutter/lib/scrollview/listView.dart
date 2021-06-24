import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

/**ListView 相关参数说明:
 * itemExtent :该参数如果不为null,会强制children的长度为itemExtent的值;这里的'长度'是指滚动方向上子组件的长度,也就是说如果滚动方向
 是垂直方向,则itemExtent 代表子组件的高度:如果滚动方向为水平方向,则itemExtent 就代表子组件的高度.在ListView 中,指定itemExtent比让
 组件自己决定自身长度会更高效,这是因为指定itemExtent后,滚动系统可以提前知道列表的长度,而不需要每次构建子组件时都在再计算一下,尤其是在
 滚动位置频繁变化时(滚动系统需要频繁去计算列表高度)

 * shrinkWrap：该属性表示是否根据子组件的总长度来设置ListView的长度，默认值为false 。默认情况下，
 ListView的会在滚动方向尽可能多的占用空间。当ListView在一个无边界(滚动方向上)的容器中时，shrinkWrap必须为true。

 * 默认构造函数:
 默认构造函数有一个children参数，它接受一个Widget列表（List）。这种方式适合只有少量的子组件的情况，
 因为这种方式需要将所有children都提前创建好（这需要做大量工作），而不是等到子widget真正显示的时候再创建，
 也就是说通过默认构造函数构建的ListView没有应用基于Sliver的懒加载模型。
 实际上通过此方式创建的ListView和使用SingleChildScrollView+Column的方式没有本质的区别

 * 注意:
   可滚动组件通过一个List来作为其children属性时,只适用于子组件较少的情况,这是一个通用规律,并非ListView自己的特性,
   像GridView也是如此.
 
 * ListView.builder
 ListView.builder适合列表项比较多（或者无限）的情况，因为只有当子组件真正显示的时候才会被创建，
 也就说通过该构造函数创建的ListView是支持基于Sliver的懒加载模型的。

 * ListView.separated
 ListView.separated可以在生成的列表项之间添加一个分割组件，
 它比ListView.builder多了一个separatorBuilder参数，该参数是一个分割组件生成器。
 如下例:sepratorListView ,奇数添加一条蓝色的下划线,偶数添加一条绿色下划线

* 添加固定表头
可以使用Expanded自动拉伸组件大小，并且我们也说过Column是继承自Flex的，所以我们可以直接使用Column+Expanded来实现，代码如下：

 */

class MyListViewRoute extends StatelessWidget {
  final String? ListViewType;
  MyListViewRoute({this.ListViewType});
  @override
  Widget build(BuildContext context) {
    // 简单的高性能的ListView
    final simpleListView =
        ListView.builder(itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text("$index"),
      );
    });

    Widget divider1 = Divider(
      color: Colors.blue,
      height: 2.0,
    );
    Widget divider2 = Divider(
      color: Colors.green,
      height: 3.0,
    );

    // 使用 Column 给ListView添加表头
    final sepratorListView = Column(
      children: [
        ListTile(
          title: Text("我是表头哦"),
        ),
        Expanded(
            child: ListView.separated(
                // 列表项构造器
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text("$index"));
                },
                // 分割器构造器
                separatorBuilder: (BuildContext context, int index) {
                  return index % 2 == 0 ? divider1 : divider2;
                },
                // 代表有多少个Item (如果不填写,默认无限)
                itemCount: 100)),
      ],
    );

    if (this.ListViewType == "SimpleListView") {
      return simpleListView;
    } else if (this.ListViewType == "SepratorListView") {
      return sepratorListView;
    }
    return simpleListView;
  }
}

class MyInfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyInfiniteListViewState();
  }
}

class _MyInfiniteListViewState extends State<MyInfiniteListView> {
// 表尾标记
  static const LoadingTag = "loading....";
  var _words = <String>[LoadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

// TODO:获取数据
  _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(title: Text("这是一个表头哦")),
        Expanded(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                // 如果到了表尾
                if (_words[index] == LoadingTag) {
                  // 不足100条,继续获取数据
                  if (_words.length - 1 < 100) {
                    // 获取数据
                    _retrieveData();
                    //  加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    );
                  } else {
                    //已经加载了100条数据，不再获取数据。
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ));
                  }
                }
                //显示单词列表项
                return ListTile(title: Text(_words[index]));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.red,
                  height: 1.5,
                );
              },
              itemCount: _words.length),
        ),
      ],
    );
  }
}
