import 'package:flutter/material.dart';
import 'BIMPage.dart';
import 'MedicineNotificationPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final _widgetOptions = [
    MedicineNotificationPage(),
    BIMPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Bear Healthcare System'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      //bottomNavigationBar:一个显示在脚手架底部的导航栏
      //显示在app底部的材料设计小部件，用于选择少量视图，数量通常在三个到五个之间。
      bottomNavigationBar: BottomNavigationBar(
        //items:交互式项目位于底部导航栏中，每个项目都有一个图标和标题。
        //BottomNavigationBarItem:材料设计的[BottomNavigationBar]或ios[CupertinoTabBar]中的一个交互式按钮。
        // 带有图标或标题栏。
        items: <BottomNavigationBarItem>[
          //icon:项目的图标
          //title:项目的标题。如果不提供标题只提供图标，
          // 则只有图标在材料设计的[BottomNavigationBar]中显示。
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.face), title: Text('BMI Calculator')),
        ],
        //currentIndex:当前激活项的[items]引索
        currentIndex: _selectedIndex,
        //fixedColor:当底部导航栏是[BottomNavigationBarType.fixed]时，选择下方项目的颜色
        fixedColor: Colors.blue,
        //onTap:点击下方图标时调用的回调函数
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
