import 'package:flutter/material.dart';

/** 装饰容器DecoratedBox 
 * DecoratedBox可以在其子组件绘制前(或后)绘制一些装饰（Decoration），如背景、边框、渐变等。
 
 >.decoration :代表将要绘制的装饰,它的类型为Decoration.Decoration 是一个抽象类,它定义了一个接口,createBoxPainter(),
 子类的职责是需要通过实现它来创建一个画笔,该画笔用于绘制装饰.

 >.position: 该属性决定在哪里绘制Decoration,它接收DecorationPosition 的枚举类型,该枚举类型有两个值:
  * background：在子组件之后绘制，即背景装饰。
  * foreground：在子组件之上绘制，即前景。

 */

class MyDecoratedBoxRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
        // 3像素圆角
        borderRadius: BorderRadius.circular(3.0),
        // 阴影
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
