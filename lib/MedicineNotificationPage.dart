import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'FullScreenDialog.dart';

class MedicineNotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MedicineNotificationPageState();
}

class MedicineNotificationPageState extends State<MedicineNotificationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final dbHelper = DBHelper();
  List notificationList;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text('Notification'),
            content: new Text('$payload'),
          ),
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => FullScreenDialog(),
                    //fullscreenDialog:这个页面路由是否是一个全屏对话框。
                    fullscreenDialog: true,
                  ));
            },
            tooltip: 'Daily Medicine Notification',
            child: Icon(Icons.add),
          ),
          //body: ,
        ) /*RaisedButton(
          child: Text('some text'),
          onPressed: () async {
            await _showNotification();
          },
        )*/
            ,
      );

  Future _showNotification() async {
    var time = new Time(0, 29, 0);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name',
        'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ',
        time,
        platformChannelSpecifics);
  }
}
