
import 'package:flutter/material.dart';

/**
 * Form 的子孙元素必须是FormFiled类型,FormFiled 是一个抽象类.
 
 * FormState:
  FormState为Form的State类，可以通过Form.of()或GlobalKey获得。
  我们可以通过它来对Form的子孙FormField进行统一操作。我们看看其常用的三个方法：

  >.FormState.validate():调用此方法后,会调用Form子孙FormField的validate回调,
  如果有一个校验失败,则返回false,所有校验失败项都会返回用户返回的错误提示.
  >.FormState.save():调用此方法后,会调用Form子孙FormField的save回调,用于保存保单内容.

  >.FormState.reset():调用此方法后,会将子孙FormField的内容清空.

  如下事例:
  登录注册案例:在提交之前校验:
  1.用户名不能为空,如果为空则提示'用户名不能为空'
  2.密码不能小于6位,如果小于6位则提示'密码不能小于6位'
 
 */

class FormTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormTestRouteState();
  }
}

class _FormTestRouteState extends State<FormTestRoute> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:16.0,horizontal:24.0),
        child: Form(
          // 设置globalKey,用于后面获取FormState
          key: _formKey,
          // 开启自动校验
          autovalidate: true,
          child: Column(
            children:[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person),
                ),
                // 校验用户名
                validator: (v) {
                  return (v != null && v.trim().length > 0) ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (v) {
                  return (v != null && v.trim().length > 5) ? null : "密码不能少于6位";
                },
              ),

              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top:28.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(onPressed: (){
                        // 通过_fromKey.currentState获取FormState后,调用validate()方法校验用户名密码
                        // 是否合法,校验通过后再提交数据
                        if((_formKey.currentState as FormState).validate()) {
                          print("验证通过");
                        }
                      },
                      child: Text('登录'),
                      // color: Theme.of(context).primaryColor,
                      color: Colors.blue,
                      textColor: Colors.white,

                      ),

                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
