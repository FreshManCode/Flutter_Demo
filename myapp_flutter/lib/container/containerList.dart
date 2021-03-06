import 'package:flutter/material.dart';
import 'package:myapp_flutter/container/container.dart';
import 'package:myapp_flutter/container/containerPadding.dart';
import 'package:myapp_flutter/container/decoratedBox.dart';
import 'package:myapp_flutter/container/sizeConstraintedBox.dart';
import 'package:myapp_flutter/container/transform.dart';
import 'package:myapp_flutter/learnWidgetList.dart';

class MyContainerListRoute extends StatelessWidget {
  didClickItem(ListItem item, BuildContext context) {
    var widget;
    if (item.type == "PaddingType") {
      widget = MyContainerPaddingRoute();
    } else if (item.type == "SizedConstraintedBoxType") {
      widget = MyConstrainedBoxRoute(
        type: 'ConstrainedBox',
      );
    } else if (item.type == "UnconstrainedBoxWidget") {
      widget = MyConstrainedBoxRoute(
        type: 'unconstrainedBoxWidget',
      );
    } else if (item.type == "DecoratedBoxType") {
      widget = MyDecoratedBoxRoute();
    } else if (item.type == "TransformType") {
      widget = MyTransformRoute();
    } else if (item.type == "Transform.translateType") {
      widget = MyTransformRoute(
        routeType: "Transform.translate",
      );
    } else if (item.type == "Transform.rotateType") {
      widget = MyTransformRoute(
        routeType: "Transform.rotate",
      );
    }
    else if (item.type == "Transform.scaleType") {
      widget = MyTransformRoute(
        routeType: "Transform.scale",
      );
    }
    else if (item.type == "RotatedBoxType") {
      widget = MyTransformRoute(
        routeType: "RotatedBox",
      );
    }
    else if (item.type == "ContainerType") {
      widget = MyContainerRoute();
    }
    

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          title: Text("${item.title}"),
        ),
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
      color: Colors.blue,
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

List<ListItem> _itemLists() {
  return [
    ListItem(title: "??????Padding", type: "PaddingType"),
    ListItem(title: "?????????????????????", type: "SizedConstraintedBoxType"),
    ListItem(
        title: "?????????????????????(UnconstrainedBox)", type: "UnconstrainedBoxWidget"),
    ListItem(title: "???????????????(DecoratedBox)", type: "DecoratedBoxType"),
    ListItem(title: "??????Transform", type: "TransformType"),
    ListItem(title: "??????Transform.translate", type: "Transform.translateType"),
    ListItem(title: "??????Transform.rotate", type: "Transform.rotateType"),
    ListItem(title: "??????Transform.scale", type: "Transform.scaleType"),
    ListItem(title: "RotatedBox(?????????Layout)", type: "RotatedBoxType"),
    ListItem(title: "Container", type: "ContainerType"),
  ];
}
