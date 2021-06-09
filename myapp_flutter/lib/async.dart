// 异步相关
import 'dart:io';
import 'dart:async';

main(List<String> args) {
  testAsyncFunction();
}

// 1.异步支持
// Dart库中包含许多返回Future或Stream对象的函数.这些函数在设置完耗时任务(例如I/O)后,就立即返回了
// 不会等待耗时任务完成.使用async和await关键字实现异步编程.可以像编写同步代码一样实现异步操作

// 2.处理Future
/**  
 * 可以通过下面两种方式,获得Future执行完成的结果
 * 使用async 和await
 * 使用Future API
 * 使用async和await关键字的代码是同步的.虽然看起来有点像同步代码.例如:下面的代码使用await等待异步函数的执行结果.
 * 要使用await,代码必须在异步函数(使用async标记的函数)中:
 * 
 * 注意:虽然异步函数可能会执行耗时的操作,但它不会等待这些操作.相反,异步函数只有在遇到第一个await表达式时才会执行.
 * 也就说,它返回一个Future对象,仅在await表达式完成后才恢复执行.
 */

// 异步函数学习
testAsyncFunction() {
  checkVersion();
  noReturnValue1();
}

// async 标记的异步函数
Future checkVersion() async {
  // 要使用await 代码必须在异步函数中
  var version = await lookUpVersion();
  print("version is:$version");

  // 使用try,catch,和finally来处理代码中使用await导致的错误:
  try {
    version = await lookUpVersion();
  } catch (e) {
    print('e is:$e');
  }

  // 在一个异步函数中可以多次使用await.例如,下面代码中等待了三次函数结果:
  var entryPoint = await findEntryPoint();
  print('entryPoint is:$entryPoint');

  var exitCode = await runExecutable(entryPoint);
  print("exitCode is:$exitCode");

  await noReturnValue();
}

String lookUpVersion() {
  // 延迟5s执行
  sleep(Duration(seconds: 2));
  return '1.0.0';
}

String  findEntryPoint() {
  sleep(Duration(seconds: 2));
  return "111";
}
String  runExecutable(String entryPoint) {
  sleep(Duration(seconds: 3));
  return "test_$entryPoint";
}

// 3.声明异步函数
/**
 * 函数体被async标识符标记的函数,即是一个异步函数.将async关键字添加到函数使其返回Future.如下:
 * 考虑下面的同步函数,它返回一个String:
 */
// 同步返回函数
String lookUpVersion1()=>"1.0.0";

// 下面将其更改为异步返回函数,返回值是Future
Future <String> lookUpVersion2() async =>"1.0.0";
// 注意,函数体不需要使用Future API.如果函数没有返回值,需要设置其返回类型为Future<void>或者 去掉类型,只有Fureture
Future <void> noReturnValue() async {
  print("noReturnValue");
}

// 文档注释时,使用///,除非使用中括号括起来,否则Dart编译器会忽略所有文本.使用中括号可以引用类,方法,字段,顶级变量,函数和参数等.
///[abac]
Future  noReturnValue1() async {
  print("noReturnValue");
}


