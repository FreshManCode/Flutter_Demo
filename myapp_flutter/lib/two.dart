// 1.隐式接口
// 每个类都隐式的定义了一个接口,接口包含了该类所有的实例成员及其实现的接口.如果要创建一个A类,A要支持
// B类的API,但是不需要继承B的实现,那么可以通过A实现B的接口.
// 一个类可以通过implements关键词来实现一个或者多个接口,并实现每个接口要求的API.如下:
import 'one.dart';

main(List<String> args) {
  testExplictFunction();
  // 枚举测试
  testEnumDemo();
// 泛型测试
  testRangeCache();
}

// 隐式类相关功能
testExplictFunction() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));

  SmartTelevision().turnOn();
}

// person类.隐式接口里面包含了 greet()方法声明.
class Person {
  // 包含在接口里,单只在当前库中可见.
  final _name;

// 不包含在接口里,因为这是一个构造函数.
  Person(this._name);

  // 包含在接口里:
  String greet(String who) => 'Hello,$who. I am $_name.';
}

// Person接口实现
class Impostor implements Person {
  get _name => '';

  String greet(String who) {
    return "Hi $who.Do you know who I am?";
  }
}

String greetBob(Person person) => person.greet("Bob");

// 2.扩展类(继承)
// 使用extends 关键字来创建子类,使用super关键字来引用父类:
class Television {
  turnOn() {
    print("Television1");
  }
}

class SmartTelevision extends Television {
  // 重写父类的方法
  @override
  turnOn() {
    super.turnOn();
    print("SmartTelevision");
  }
}

// 3.重写类成员
// 子类重写实例方法,getter和setter.可以使用@override注解想要重写的成员:

// 4.noSuchMethod()
// 当代码尝试使用不存在的方法或实例变量时,通过重写noSuchMethod()方法.来实现检测和应对处理:
class A {
  @override
  noSuchMethod(Invocation invocation) {
    print("You tried to use a non-exist member:" + "${invocation.memberName}");
  }
  // 除非符合下面任意的一项条件,否则没有实现的方法不能被调用:
  // 1.receiver 具有dynamic 的静态类型
  // 2.receiver 具有静态类型,用于定义为实现的方法(可以是抽象的),并且receiver的动态类型具有noSuchMethod()的实现,
  // 该实现与Object的实现不同.
}

// 5.使用枚举
// 使用enum 关键字定义一个枚举类型:
// 枚举中的每个值都有一个index getter方法,该方法返回值所在枚举类型定义中的位置(从0开始.)例如,第一个
// 枚举值的索引是0,第二个枚举值的索引是1
enum Color { red, green, blue }

testEnumDemo() {
  assert(Color.red.index == 0);
  assert(Color.green.index == 1);

// 使用枚举的values常量,获取所有枚举值列表(list)
  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);

  // 可以在switch 语句中使用枚举,如果不处理所有枚举值,会收到警告:
  // 枚举值具有以下限制:
  // 1.枚举不能被子类化,混合或实现.
  // 2.枚举不能被显式实例化.
}

// 6.为类添加功能:Mixin
// Mixin是复用类代码的一种途径,复用的类可以在不同层级,之间可以不存在继承关系.
// 通过with后面跟一个或多个混入的名称,来使用Mixin,下面的事例演示了两个使用Mixin的类

class Performer {}

class Musician extends Performer with Musical {}

mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

mixin Aggressive {
  num get progress => 0.5;
}

// 7.泛型
//  <...>符号将List标记为泛型(或参数化)类型.这种类型具有形式化的参数.通常情况下,使用一个字母来代表类型参数.例如:E,T,S,K和V等
// 如果想让List仅仅支持字符串类型,可以将其声明为List<String>(读作'字符串类型的list').那么,当一个非字符串被赋值给了这个list
// 开发工具就能够检测到这样的做法可能存在错误.例如:

// 泛型
testRangeType() {
  List<String> names = [];
  // names.add(['seth','Lars']);
  // names.add(42);
  names.add("Liming");
  var names1 = List.filled(0, "");
  var names2 = List<String>.from([]);
  names1.add("11");
  names1.add("11");
  names2.add("22");
  print("test:$names,$names1,$names2");
}

// 泛型字典
testRangeCache() {
  final my_Cache = MyCache();
  my_Cache.setValue("name", "李白");
  my_Cache.setValue("age", 28);
  my_Cache.printCaches();
  print(my_Cache.getValue("11"));

  // 指定 限制泛型类型:
  final test1 = Foo<SomeBaseClass>();
  final test2 = Foo <Extender>();
  // Intance of 'Foo<SomeBaseClass>
  print(test1.toString());
  // Intance of 'Foo<Extender>
  print(test2.toString());

  // 不指定限制泛型类型参数:
  final test3 = Foo();
  // Intance of 'Foo<SomeBaseClass>
  print(test3.toString());
  
}

class MyCache<V> {
  // 使用泛型类型的构造函数
  var views = Map<String, V>();

  var names = List<String>.from([]);

  static var _cache = Map();
  setValue(String key, V value) {
    _cache[key] = value;
  }

// 泛型函数
  V getValue(String key) {
    return _cache[key];
  }

  printCaches() {
    print("cache is:,$_cache");
  }
}

// 限制泛型类型
// 使用泛型类型的时候,可以使用extends实现参数类型的限制.
// 可以使用SomeBaseClass 或其任意子类作为通用参数:

class SomeBaseClass {

}

class Extender extends SomeBaseClass {

}

class Foo <T extends SomeBaseClass> {
  String toString()=>"Intance of 'Foo<$T>";
}

// 使用泛型函数
