import 'package:flutter/material.dart';

/*
 * 弹性布局 (Flex)
 弹性布局允许子组件按照一定比例来分配父容器空间.弹性布局的概念在其它UI系统中也都存在.

 Flex
 Flex组件可以沿着水平或垂直方向排列子组件,如果你知道主轴方向,使用Row或Column会方便一些,因为Row和Column都继承自Flex,
 参数基本相同,所以能使用Flex的地方基本上都可以使用Row或Column.Flex本身功能很强大,它可以和Expanded组件配合实现弹性布局.

 Expanded

 
 */
class MyFlexLayoutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                  height: 30.0,
                )),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                height: 30.0,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    // height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 30.0,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
