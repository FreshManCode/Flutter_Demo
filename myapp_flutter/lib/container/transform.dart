import 'package:flutter/material.dart';
import 'dart:math' as math;

/**
 * Transform 可以在其子组件绘制时对其应用一些矩阵变换来实现一些效果.Materix4是一个4D矩阵,
 */
class MyTransformRoute extends StatelessWidget {
  Widget transformOne = Container(
    color: Colors.lightGreen,
    child: Transform(
      // 相对于坐标系原点的对齐方式
      alignment: Alignment.topRight,
      // 沿Y轴倾斜0.15弧度
      transform: Matrix4.skewY(0.15),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.deepOrange,
        child: const Text('Hello,my world'),
      ),
    ),
  );

  /*
   Transform.translate接收一个offset参数，可以在绘制时沿x、y轴对子组件平移指定的距离。
   */

  Widget translateRoute = Padding(
    padding: EdgeInsets.fromLTRB(40, 40, 20, 0),
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      child: Transform.translate(
        offset: Offset(-20.0, -5.0),
        child: Text("Hello world"),
      ),
    ),
  );

  Widget totateRoute = Padding(
    padding: EdgeInsets.fromLTRB(40, 40, 20, 0),
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
      child: Transform.rotate(
        angle: math.pi / 2,
        child: Text("Hello world"),
      ),
    ),
  );

  /* 注意:
   * Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，
   * 其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。如下事例:
   * 
   * 由于第一个Text 应用变大周,其在绘制时会放大,但其占用的空间依然为红色部分,所以第二个Text会紧挨着红色部分,就会出现文字重合.
   * 由于矩阵变化只会作用在绘制阶段，所以在某些场景下，在UI需要变化时，可以直接通过矩阵变化来达到视觉上的UI改变，而不需要去重新触发build流程，
   * 这样会节省layout的开销，所以性能会比较好。如之前介绍的Flow组件，它内部就是用矩阵变换来更新UI，
   * 除此之外，Flutter的动画组件中也大量使用了Transform以提高性能。
   */

  Widget scaleRoute = Padding(
    padding: EdgeInsets.fromLTRB(40, 40, 20, 0),
    child: Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Transform.scale(
            scale: 1.5, //放大到1.5倍
            child: Text("Hello world"),
          ),
        ),
        Text(
          "你好",
          style: TextStyle(color: Colors.green, fontSize: 18.0),
        ),
      ],
    ),
  );

  /*
   * 由于RotatedBox是作用于layout阶段,所以子组件会旋转90度(而不只是绘制内容),decoration
   * 会作用子组件所占用的实际空间,所以最终效果就是该例.后面的文本不会被遮挡.
   */

  Widget rotatedRoute = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        // 使用RotatedBox,将文本旋转90度
        child: RotatedBox(
          // 旋转90度 (1/4 圈)
          quarterTurns: 1,
          child: Text('Hello World'),
        ),
      ),
      Text(
        '你好',
        style: TextStyle(color: Colors.green, fontSize: 18.0),
      ),
    ],
  );

  final String? routeType;
  MyTransformRoute({this.routeType});

  @override
  Widget build(BuildContext context) {
    if (this.routeType == "Transform.translate") {
      return translateRoute;
    } else if (this.routeType == "Transform.rotate") {
      return totateRoute;
    } else if (this.routeType == "Transform.scale") {
      return scaleRoute;
    } else if (this.routeType == "RotatedBox") {
      return rotatedRoute;
    }
    return transformOne;
  }
}
