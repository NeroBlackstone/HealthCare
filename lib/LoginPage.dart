import 'package:flutter/material.dart';
import 'InputValidator.dart';
import 'User.dart';
import 'dbhelper.dart';

//理解Stateful widget的生命周期:
//当flutter构架一个StatefulWidget,它创建一个State对象。
// 这个对象是小部件所持有的所有可更改状态。

//state的概念由以下两点定义：
//1.小部件中可能会改变的数据。
//2.当小部件构建时，无法同步读取的数据。（所有的状态必须由在build方法被调用时建立）

//StatefulWidget和State分离成两个类的原因：为了性能考虑。
// 这让Flutter重新构建可变小部件的开销变得非常小。
//因为State不会随着重建消失，你可以维护它，并且在每次重建时，
// 不需要昂贵的开销来取得状态的属性。

//这也是允许Flutter动画存在的原因。因为State不会被丢弃，
// 它可以持续地重建它的小部件以相应数据的变化。
class LoginPage extends StatefulWidget {
  //生命周期1.createState()
  //当指示框架构建一个StatefulWidget时，它立即调用createState（）。这个函数是必须存在的。
  @override
  State<StatefulWidget> createState() => _LoginPageState();
  //生命周期2.mounted属性变为true
  //当createState创建你的状态类时，一个buildContext被传入状态。
  // BuildContext简单来说指代了部件树中该部件所处的位置。
  // 所有的小部件都有一个bool this.mounted属性。当buildContext被分配时，转变为真。
  // 当小部件处于unmounted状态时调用setState则会导致错误。
  //当一个方法调用setState但是它不清楚这个函数应该什么时候或多频繁，这个属性非常有用。
  // 也许它被调用以用于流的更新。
  // 你可以在调用setState前使用if(mounted) {...来保证状态存在。
}
//生命周期3.initState()
//当widget被创建时，它是被调用的第一个函数。（当然在构造函数后)。
//initState只被调用一次。它必须调用super.initState()。
//该函数作用：
//1.为创建小部件的实例，初始化依赖于特定BuildContext的数据
//2.初始化依赖于这个小部件在部件树中的“父母”的属性。
//3.订阅stream，ChangeNotifier，或是其他可以改变这个小部件的数据的对象。

//生命周期4.didChangeDependencies()
//在第一次构建小部件时，这个函数在initState（）后被立即调用。
//每当小部件所依赖的数据的对象被调用时，该函数也会被调用。
// 例如，如果一个小部件依赖的InheritedWidget发生更新。
//build（）总是在didChangeDependencies（）之后调用，因此这个函数很少使用。
// 然而，这个函数在调用BuildContext.inheritFromWidgetOfExactType后发生更改。
// 这实际上将会使状态‘监听’小部件的所继承的数据的改变。
//文档还建议如果你需要网络调用（或是其他耗时操作），当一个InheritedWidget发生更新时，
// 这个函数会十分有用。
class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final dbHelper = DBHelper();
  //生命周期5：build（）
  //这个函数被频繁调用。它是必须的，并且它必须返回一个小部件。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        //SafeArea的一个重要功能就是它可以进行媒体查询，检查屏幕形状，
        // 将内容放在确实可以显示出来的矩形区域内，
        // 这样就可以避免文字在一些全面屏的刘海和屏幕底部的圆角处显示。
        // 苹果在ios11的规范中，推荐将所有控件都放在SafeArea中。
        builder: (BuildContext context) => SafeArea(
                child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  //SizeBox的特点是：如果有子部件，这个部件强制子部件拉伸到指定的宽度或高度
                  // （假设值被父部件所允许）。如果宽度或高度是空，
                  // 这个部件将把自己调整到子部件的大小。如果没有给一个子部件，
                  // 这个部件将把自己调整到指定的宽高，当值为空时视作0。
                  SizedBox(height: 80.0),
                  Text(
                    'Bear Healthcare System',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 120.0,
                  ),
                  TextFormField(
                    validator: InputValidator.inputUsernameValidate,
                    controller: usernameTextEditingController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    validator: InputValidator.inputPasswordValidate,
                    controller: passwordTextEditingController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('Sign Up'),
                        onPressed: () async {
                          var username =
                              await Navigator.of(context).pushNamed('/signUp');
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Congratulations!User $username sign up successful!')));
                        },
                      ),
                      RaisedButton(
                        child: Text('Log in'),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var user = User(usernameTextEditingController.text,
                                passwordTextEditingController.text);
                            if (await dbHelper.isUserExist(user))
                              Navigator.pushReplacementNamed(
                                  context, '/homePage');
                            else
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text('No this user or wrong password')));
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
//生命周期6：didUpdateWidget（）
//如果父部件改变并且不得不重构这个小部件（因为需要被给予不同的数据），
// 但是它使用相同的runtimeType重建，这个函数会被调用。
//这是因为Flutter正在重新使用状态，这是长期保存的。在这种情况下，
// 你也许会想要再次初始化一些数据，正如在initState中使用的那样。
//如果你的状态的buildu函数依赖于Stream或是其余可能改变的对象，
// 从老对象取消订阅并且重新订阅会创建didUpdateWidget的一个新示例。
//如果你想要你的小部件与重建的状态相关联，那么这个函数基本是initState的替代
//框架总是在调用didUpdateWidget调用build，所以任何setState的函数都是多余的。

//生命周期7.setState（）
//这个函数被经常被框架和开发者调用。它用来通知框架数据已经改变，并且在build context中的小部件应该被重建。
//setState接受一个不能异步的回调。除此之外，它可以被开发者经常使用，因为重建开销很小。

//生命周期8.deactivate（）
//当state从树中移除时，Deactivate被调用，但是在当前的帧改变之前，它可能被重新插入。
// 这个方法存在族要是因为State对象可以从部件树中的一点移到另一点。
//它很少被使用。
//
//生命周期9.dispose（）
//当state兑现被移除时，dispose被调用，移除是永久性的。
//这个函数可用于取消订阅并取消所有的动画，流，等等。
//
//生命周期10.mounted变为false
//state对象可以永不能被重新mount，并且之后setState被调用会抛出一个异常。
