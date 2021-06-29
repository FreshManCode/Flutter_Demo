import 'package:flutter/material.dart';
// 组合实例：TurnBox
// 本节我们将实现一个TurnBox组件，它不仅可以以任意角度来旋转其子节点，而且可以在角度发生变化时执行一个动画以过渡到新状态，
// 同时，我们可以手动指定动画速度。

class MyTurnBox extends StatefulWidget {
  const MyTurnBox({
    Key? key,
    this.turns = .0,
    this.speed = 200,
    required this.child,
  }) : super(key: key);
  final double? turns;
  final int? speed;
  final Widget child;
  @override
  State<StatefulWidget> createState() {
    return _MyTurnBoxState();
  }
}

class _MyTurnBoxState extends State<MyTurnBox>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    if (_controller == null) {
      _controller = AnimationController(
          vsync: this,
          lowerBound: -double.infinity,
          upperBound: double.infinity);
    }
    _controller?.value = widget.turns!;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller!,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant MyTurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller?.animateTo(
        widget.turns!,
        duration: Duration(milliseconds: widget.speed ?? 200),
        curve: Curves.easeOut,
      );
    }
  }
  // 上述代码中:
  // 1.我们是通过组合RotationTransition和child来实现的旋转效果。
  // 2.在didUpdateWidget中，我们判断要旋转的角度是否发生了变化，如果变了，则执行一个过渡动画。
}

// 下面进行MyTurnBox 组件功能测试
class MyTurnBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTurnBoxRouteState();
  }
}

class _MyTurnBoxRouteState extends State<MyTurnBoxRoute> {
  double _turns = .0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          MyTurnBox(
            turns: _turns,
            speed: 500,
            child: Icon(
              Icons.refresh,
              size: 50,
            ),
          ),
          MyTurnBox(
            turns: _turns,
            speed: 1000,
            child: Icon(
              Icons.refresh,
              size: 150,
            ),
          ),
          RaisedButton(
            child: Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          RaisedButton(
            child: Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          ),
        ],
      ),
    );
  }
}
