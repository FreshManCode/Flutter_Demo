//功能型组件列表
import 'package:flutter/material.dart';
import 'package:myapp_flutter/functionalWidget/ProviderWidget.dart';
import 'package:myapp_flutter/functionalWidget/callback.dart';
import 'package:myapp_flutter/functionalWidget/compositTurnBoxWidget.dart';
import 'package:myapp_flutter/functionalWidget/compositeCurrentWidget.dart';
import 'package:myapp_flutter/functionalWidget/customPaintWidget.dart';
import 'package:myapp_flutter/functionalWidget/dialog.dart';
import 'package:myapp_flutter/functionalWidget/futureUI.dart';
import 'package:myapp_flutter/functionalWidget/inheritedWidget.dart';
import 'package:myapp_flutter/functionalWidget/paintGradientWidget.dart';
import 'package:myapp_flutter/functionalWidget/willPopScope.dart';
import 'package:myapp_flutter/learnWidgetList.dart';

class MyFunctionalWidgetListRoute extends StatelessWidget {
  var myWidget;
  didClickItem(BuildContext context, ListItem item) {
    if (item.type == "WillPopScope") {
      myWidget = MyWillPopScopeRoute();
    }
    else if (item.type == "InheritedWidget") {
      myWidget = MyInheritedWidgetRoute();
    }
    else if (item.type == "ProviderWidget") {
      myWidget = MyProviderRoute();
    }
    else if (item.type == "ModifyProviderWidget") {
      myWidget = MyProviderModifyRoute();
    }
    else if (item.type == "FutureUIWidget") {
      myWidget = MyFutureBuilderRoute();
    }
    else if (item.type == "StreamBuilderUIWidget") {
      myWidget = MyStreamBuilderRoute();
    }
    else if(item.type == "DialogWidget") {
      myWidget = MyAlertDialogRoute();
    }
    else if(item.type == "CallBackWidget") {
      myWidget = MyCallBackLearnRoute();
    }
    else if(item.type == "CompositeCurrentWidget") {
      myWidget = MyCompositeWidgetRoute();
    }
    else if (item.type == "CompositTurnBoxWidget") {
      myWidget = MyTurnBoxRoute();
    }
    else if(item.type == "CustomPaintWidget") {
      myWidget = MyCustomPaintRoute();
    }
    else if (item.type == "CustomPaintGradientWidget") {
      myWidget = MyGradientCircularProgressRoute();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(item.title),
        ),
        body: myWidget,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final titles = _itemLists().map((e) {
      return WidgetListItem(
        clickWidgetItem: (e) {
          didClickItem(context, e);
        },
        product: e,
      );
    });
    final divider =
        ListTile.divideTiles(tiles: titles, color: Colors.red).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("功能型组件列表"),
      ),
      body: ListView(
        children: divider,
      ),
    );
  }
}

List<ListItem> _itemLists() {
  return [
    ListItem(title: "导航返回拦截(WillPopScope)", type: "WillPopScope"),
    ListItem(title: "数据共享(InheritedWidget)", type: "InheritedWidget"),
    ListItem(title: "跨组件状态共享（Provider）", type: "ProviderWidget"),
    ListItem(title: "跨组件状态共享优化（Provider）", type: "ModifyProviderWidget"),
    ListItem(title: "异步UI更新（FutureBuilder）", type: "FutureUIWidget"),
    ListItem(title: "异步UI更新（StreamBuilder）", type: "StreamBuilderUIWidget"),
    ListItem(title: "对话框学习", type: "DialogWidget"),
    ListItem(title: "回调函数功能学习", type: "CallBackWidget"),
    ListItem(title: "组合现有组件", type: "CompositeCurrentWidget"),
    ListItem(title: "组合实例TurnBox", type: "CompositTurnBoxWidget"),
    ListItem(title: "自绘组件(CustomPaint与Canvas)", type: "CustomPaintWidget"),
    ListItem(title: "自绘组件(圆形背景渐变进度条)", type: "CustomPaintGradientWidget"),
  ];
}
