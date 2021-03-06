import 'package:flutter/material.dart';

/*
Container是一个组合类容器，它本身不对应具体的RenderObject，它是DecoratedBox、ConstrainedBox、Transform、
Padding、Align等组件组合的一个多功能容器，所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景

>.容器的大小可以通过width、height属性来指定，也可以通过constraints来指定；如果它们同时存在时，width、height优先。
实际上Container内部会根据width、height来生成一个constraints。

>.color和decoration是互斥的，如果同时设置它们则会报错！实际上，当指定color时，Container内会自动创建一个decoration。

 */

class MyContainerRoute extends StatelessWidget {

  // Padding和Margin 
  Widget marginWidget = Container(
    // 容器外留白
    margin: EdgeInsets.all(20.0),
    color: Colors.orange,
    child: Text('Hello_ _World!'),
  );

  Widget paddingWidget = Container(
    padding: EdgeInsets.all(20.0),
    color: Colors.orange,
    child: Text('Hello world!'),
  );




  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // 容器外填充
          margin: EdgeInsets.only(top: 50.0, left: 120.0),
          // 卡片大小
          constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
          // 背景装饰
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
          // 卡片倾斜变换
          transform: Matrix4.rotationZ(.2),
          alignment: Alignment.center,
          child: Text("5.20",
              style: TextStyle(color: Colors.white, fontSize: 40.0)),
        ),
        Container(height: 30.0,),
        // 容器外留白
        marginWidget,
        // 容器内留白
        paddingWidget,
      ],
    );
  }
}
