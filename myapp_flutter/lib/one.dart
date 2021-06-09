// Dart语言学习1
// dart语言从mian函数执行,Dart语言是需要;切记需要标点符号
//
import 'dart:math';
main(List<String> args) {
  print('1111:$args');
  enableFlags(true, false);
  // 级联运算符
  associcationOperator();
  // 类的构造函数相关
  learnInitMethodOfClass();
}

// 定义一个函数,有两个参数,无返回值
enableFlags(bool bold, bool hidden) {
  print("bold is:$bold ,hidden is:$hidden");
  print("myResult is:${myResult(1, 2)}");

  print(say("KangKang", "你好哦")); //KangKang says 你好哦
  print(say("李白", "我是诗仙","我没有手机用")); //李白 says 我是诗仙 with a 我没有手机用

// list/map,可以作为默认值传递.
  doStuff();

  learnMapAndList();

// getter/setter方法
  getterAndSetterMethod();

}

// 定义一个有参数,有返回值的函数
int myResult(int one, int two) {
  return one + two;
}

// 位置可选参数,将参数放到[]中来标记参数是可选的,同时可以使用'='来给可选参数定义默认值.
// 默认值只是编译时常量,如果没有提供默认之后,则默认值为null
String say(String from,String msg,[String device=""]) {
  var result = '$from says $msg';
  if (device.length > 0) {
    result = '$result with a $device';
  }
  return result;

}

// list/map,可以作为默认值传递.
void doStuff( 
  {List<int> list = const [1,2,3],
  Map<String,String> gifts = const {
    'first':'paper',
    'second':'cotton',
    'third':'leather',}}) {
      print('list:$list');
      print('gifts:$gifts');
}
// Map/List学习
learnMapAndList() {
  final person = {
    'name':'李白',
    'age':'18',
  };
  final persons = [person,person];
  print('person is:$person \n persons:$persons');
}


// 级联运算符 (..)可以实现对一个对象进行一系列的操作.除了调用函数,还可以访问同一对象上的字段属性.
// 如下代码:

// 级联运算符事例
associcationOperator() {
  // 下面使用级联运算符进行相关操作
  final addressBook = (AddressBookBuilder()
        ..address = "北京"
        ..name = "皇帝"
        ..age  = '188'
  );
  addressBook.printMyIdCard();
      
}

// 定义了一个AddressBookBuilder 类
class AddressBookBuilder {
  var name;
  var age;
  var address;
  
  printMyIdCard() {
    print("My name is:$name age is:$age address is:$address");
  }
}

// 类的构造函数
learnInitMethodOfClass() {
  final point = Point(10, 20);
  // 命名构造函数
  Point.orgin();
  // 
  var emp = new Employee.fromJson({});

  // 使用初始化列表可以很方便的设置final字段.如该示例:
  var p = new PointOne(2,3);
  // 3.605551275463989
  print(p.distanceFromOrigin);
}


// 类的构造函数
class Point {
  var  x ,y ;
  // 通过创建一个与类同名的函数来声明构造函数(另外,还可以附加一个额外的可选标识符,如下事例:)
  // 下面的方法更简洁
  Point(num x, num y) {
    this.x = x;
    this.y = y;
  }

  // 通常模式下,会将构造函数传入的参数的值赋给对应的实例变量,Dart自身的语法糖精简了这些代码:

  // 默认构造函数:
  // 在没有声明构造函数的情况下,Dart会提供一个默认的构造函数.默认构造函数没有参数并会调用父类的无参构造函数.

  // 构造函数不被继承:
  // 子类不会继承父类的构造函数.子类不声明构造函数,那么它就只有默认构造函数

  // 命名构造函数
  // 使用命名构造函数可以为一个类实现多个构造函数,也可以使用命名构造函数来更清晰的表明函数意图:

// 命名构造函数
// 切记:构造函数不能够被继承,这意味着父类的命名构造函数不会被子类继承.如果希望使用父类中定义的命名构造函数创建子类,就必须在子类中实现构造函数.
  Point.orgin() {
    x = 0;
    y = 0;
  }

// 初始化列表:除了调用超类构造函数之外,还可以在构造函数体执行之前初始化实例变量.各参数的初始化用逗号分隔.
Point.fromJson(Map<String,num>json) 
  :x = json['x'],
   y = json['y'] {
     print("In Point.fromJson():($x,$y)");
   }
  // 初始化程序的右侧无法访问this. 
}

class PointOne {
  final  x ,y ;
  final num distanceFromOrigin;
   // 通常模式下,会将构造函数传入的参数的值赋给对应的实例变量,Dart自身的语法糖精简了这些代码:
  PointOne(x,y)
        :x = x,
         y = y,
         distanceFromOrigin = sqrt(x * x + y * y);
}

class Person {
  var firstName;
  Person.fromJson(Map data) {
    print("in Person");
  }
}

//  Employee 类的构造函数调用了父类的Person的命名构造函数.
class Employee extends Person {
  Employee.fromJson(Map data): super.fromJson(data) {
    print("in Employee");
  }
}

// 重定向构造函数:
// 有时构造函数的唯一目的是重定向到同一个类中的另一个构造函数.重定向构造函数的函数体为空,构造函数的调用在冒号(:)之后.
class PointTwo {
  var x , y;
  PointTwo(this.x,this.y);
  // 指向主构造函数:
  PointTwo.alongXAxis(num x):this(x,0);
}

// 常量构造函数
// 如果该类生成的对象是固定不变的,那么就可以把这些对象定义为编译时常量.为此,需要定义一个const构造函数,并且声明所有实例变量为final.
class ImmutablePoint {
  static final ImmutablePoint origin = 
  const ImmutablePoint(0,0);

  final x,y;
  const ImmutablePoint(this.x,this.y);
}

// 工厂构造函数
// 当执行构造函数并不总是创建这个类的一个新实例时,则使用factory关键字.例如:一个工程构造函数可能会返回一个cache中的实例,或者可能返回
// 一个子类的实例.如下:
class Logger {
  final String name;
  bool mute = false;

  // 从命名的_可以知,_cache 是私有属性.
  static final Map<String,Logger> _cache = <String,Logger>{};
  factory Logger(String name) {
    if (_cache.containsKey(name) && _cache[name] != null  ) {
      return _cache[name]!;
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }
  Logger._internal(this.name);

  log(String msg) {
    if(!mute) {
      print(msg);
    }
  }
}

// getter和setter方法
getterAndSetterMethod() {
  var rect = Rectangle(3,4,20,15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
  print("getterAndSetterMethod");

  final doer = EffectiveDoer();
  doer.doSomething();
}

// Getter和Setter方法
// 使用get和set关键字实现Getter和Setter方法,能够为实例创建额外的属性
class Rectangle {
  var left,top,width,height;
  Rectangle(this.left,this.top,this.width,this.height);
  // 定义两个计算属性:right和bottom
  num get right => left + width;
  set right (num value)=> left =  value - width;

  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}

// 抽象方法:
// 实例方法,getter和setter方法可以是抽象的,只定义接口不进行实现,而是留给其他类去实现.
// 抽象方法只存在于抽象类中.
// 定义一个抽象函数,使用;来代替函数体:
abstract class Doer {
  // 定义实例变量和方法....
  
  // 定义一个抽象方法
  doSomething();

  // 注意:调用抽象方法会导致运行时错误.
}

class EffectiveDoer extends Doer {
  doSomething() {
    // 提供方法实现,所以这里的方法不再是抽象方法了...
    print("EffectiveDoer_doSomething");
  }
}