import 'package:flutter/material.dart';
import 'package:myapp_flutter/Layout/myLayout.dart';
import 'package:myapp_flutter/MyLearn/appBar.dart';
import 'package:myapp_flutter/MyLearn/bottomNavigationBar.dart';
import 'package:myapp_flutter/MyLearn/container.dart';
import 'package:myapp_flutter/MyLearn/cupertino.dart';
import 'package:myapp_flutter/MyLearn/formTableType.dart';
import 'package:myapp_flutter/MyLearn/image.dart';
import 'package:myapp_flutter/MyLearn/localAssets.dart';
import 'package:myapp_flutter/MyLearn/progressIndicator.dart';
import 'package:myapp_flutter/MyLearn/route.dart';
import 'package:myapp_flutter/MyLearn/row.dart';
import 'package:myapp_flutter/MyLearn/stateManage.dart';
import 'package:myapp_flutter/MyLearn/switchAndCheckbox.dart';
import 'package:myapp_flutter/MyLearn/textStyle.dart';
import 'package:myapp_flutter/container/containerList.dart';
import 'package:myapp_flutter/fileHandleAndNetwork/handleFileAndNetworkList.dart';
import 'package:myapp_flutter/scrollview/scrollviewList.dart';
import 'package:myapp_flutter/two.dart';

typedef void DidClickWidgetItem(ListItem);
// List<ListItem> _list = [
//   ListItem(title: "Container组件", type: "ContainerType"),
//   ListItem(title: "Row组件", type: "RowType"),
//   ListItem(title: "Image组件", type: "ImageType"),
//   ListItem(title: "AppBar组件", type: "AppBarType"),
//   ListItem(title: "BottomNavigationBar组件", type: "BottomNavigationBarType"),
//   ListItem(title: "Route组件", type: "RouteType"),
// ];

List<ListItem> _itemLists() {
  return [
    ListItem(title: "Container组件", type: "ContainerType"),
    ListItem(title: "Row组件", type: "RowType"),
    ListItem(title: "Image组件", type: "ImageType"),
    ListItem(title: "AppBar组件", type: "AppBarType"),
    ListItem(title: "BottomNavigationBar组件", type: "BottomNavigationBarType"),
    ListItem(title: "Route组件", type: "RouteType"),
    ListItem(title: "路由名方式组件", type: "RouteNameType"),
    ListItem(title: "命名路由参数传递", type: "NameRouteNameType"),
    ListItem(title: "本地资源包管理", type: "LocalResourceType"),
    ListItem(title: "Cupertino组件", type: "CupertinoType"),
    ListItem(title: "状态管理", type: "StateManageType"),
    ListItem(title: "文本及样式", type: "TextStyleType"),
    ListItem(title: "单选开关和复选框", type: "SwitchAndCheckboxType"),
    ListItem(title: "Form表单", type: "FormTableType"),
    ListItem(title: "进度指示器", type: "ProgressIndicatorType"),
    ListItem(title: "布局类组件", type: "FlowLayoutType"),
    ListItem(title: "容器类组件", type: "MyContainerType"),
    ListItem(title: "可滚动组件", type: "ScrollViewType"),
    ListItem(title: "文件操作与网络请求List", type: "HandleFileAndNetworkList"),
  ];
}

class WidgetListItem extends StatelessWidget {
  final DidClickWidgetItem clickWidgetItem;
  WidgetListItem({required this.product, required this.clickWidgetItem});
  final ListItem product;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        this.clickWidgetItem(product);
      },
      leading: new Icon(Icons.tag_faces),
      title: new Text(product.title),
      trailing: new Icon(Icons.arrow_forward_ios),
    );
  }
}

_asyncPush(Widget widget, BuildContext context) async {
  var result =
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
  print("result is :$result");
}

class WidgetList extends StatelessWidget {
  final bool? customAppBar;
  WidgetList({this.customAppBar});
  didClickItem(ListItem item, BuildContext context) {
    var widget;
    if (item.type == 'ContainerType') {
      widget = new MyContainer();
    } else if (item.type == "RowType") {
      widget = new MyRow();
    } else if (item.type == "ImageType") {
      widget = new MyImage();
    } else if (item.type == "AppBarType") {
      widget = new MyAppBar();
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          body: widget,
        );
      }));
      return;
    } else if (item.type == 'BottomNavigationBarType') {
      widget = new MyBottomNaigationBarApp();
    } else if (item.type == 'RouteType') {
      _asyncPush(TipRoute(key: Key('TipRoute'), text: "我是谁啊"), context);
      return;
    }
    // 路有名方式打开新路由
    // 要通过路由名称来打开新路由,可以使用Navigator的pushNamed方法:
    else if (item.type == 'RouteNameType') {
      // tips_route 该路由在首页的时候时进行注册的,否则无法通过路由方式访问
      Navigator.pushNamed(context, "tips_route");
      return;
    }
    // 命名路由参数传递
    else if (item.type == 'NameRouteNameType') {
      // 在打开路由时传递参数
      Navigator.pushNamed(context, "name_route_params", arguments: "hi,我是谁");
      return;
    }
    // 本地资源包管理
    else if (item.type == 'LocalResourceType') {
      Navigator.pushNamed(context, "local_assets", arguments: "加载本地资源是吧");
      return;
    } else if (item.type == 'CupertinoType') {
      widget = CupertionTestRoute();
      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          body: widget,
        );
      }));
      return;
    }
    // 状态管理
    else if (item.type == "StateManageType") {
      widget = StateManagerContainer();
    }
    // 文本及样式
    else if (item.type == "TextStyleType") {
      widget = MyTextStyle();
    }
    // 单选开关和复选框
    else if (item.type == "SwitchAndCheckboxType") {
      widget = SwitchAndCheckBoxTestRoute();
    }
    // form表单
    else if (item.type == "FormTableType") {
      widget = FormTestRoute();
    }
    // 进度指示器
    else if (item.type == "ProgressIndicatorType") {
      widget = MyProgressIndicator();
    }
    // 布局类组件
    else if (item.type == "FlowLayoutType") {
      widget = MyLayoutList();
    }
    // 容器类组件
    else if (item.type == "MyContainerType") {
      widget = MyContainerListRoute();
    }
    // TODO:可滚动组件
    else if (item.type == "ScrollViewType") {
      widget = MyScrollViewListRoute();
    } else if (item.type == "HandleFileAndNetworkList") {
      widget = MyHandleFileAndNetworkListRoute();
    }

    print("点击了item:$item");
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('${item.title}'),
        ),
        body: widget,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final tiles = _itemLists().map(
      (pair) {
        return new WidgetListItem(
          product: pair,
          clickWidgetItem: (pair) {
            this.didClickItem(pair, context);
          },
        );
      },
    );

// 添加分割线
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
      color: Colors.red,
    ).toList();

    return new Material(
      child: new ListView(
        // 设置每个Row的高度
        itemExtent: 60.0,
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: divided,
      ),
    );
  }
}

class ListItem {
  final String title;
  final String type;
  ListItem({required this.title, required this.type});
}
