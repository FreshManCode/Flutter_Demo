import 'package:flutter/material.dart';

/*
Material 组件库中提供了Material 风格的单选开关Switch和复选框Checkbox,虽然它们都继承自StatefullWidget
但它们本身不会保存当前选中状态,选中状态都是由父组件来管理的.当Switch或Checkbox被点击时,会触发
它们的onChanged回调,我们可以在此回调中处理选中状态改变逻辑.
 */

/*
Textfield 部分属性介绍:

focusNode:用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个句柄（handle）。
InputDecoration:用于控制TextField的外观显示，如提示文本、背景颜色、边框等
style:正在编辑的文本样式
obscureText:是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
maxLines:输入框的最大行数，默认为1；如果为null，则无行数限制。

maxLength和maxLengthEnforced ：maxLength代表输入框文本的最大长度,设置后输入框右下角会显示输入的文本计数.
maxLengthEnforced 决定当输入文本长度超过maxLength 时是否阻止输入,为true时会阻止输入,为false时
不会组织输入但输入框会变红.

* 获取输入内容:
>.获取输入内容有两种方式:
1.定义相应的变量,用于在onChange 触发时,各自保存一下输入内容
2.通过controller直接获取

* 监听文本变化
监听文本变化也有两种方式：

1.设置onChange回调，

2.通过controller监听，如本例:


* 控制焦点
焦点可以通过FocusNode 和 FocusScopeNode来控制,默认情况下，焦点由FocusScope来管理.可以通过
FoucsScope.of(context)来获取Widget树中默认的FocusScopeWidget.如下事例:

*监听焦点状态改变事件


 */

class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwitchAndCheckBoxTestRouteState();
  }
}

class _SwitchAndCheckBoxTestRouteState
    extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

// 管理焦点相关
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  // 定义controller,用户获取Textfiled的输入内容
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _listenController =
      TextEditingController(text: "AddListen");

  @override
  void initState() {
    super.initState();
    _listenController.selection = TextSelection(
        baseOffset: 2, extentOffset: _listenController.text.length);
    // 添加监听
    _listenController.addListener(() {
      print("_listenController:${_listenController.text}");
    });

//  监听焦点变化 (focusNode1必须与输入框进行绑定)
    focusNode1.addListener(() {
      // 获得焦点时focusNode1.hasFocus 为true,失去焦点时为false
      print(focusNode1.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value ?? false;
              });
            }),
        // 下面是TextField
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
          controller: _namecontroller,
        ),
        TextField(
          decoration: InputDecoration(
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        TextField(
          controller: _listenController,
        ),

        RaisedButton(
          onPressed: () {
            // 通过在创建Textfiled的时候绑定相应的Controller来获取输入框内容
            print("输入的用户名是:${_namecontroller.text}");
          },
          child: Text('获取输入内容'),
        ),

        TextField(
          focusNode: focusNode1,
          decoration: InputDecoration(
            labelText: "input1",
          ),
        ),
        TextField(
          focusNode: focusNode2,
          decoration: InputDecoration(
            labelText: "input2",
            // 未获得焦点时下划线设为灰色
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            // 获得焦点时下划线设置为蓝色
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
        ),

        RaisedButton(
          onPressed: () {
            if (focusScopeNode == null) {
              focusScopeNode = FocusScope.of(context);
            }
            focusScopeNode!.requestFocus(focusNode2);
          },
          child: Text("移动焦点"),
        ),
        RaisedButton(
          onPressed: () {
            focusNode1.unfocus();
            focusNode2.unfocus();
          },
          child: Text("隐藏键盘"),
        ),
        // 我们无法自定义下划线宽度.可以通过隐藏掉TextField本身的下划线,然后通过Container去嵌套,如下:
        Container(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "电子邮件地址",
              hintStyle: TextStyle(color: Colors.red,fontSize: 12.0),
              prefixIcon: Icon(Icons.email),
              // 隐藏下划线
              border: InputBorder.none,
            ),
          ),
          decoration: BoxDecoration(
            // 下划线黄色,宽度3.0
            border:Border(bottom: BorderSide(color: Colors.yellow,width:3.0))
          ),
        )
      ],
    );
  }
}
