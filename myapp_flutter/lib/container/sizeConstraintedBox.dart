import 'package:flutter/material.dart';

/* 尺寸限制类容器
尺寸限制类容器用于限制容器大小,如:
ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio等.

*SizedBox:

SizedBox 用于给子元素指定固定的宽高

*多重限制
有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。
实际上，只有这样才能保证父限制与子限制不冲突.


* UnconstrainedBox
UnconstrainedBox 不会对子组件产生任何限制,它允许子组件按照其本身大小绘制.


 */

class MyConstrainedBoxRoute extends StatelessWidget {
  var myWidget;
  final constraintedBoxWidget = ConstrainedBox(
    constraints: BoxConstraints(
      // 宽度尽可能大
      minWidth: double.infinity,
      // 最小高度为50像素
      minHeight: 50.0,
    ),
    // 虽然将Container 的高度设置为5像素,但是最终却是50像素,这是ConstrainedBox 的最小高度限制生效了
    child: Container(
      child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
      height: 5.0,
    ),
  );

  final unconstrainedBoxWidget = ConstrainedBox(
    // 父
    constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
    // 去除父级限制
    child: UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
        child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
      ),
    ),
    // 该事例中,如果没有中间的UnconstrainedBox,那么根据上面所述的多重限制规则,最终是90 * 100的红色框.但是由于
    // UnconstrainedBox 去除了父ConstrainedBox 的限制,最终按照子ConstrainedBox 的限制来绘制redBox,即 90 * 20;
  );

  /*注意:
  UnconstrainedBox对父组件限制的“去除”并非是真正的去除：上面例子中虽然红色区域大小是90×20，但上方仍然有80的空白空间。
  也就是说父限制的minHeight(100.0)仍然是生效的，只不过它不影响最终子元素redBox的大小，但仍然还是占有相应的空间，
  可以认为此时的父ConstrainedBox是作用于子UnconstrainedBox上，而redBox只受子ConstrainedBox限制，这一点务必注意。


  在实际开发中，当我们发现已经使用SizedBox或ConstrainedBox给子元素指定了宽高，但是仍然没有效果时，几乎可以断定：已经有父元素已经设置了限制！
  
   */

  MyConstrainedBoxRoute({this.type});
  final String? type;

  @override
  Widget build(BuildContext context) {
    if (this.type == "ConstrainedBox") {
      myWidget = constraintedBoxWidget;
    } else if (this.type == "unconstrainedBoxWidget") {
      myWidget = unconstrainedBoxWidget;
    }
    return myWidget;
  }
}
