import 'dart:collection';
// 跨组件状态共享（Provider）
import 'package:flutter/material.dart';

// Provider
// 1.首先，我们需要一个保存需要共享的数据InheritedWidget，由于具体业务数据类型不可预期，为了通用性，
// 我们使用泛型，定义一个通用的InheritedProvider类，它继承自InheritedWidget：

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({required this.data, required Widget child})
      : super(child: child);
  // 共享状态使用模型
  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    // 返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`
    return true;
  }
}

// 现在，我们将要共享的状态放到一个Model类中，然后让它继承自ChangeNotifier，这样当共享的状态改变时，
// 我们只需要调用notifyListeners() 来通知订阅者，然后由订阅者来重新构建InheritedProvider，接下来我们便实现这个订阅者类：

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;
  ChangeNotifierProvider({required this.child, required this.data});

  // 定义一个便捷方法,方便子树中的widget获取共享数据
  // 添加一个listen参数,表示是否建立依赖关系.
  static T of<T>(BuildContext context,{bool listen = true}) {
    final provider = listen ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>() : 
    context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget as InheritedProvider<T>;
    return provider!.data;

    // 调用dependOnInheritedWidgetOfExactType() 和 getElementForInheritedWidgetOfExactType()的
    // 区别就是前者会注册依赖关系，而后者不会.
  }

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    // TODO: implement didUpdateWidget
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

/** 购物车示例
 *  实现一个显示购物车中所有商品总价的功能
 *  1.向购物车中添加新商品时总价更新,
 *  
 * */

// 定义一个Item类,用于表示商品信息
class ShoppingItem {
  double price;
  int count;
  ShoppingItem({required this.price, required this.count});
}

// 定义一个保存购物车内数据的CartModel 类:
class CartModel extends ChangeNotifier {
  //  用于保存购物车中商品列表:
  final List<ShoppingItem> _items = [];
  // 禁止改变购物车里的商品信息
  UnmodifiableListView<ShoppingItem> get items => UnmodifiableListView(_items);
  // 购物车中商品的总价
  double get totalPrice {
    return _items.fold(0, (value, item) => value + item.count * item.price);
  }

  // 将[item]添加到购物车,这是唯一一种能从外部改变购物车的方法.
  void add(ShoppingItem item) {
    _items.add(item);
    // 通知(订阅者),重新构建InheritedProvider ,更新状态
    notifyListeners();
  }
}

//  CartModel 即要跨组件共享的Model类.
class MyProviderRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProviderRouteState();
}

class _MyProviderRouteState extends State<MyProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: ChangeNotifierProvider(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  Builder(
                    builder: (context) {
                      var cart = ChangeNotifierProvider.of<CartModel>(context);
                      return Text("总价: ${cart.totalPrice}");
                      // 显示总价的代码,有可以优化的空间
                      // 1.需要显示调用ChangeNotifierProvider.of,当App内部依赖CartModel 很多时,这样的代码很冗余.
                      // 2.语义不明确;由于ChangeNotifierProvider 是订阅者,那么依赖CartModel的Widget自然就是订阅者,其实也是状态的消费者
                      // 如果我们用Builder来构建,语义就不是很明确;如果我们能使用Consumer,我们就知道它是依赖某个跨域组件或全局的状态.
                    },
                  ),
                  Builder(
                    builder: (context) {
                      // 该代码有一个性能问题，就在构建”添加按钮“的代码处：
                      // 我们点击”添加商品“按钮后，由于购物车商品总价会变化,但是”添加商品“按钮本身没有变化，是不应该被重新build的
                      print("RaisedButton build"); // 构建时输出日志
                      return RaisedButton(
                        onPressed: () {
                          //给购物车中添加商品，添加后总价会更新
                          ChangeNotifierProvider.of<CartModel>(context)
                              .add(ShoppingItem(price: 20.0, count: 1));
                        },
                        child: Text("Add"),
                      );
                    },
                  )
                ],
              );
            },
          ),
          data: CartModel(),
        ),
      ),
    );
  }
}

// 为了优化上述获取总价的相关问题,封装一个Consumer Widget,实现如下:
// MyConsumer 实现非常简单,它通过指定模板参数,然后再内部调用ChangeNotifierProvider.of 获取相应的Model,并且Consumer这个名字
// 本身也具有确切意义(消费者)
class MyConsumer<T> extends StatelessWidget {
  final Widget? child;
  final Widget Function(BuildContext context, T value) builder;
  MyConsumer({Key? key, required this.builder, this.child})
      : assert(builder != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      // 自动获取Model
      ChangeNotifierProvider.of<T>(context),
    );
  }
}

class MyProviderModifyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyProviderModifyRouteState();
  }
}

class _MyProviderModifyRouteState extends State<MyProviderModifyRoute> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: ChangeNotifierProvider(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  MyConsumer<CartModel>(
                    builder: (context, cart) => Text("总价: ${cart.totalPrice}"),
                  ),
                  Builder(
                    builder: (context) {
                      print("RaisedButton build"); // 构建时输出日志
                      return RaisedButton(
                        onPressed: () {
                          //给购物车中添加商品，添加后总价会更新
                          // listen 参数设置为false,不建立依赖关系
                          ChangeNotifierProvider.of<CartModel>(context,listen: false)
                              .add(ShoppingItem(price: 20.0, count: 1));
                        },
                        child: Text("Add"),
                      );
                    },
                  )
                ],
              );
            },
          ),
          data: CartModel(),
        ),
      ),
    );
  }
}
