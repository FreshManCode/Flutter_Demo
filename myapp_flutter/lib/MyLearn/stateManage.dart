import 'package:flutter/material.dart';

class StateManagerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            TapBoxA(),
            ParentWidget(),
            ParentWidgetC(),
          ],
        ),
      ),
    );
  }
}

/* 1.Widget管理自身状态
1.管理_TapboxState类
2.定义_active:确定盒子的当前颜色的布尔值
3.定义_handleTap()函数,该函数在点击该盒子时更新_active,并调用setState()更新UI
4.实现Widget的所有交互式行为
*/

class TapBoxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TapBoxAState();
  }
}

class _TapBoxAState extends State<StatefulWidget> {
  bool _active = false;

  _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? "Active" : "Inactive",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

/*2.父Widget 管理子Widget状态
对于父Widget来说,管理状态并告诉其子Widget何时更新通常是比较好的方式.在本例中,TapboxB通过回调将其状态导出到其父组件,
状态由父组件管理,因此它的父组件为StatefullWidget.但是由于TapboxB不管理任何状态,所以TapBoxB为StatelessWidget.

ParentWidgetState类:
1.为TapboxB管理_active状态
2.实现_handleTapboxChanged(),当盒子被点击时调用的方法.
3.当状态改变时,调用setState()更新UI.

TapboxB类:
1.继承StatelessWidget类,因为所有状态都由其父组件管理.
2.当检测到点击时,会通知父组件.
*/

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TapBoxB(
          key: Key("TapBoxB"),
          active: _active,
          onChanged: _handleTapboxChanged),
    );
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({required Key key, required this.active, required this.onChanged});
  final bool active;
  final ValueChanged<bool> onChanged;

  _handleTop() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTop,
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[50] : Colors.lightBlue[600],
        ),
        child: Text(
          active ? "Active" : "InActive",
          style: new TextStyle(fontSize: 32.0, color: Colors.white),
        ),
      ),
    );
  }
}

// TODO:混合管理状态
/** 3.混合管理状态
 * 对于一些组件来说,混合管理的方式会非常有用.在这些情况下,组件自身管理一些内部状态,而父组件管理一些其他外部状态
 * 本例:TapboxC事例中,手指按下时,盒子的周围会出现一个深绿色的边框,抬起时,边框消失.点击完成后,盒子的颜色改变.
 * TapboxC将其_active状态导出到其父组件中,但在内部管理_highlight状态.这个例子有两个状态对象_ParentWidgetState
 * 和_TapboxCState
 * 
 * 
 * _ParentWidgetStateC类:

管理_active 状态。
实现 _handleTapboxChanged() ，当盒子被点击时调用。
当点击盒子并且_active状态改变时调用setState()更新UI。
 
 
 * _TapboxCState对象
 * 1.管理_highlight状态
 * 2.GestureDector监听所有tap事件.当用户点下时,它添加高亮(深绿色边框);当用户释放时,会移除高亮.
 * 3.当按下,抬起,或者取消点击时更新_highlight状态,调用setState()更新UI
 * 4.当点击时,将状态的改变传递给父组件.
 */

class ParentWidgetC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;
  _handleTapboxCChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapboxC(
        key: Key("TapboxC"),
        active: _active,
        onChanged: _handleTapboxCChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxC({ Key? key, this.active: false, required this.onChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TapboxCState();
  }
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? "Active" : "Inactive",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.red[700] : Colors.grey[200],
          border: _highlight
              ? Border.all(
                  width: 10.0,
                  color: Colors.teal,
                )
              : null,
        ),
      ),
    );
  }
}
