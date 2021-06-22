import 'package:flutter/material.dart';

class FlexLayoutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      /*
       1.由于我们没有指定Column的mainAxisSize,所以使用默认值MainAxisSize.max,则Column,会在垂直方向占用尽可能多的空间,
      本例为屏幕高度.
      
      2.由于我们指定了crossAxisAlignment 为center,那么子项在Column纵轴方向(此时为水平方向)会居中对齐.注意,在水平方向对齐是有
      边界的,总宽度为Column占用空间的实际宽度,而实际的宽度取决于子项中宽度最大的Widget.在本例中,Column有两个子Widget,而显示""world"
      的Text宽度最大,所以Column的实际宽度则为Text("world") 的宽度,所以居中对齐后Text("hi"),会显示在Text("world")的中间部分

      实际上,Row和Column都只会在主轴方向上占用尽可能大的空间,而纵轴的长度取决于他们最大子元素的长度.如果我们想让本例中的
      两个文本控件在整个手机屏幕中间对齐,我们有两种方法:
      >1.将Column 的宽度指定为屏幕宽度,可以通过ConstrainedBox或SizedBox来强制更改宽度限制,

       */
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("hi"),
            Text("world"),
          ],
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: double.infinity),
          child: Column(
            children: [
              Text(
                "此时这里的Widget的宽度是实际的宽度",
                style: TextStyle(color: Colors.red),
              ),
              Text("hi"),
              Text("world"),
            ],
          ),
        ),
      ],
    );
  }
}
