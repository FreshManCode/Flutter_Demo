import 'package:flutter/material.dart';
import 'package:myapp_flutter/Layout/flexLayout.dart';
import 'package:myapp_flutter/Layout/myFlexLayout.dart';
import 'package:myapp_flutter/Layout/rowAndColumn.dart';
import 'package:myapp_flutter/Layout/stackAndPositioned.dart';
import 'package:myapp_flutter/Layout/wrapAndFlow.dart';
import 'package:myapp_flutter/learnWidgetList.dart';

List<ListItem> _itemLists() {
  return [
    ListItem(title: "线性布局(Row和Column)", type: "FlexType"),
    ListItem(title: "(Row和Column)特殊情况", type: "FlexTypeSpecial"),
    ListItem(title: "Flex(弹性布局)", type: "FlexFlayoutType"),
    ListItem(title: "流式布局(Wrap,Flow)", type: "WarpAndFlowType"),
    ListItem(title: "层叠布局(Stack,Positioned)", type: "StackAndPositionedType"),
  ];
}

class MyLayoutList extends StatelessWidget {
  
  didClickItem(ListItem item, BuildContext context) {
    var widget;
    if (item.type == "FlexType") {
      widget = FlexLayoutRoute();
    }
    else if (item.type == "FlexTypeSpecial") {
      widget = RowAndColumnSpecialRoute();
    }
    else if (item.type == "FlexFlayoutType") {
      widget = MyFlexLayoutRoute();
    }
    else if (item.type == "WarpAndFlowType") {
      widget = MyWrapAndFlowRoute();
    }
    else if (item.type == "StackAndPositionedType") {
      widget = MyStackAndPositionedRoute();
    }
    
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(title: Text("${item.title}"),),
        body: widget,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final tiles = _itemLists().map((e) {
      return WidgetListItem(
          product: e,
          clickWidgetItem: (e) {
            didClickItem(e, context);
          });
    });

    final diveded = ListTile.divideTiles(
      tiles: tiles,
      color: Colors.yellow,
      context: context,
    ).toList();

    return Scaffold(
      body: Material(
        child: ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: diveded,
        ),
      ),
    );
  }
}
