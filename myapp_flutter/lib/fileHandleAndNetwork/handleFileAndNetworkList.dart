import 'package:flutter/material.dart';
import 'package:myapp_flutter/fileHandleAndNetwork/fileHandle.dart';
import 'package:myapp_flutter/learnWidgetList.dart';

List<ListItem> _list() {
  return [
    ListItem(title: "文件操作", type: "handleFile"),
  ];
}

class MyHandleFileAndNetworkListRoute extends StatelessWidget {
  didClickItem(BuildContext context, ListItem item) {
    var myWiget;
    if (item.type == "handleFile") {
      myWiget = MyFileOperationRoute();
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(item.title),
        ),
        body: myWiget,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (
        context,
        index,
      ) {
        final item = _list()[index];
        return ListTile(
          title: Text("${item.title}"),
          onTap: () {
            didClickItem(context, item);
          },
          trailing: Icon(Icons.arrow_forward_ios),
        );
      },
      itemCount: _list().length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.red,
          height: 1.5,
        );
      },
    );
  }
}
