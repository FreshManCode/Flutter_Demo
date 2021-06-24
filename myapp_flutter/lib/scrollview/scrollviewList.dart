import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myapp_flutter/learnWidgetList.dart';
import 'package:myapp_flutter/scrollview/gridView.dart';
import 'package:myapp_flutter/scrollview/listView.dart';
import 'package:myapp_flutter/scrollview/singleChildScrollView.dart';

List<ListItem> _items() {
  return [
    ListItem(title: "SingleChildScrollView", type: "SingleChildScrollViewType"),
    ListItem(title: "ListView", type: "ListViewType"),
    ListItem(title: "ListView_Seprator", type: "ListViewType_Seprator"),
    ListItem(title: "无限下拉ListView", type: "ListViewType_Infinite"),
    ListItem(title: "GridView(Simple)", type: "GridViewSimpleType"),
    ListItem(title: "GridView(Count)", type: "GridViewCountType"),
    ListItem(title: "GridView(MaxCrossAxisExtent)", type: "GridViewCrossAxisExtentType"),
    ListItem(title: "GridView(Extent)", type: "GridViewCrossAxisSimpleExtentType"),
    ListItem(title: "GridView.builder", type: "GridView.builderType"),
    
  ];
}

class MyScrollViewListRoute extends StatelessWidget {
  didClickItem(ListItem item, BuildContext context) {
    var myWidget;
    if (item.type == "SingleChildScrollViewType") {
      myWidget = MySinglechildScrollViewRoute();
    } else if (item.type == "ListViewType") {
      myWidget = MyListViewRoute(
        ListViewType: "SimpleListView",
      );
    } else if (item.type == "ListViewType_Seprator") {
      myWidget = MyListViewRoute(
        ListViewType: "SepratorListView",
      );
    } else if (item.type == "ListViewType_Infinite") {
      myWidget = MyInfiniteListView();
    } else if (item.type == "GridViewSimpleType") {
      myWidget = MyGridViewRoute(gridViewIndex: 0,);
    }
    else if (item.type == "GridViewCountType") {
      myWidget = MyGridViewRoute(gridViewIndex: 1,);
    }
    else if (item.type == "GridViewCrossAxisExtentType") {
      myWidget = MyGridViewRoute(gridViewIndex: 2,);
    }
    else if(item.type == "GridViewCrossAxisSimpleExtentType") {
      myWidget = MyGridViewRoute(gridViewIndex: 3,);
    }
    else if(item.type == "GridView.builderType") {
      myWidget = MyGridViewRoute(gridViewIndex: 4,);
    }
    // MaterialPageRoute
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
    // ListView中的Item
    final tiles = _items().map((e) {
      return WidgetListItem(
          product: e,
          clickWidgetItem: (e) {
            didClickItem(e, context);
          });
    });

    // 分割线
    final divied =
        ListTile.divideTiles(tiles: tiles, color: Colors.red).toList();

    return Scaffold(
      body: ListView(
        children: divied,
      ),
    );
  }
}
