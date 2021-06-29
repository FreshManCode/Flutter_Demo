import 'package:flutter/material.dart';
/** 组合现有组件
 * 事例:自定义渐变按钮; Flutter Material组件库中的按钮默认不支持渐变背景
 * 为了实现渐变背景按钮，我们自定义一个GradientButton组件，它需要支持一下功能：
 * 1.背景支持渐变色
 * 2.手指按下时有涟漪效果
 * 3.可以支持圆角
 */

// DecoratedBox可以支持背景色渐变和圆角，InkWell在手指按下有涟漪效果
// 所以我们可以通过组合DecoratedBox和InkWell来实现GradientButton
class MyGradientButton extends StatelessWidget {
  final List<Color>? colors;
  final double? width;
  final double? height;
  final Widget child;
  final BorderRadius? borderRadius;
  final GestureTapCallback onPressed;

  MyGradientButton(
      {this.colors,
      this.width,
      this.height,
      required this.child,
      this.borderRadius,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCompositeWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MyGradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            child: Text("Submit"),
            onPressed: onTap,
            width: 100.0,
          ),
          MyGradientButton(
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green],
            child: Text("Submit"),
            onPressed: onTap,
          ),
          MyGradientButton(
            height: 50.0,
            colors: [Colors.lightBlue, Colors.blueAccent],
            child: Text("Submit"),
            onPressed: onTap,
          ),
        ],
      ),
    );
    
  }

  onTap() {
    print("button click");
  }

}