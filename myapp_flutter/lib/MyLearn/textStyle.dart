import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/*TextStyle的部分属性说明:
 * height :该属性用于指定行高,但不是一个绝对值,而是一个因子,具体的行高等于 fontSize * height
 * 
 */

class MyTextStyle extends StatelessWidget {
  var _gesture = TapGestureRecognizer();

  didClickRichText(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebviewScaffold(
        url: "https://blog.csdn.net/FreshManCode/article/details/115186296",
        withJavascript: true,
        ignoreSSLErrors: true,
        appBar: AppBar(
          title: Text("WebView"),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              "Hello World",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                height: 1.2,
                fontFamily: "Courier",
                background: Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            Text.rich(
              TextSpan(children: [
                TextSpan(text: "Home: "),
                TextSpan(
                  text:
                      "https://blog.csdn.net/FreshManCode/article/details/115186296",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                  recognizer: _gesture
                    ..onTap = () {
                      didClickRichText(context);
                      print("this is blok");
                    },
                ),
              ]),
            ),
            FlatButton(
              height: 40,
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text('Submit'),
              // 通过shape 来指定其外形为一个圆角矩形.因为按钮背景是蓝色(深色),需要指定按钮主题(colorBrightness 为)
              // Brightness.dark ,为了保证按钮文字颜色为浅色
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                print("这是自定义的蓝色背景的圆角按钮");
              },
            ),
          ],
        ),
      ),
    );
  }
}
