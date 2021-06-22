import 'package:flutter/material.dart';

/** Stack允许子组件堆叠,而Positioned用于根据stack的四个角来确定子组件的位置.
 
 * Stack 部分属性介绍:
 fit:用于确定没有定位的子组件如何去适应Stack的大小.StackFit.loose表示使用子组件的大小,StackFit.expand表示扩申到Stack的大小.
 overflow:决定如何显示超出Stack显示空间的子组件;值为:Overflow.clip,超出部分将会被裁剪(隐藏),值为Overflow.visible 不会.
 
 
 */

class MyStackAndPositionedRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyStackAndPositionedRoute();
}

class _MyStackAndPositionedRoute extends State<MyStackAndPositionedRoute> {
  var fit = false;
  changeFit() {
    setState(() {
      fit = !fit;
    });
  }
  @override
  Widget build(BuildContext context) {

    final unfitWidget =  ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Text(
              'Hello wordld',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
          // 只指定了水平方向定位left,垂直方向上没有定位,那么在垂直方向的对齐方式则会按照alignment指定的对齐方式对齐,即垂直方向居中
          Positioned(
            left: 18.0,
            child: Text('I am Jack'),
          ),
          // 水平方向无约束,默认居中,垂直方向上(top)有约束
          Positioned(
            top: 18.0,
            child: Text('Your friend'),
          ),

          Positioned(
            right: 18.0,
            child: RaisedButton(onPressed: ()=>changeFit(),child: Text("ToFit"),),
          ),
        ],
      ),
    );

    final autoFitWidget = Stack(
      alignment: Alignment.center,
      // 未定位的widget占满整个widget
      fit:StackFit.expand,
      children: [
        Positioned(child: Text('I am Jack'),left:18.0),
        Container(child: Text('Hello world',style: TextStyle(color: Colors.white),),color: Colors.red,),
        Positioned(child: Text('Your friend'),top:18.0),
        Positioned(child: RaisedButton(onPressed: ()=>changeFit(),child: Text('UnFit'),),bottom: 20,),
      ],
    );
    // 由于第二个组件没有定位,所以fit属性会对它起作用,就会占满Stack.由于Stack子元素是堆叠的,所以第一个组件被第二个遮住了,
    // 而第三个和第四个在上面一层,所以可以正常显示.

    return fit ? autoFitWidget :  unfitWidget;
  }
}
