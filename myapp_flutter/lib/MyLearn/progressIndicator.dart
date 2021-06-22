import 'package:flutter/material.dart';
/*
LinearProgressIndicator,是一个线性,条状的进度条,主要参数如下:
1.value: value 表示当前的进度,取值范围为[0,1];如果value为null时,则指示器会执行一个循环动画(模糊进度);
当value不为null时,指示器为一个具体进度的进度条.

2.backgroundColor:指示器的背景色

3.valueColor:指示器的进度条颜色;值得注意的是,该类型是Animation<Color>,这允许我们对进度条的颜色也可以指定动画.
如果我们不需要对进度条颜色执行动画,换言之,我们相对进度条应用一种固定的颜色,
此时我们可以通过AlwaysStoppedAnimation来指定.

CircularProgressIndicator
CircularProgressIndicator 是一个圆形进度条,事例如下:


*/

class MyProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressIndicatorState();
  }
}

class _ProgressIndicatorState extends State<MyProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  startAnimate() {
    if (_animationController == null) {
      _animationController =
          AnimationController(vsync: this, duration: Duration(seconds: 3));
      _animationController?.forward();
      _animationController?.addListener(() {
        setState(() {});
      });
    } 
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(15),
      child: Center(
        child: Column(
          children: [
            Text('这是LinearProgressIndicator指示器事例'),
            Container(
              height: 15,
            ),
            // 模糊进度条(会执行一个动画)
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            Container(
              height: 10,
            ),
            // 进度条显示50%
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),

            // CircularProgressIndicator 圆形进度条
            Text('这是CircularProgressIndicator指示器事例'),
            Container(
              height: 15,
            ),
            // 模糊进度条(执行旋转动画)
            CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            Container(
              height: 10,
            ),
            // 进度条显示50%,会显示一个半圆
            CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
            Container(
              height: 15,
            ),
            Text('自定义尺寸'),
            Container(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: // 线性进度条高度为3
                      SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                      value: .5,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  width: 10,
                )),
                Expanded(
                    child: // 圆形进度条直径指为100
                        SizedBox(
                  // 如果宽高不等,CircularProgressIndicator显示空间的高度不同,则会显示为椭圆
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    value: .7,
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: RaisedButton(
                  child: Text('开启动画'),
                  onPressed: () {
                    startAnimate();
                  },
                )),
                Expanded(
                    child: Container(
                  width: 5,
                )),
                Expanded(
                  child: Padding(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: _animationController != null
                          ? ColorTween(begin: Colors.grey, end: Colors.blue)
                              .animate(_animationController!)
                          : AlwaysStoppedAnimation(Colors.grey),
                      value: _animationController?.value,
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
