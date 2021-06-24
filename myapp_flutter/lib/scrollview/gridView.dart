import 'package:flutter/material.dart';

/** GridView
 * GridView可以构建一个二维网格列表,如下做相关参数讲解:
 
 gridDelegate:类型是SliverGridDelegate，它的作用是控制GridView子组件如何排列(layout)。

 SliverGridDelegate是一个抽象类，定义了GridView Layout相关接口，子类需要通过实现它们来实现具体的布局算法。
 Flutter中提供了两个SliverGridDelegate的子类SliverGridDelegateWithFixedCrossAxisCount和SliverGridDelegateWithMaxCrossAxisExtent，

*  SliverGridDelegateWithFixedCrossAxisCount 
该子类实现了一个横轴为固定数量子元素的layout算法,相关属性如下:
>. crossAxisCount: 横轴子元素的数量.此属性值确定后子元素在横轴的长度就确定了,即ViewPort横轴长度除以crossAxisCount的商。
>. mainAxisSpacing:主轴方向的间距
>. crossAxisSpacing:横轴方向子元素的间距.
>. childAspectRatio:子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，
然后通过此参数值就可以确定子元素在主轴的长度。

可以发现，子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的。注意，
这里的子元素指的是子组件的最大显示空间，注意确保子组件的实际大小不要超出子元素的空间。

* GridView.count
 GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，我们通过它可以快速的创建横轴固定数量子元素的GridView

 * SliverGridDelegateWithMaxCrossAxisExtent:该子类实现了一个横轴子元素为固定最大长度的layout算法
maxCrossAxisExtent为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的

 

 */
class MyGridViewRoute extends StatelessWidget {
  final simpleGridViewWidget = GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      // 宽高比为1
      childAspectRatio: 1.0,
      // 横轴三个子widget
      crossAxisCount: 3,
    ),
    children: [
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
    ],
  );

  // 该widget等于上面的widget,使用 gridViewCount实现
  final gridViewCount = GridView.count(
    crossAxisCount: 3,
    childAspectRatio: 1.0,
    children: [
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
    ],
  );

  final gridMaxCrossAxisExtent = GridView(
    padding: EdgeInsets.zero,
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 120.0,
      childAspectRatio: 2.0,
    ),
    children: [
      Icon(Icons.ac_unit, color: Colors.red),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
      Container(color: Colors.blue),
    ],
  );
  // GridView.extent构造函数内部使用了SliverGridDelegateWithMaxCrossAxisExtent，
  // 我们通过它可以快速的创建纵轴子元素为固定最大长度的的GridView，上面的示例代码等价于
  final gridViewExtent = GridView.extent(
    maxCrossAxisExtent: 120.0,
    childAspectRatio: 2.0,
    children: [
      Icon(Icons.ac_unit, color: Colors.red),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast),
      Container(color: Colors.blue),
    ],
  );

// 使用哪一个索引
  int? gridViewIndex = 0;
  MyGridViewRoute({this.gridViewIndex});

  @override
  Widget build(BuildContext context) {
    List<Widget> myChildren = [
      simpleGridViewWidget,
      gridViewCount,
      gridMaxCrossAxisExtent,
      gridViewExtent,
      MyGridViewBuilderRoute(),
    ];
    print("gridViewIndex is:${this.gridViewIndex!}");
    if (this.gridViewIndex! < myChildren.length) {
      return myChildren[this.gridViewIndex!];
    }
    return myChildren.first;
  }
}

class MyGridViewBuilderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGridViewBuilderRouteState();
  }
}

class _MyGridViewBuilderRouteState extends State<MyGridViewBuilderRoute> {
  List<IconData> _icons = []; //保存Icon数据
  @override
  void initState() {
    _retrieveIcons();
  }

  _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 每行3列
        crossAxisCount: 5,
        // 显示区域宽高相等
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        //如果显示到最后一个并且Icon总数小于200时继续获取数据
        if (index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
      itemCount: _icons.length,
    );
  }
}
