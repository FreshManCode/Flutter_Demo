import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class MyLocalAssets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLocalAssetsState();
  }
}

class MyLocalAssetsState extends State<MyLocalAssets> {
  var showImage = false;
  var showImage2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("本地资源加载"),
      ),
      body: Center(
        child: Column(
          children: [
            new RaisedButton(
              onPressed: _loadLocalJson,
              child: Text("Load Local Json"),
            ),
            new RaisedButton(
              onPressed: () => _loadLocalImage(),
              child: Text(showImage ? "Hide Load Image" : "Load Local Image"),
            ),
            // 动态隐藏组件1:
            showImage
                ? Image.asset(
                    'assets/images/image_one.jpeg',
                    height: 100,
                  )
                :
                // 如果需要隐藏的时候Container 组件来个占位的
                 new Container(height: 0.0, width: 0.0),
            new RaisedButton(
              onPressed: () => _loadLocalImage2(),
              child: Text(showImage2 ? "Dynamic Show" : "Dynamic Hide"),
            ),
            // 动态隐藏组件2 (Offstage中的offstage属性标识组件是否隐藏)
            new Offstage(
              offstage: !showImage2,
              child: Image.asset(
                'assets/images/9.png',
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadLocalJson() async {
    print("加载本地JSON");
    // 加载本地json
    final result = await rootBundle.loadString('assets/test.json');
    print("result is:$result");
  }

  _loadLocalImage() {
    final msg = showImage ? "show" : "hide";
    print('$msg local image');
    setState(() {
      showImage = !showImage;
    });
  }

  _loadLocalImage2() {
    final msg = showImage2 ? "show" : "hide";
    print('dynamic $msg  local image');
    setState(() {
      showImage2 = !showImage2;
    });
  }
}
