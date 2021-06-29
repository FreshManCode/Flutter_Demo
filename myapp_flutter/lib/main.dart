import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:myapp_flutter/MyLearn/localAssets.dart';
import 'package:myapp_flutter/MyLearn/nameRoute.dart';
import 'package:myapp_flutter/MyLearn/route.dart';
import 'package:myapp_flutter/functionalWidget/functionalWidgetList.dart';
import 'package:myapp_flutter/learnWidgetList.dart';
import 'widgetOne.dart';

/* 
Text:该Widget可让创建一个带格式的文本

Row,Column:这些具有弹性空间的布局类Widget可让您在水平(Row)和垂直(Column)方向上创建灵活的布局.

Stack:取代线性布局(Stack允许子widget堆叠,可以使用Positioned来定位他们相对于Stack的上下左右四条边的位置)

Container:可创建矩形视觉元素.container可以装饰为一个BoxDecoration,如background.一个边框,或者一个阴影.Container也可以具有
边距(margins),填充(padding)和应用于其大小的约束(constraints).


*/

void main() {
  // runApp 函数接受给定的Widget并使其成为widget树的根.
  // 框架强制Widget覆盖整个屏幕
  runApp(MyApp());
}

// StatelessWidget 无状态的Widget
// StatefulWidget 有状态的Widget

// 注册路由表,在MyApp 类的build方法中找到MaterialApp,添加routes属性,如下代码:
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator1',
      // 不是通过路由的方式来使用home组件
      // home: new RandomWords(),
      // 使用home路由
      initialRoute: "/",
      // 应用主题 (修改主题为白色) (整个背景变为变色,包括导航栏)
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      // 注册路由表:
      routes: {
        "tips_route": (context) =>
            TipRoute(key: Key('TipRoute'), text: "路由表中注册过的路由"),
        // 注册home路由
        "/": (context) => RandomWords(),
        // 命名路由参数传递
        "name_route_params": (context) => NameRouteParams(),

        "local_assets": (context) => MyLocalAssets(),
      },
      // 可以看到,主需要在路由注册表中注册一下RandomWords路由,然后将其名为作为MaterialApp 的initialRoute
      // 属性即可,该属性决定了应用的初始路由是哪一个命名路由
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have cliked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List tabs = ["首页", "首页"];
  var _selectedIndex = 0;
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  Widget learnWidget = Scaffold(
    appBar: AppBar(
      title: Text("组件学习"),
    ),
    body: WidgetList(),
  );

  Widget functionalWidget = MyFunctionalWidgetListRoute();

  @override
  void initState() {
    super.initState();
    if (_tabController == null) {
      _tabController = TabController(length: tabs.length, vsync: this);
    }
    _tabController?.addListener(() {
      switch (_tabController?.index) {
        case 0:
          {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget homeWidget = Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        // 在AppBar 添加一个列表图标.当用户点击列表图标时,包含收藏夹的新路由页面入栈显示.
        actions: [
          new IconButton(onPressed: _pushSaved, icon: new Icon(Icons.list)),
          new IconButton(onPressed: _test, icon: new Icon(Icons.list_alt)),
        ],
      ),
      body: _buildSuggestions(),
    );

    List<Widget> homeWigets = [learnWidget, homeWidget, functionalWidget];

    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Startup Name Generator'),
      //   // 在AppBar 添加一个列表图标.当用户点击列表图标时,包含收藏夹的新路由页面入栈显示.
      //   actions: [
      //     new IconButton(onPressed: _pushSaved, icon: new Icon(Icons.list)),
      //     new IconButton(onPressed: _test, icon: new Icon(Icons.list_alt)),
      //   ],
      //   // bottom: TabBar(
      //   //   controller: _tabController,
      //   //   tabs: tabs
      //   //       .map((e) => Tab(
      //   //             text: e,
      //   //           ))
      //   //       .toList(),
      //   // ),
      // ),
      body: _selectedIndex < homeWigets.length ? homeWigets[_selectedIndex] : homeWigets.first ,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('组件学习'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            title: Text('功能型组件'),
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      drawer: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onAdd() {
    print("add event");
  }

// 添加_pushSaved 方法
// 当用户点击导航栏中的列表图标时,建立一个路由并将其推入到导航管理器栈中.此操作会切换页面以显示新路由.
// 新页面的内容在MaterialPageRoute的builder属性中构建,builder是一个匿名函数.
// 添加Navigator.push调用,这会使路由入栈
  _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map(
        (pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  _test() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('TestOne'),
        ),
        body: new MyScaffold(),
      );
    }));
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // 添加爱心
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // 添加交互
      // 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
