import 'package:flutter/material.dart';

class FullScreenDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  bool _hasMedicine = false;
  bool _saveNeeded = false;
  //final TimeOfDay time;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Choose medicine and time'),
          actions: <Widget>[
            FlatButton(
              child: Text('save'),
              //
              onPressed: () {},
            ),
          ],
        ),
        body: Form(
          //onWillPop:允许表单否决用户尝试关闭包含表单的 [ModalRoute] 。
          onWillPop: _onWillPop,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Medicine Name',
                  //hintText:提示文本域接受什么样的输入的文字。
                  hintText: 'What Medicine should you take?',
                ),
                //onChanged:当正在编辑的文字改变时调用
                onChanged: (String value) => setState(
                      () => _hasMedicine = value.isNotEmpty,
                    ),
              ),
              //InkWell:材料设计的矩形区域，可以响应触摸。
              InkWell(
                onTap: () async{
                  var value = await showTimePicker(
                    context: context,
                    //TimeOfDay.now():根据当前的时间创造一天中的某个时间。
                    initialTime: new TimeOfDay.now(),
                  );
                  print(value);
                },
                child: Row(
                  children: <Widget>[
                    //返回这个‘一天内的时间’的本地化字符串表示
                    Text('${TimeOfDay.now().format(context)}'),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  /*Future _selectTime(BuildContext context) async {
    //showTimePicker:显示包含材料设计的时间选择器的对话框。
    final TimeOfDay _picked = await showTimePicker(
      context: context,
      //TimeOfDay.now():根据当前的时间创造一天中的某个时间。
      initialTime: new TimeOfDay.now(),
    );
    //var hour=_picked.hour;
    print(_picked);

  }*/


  Future<bool> _onWillPop() async {
    _saveNeeded = _hasMedicine;
    if (!_saveNeeded) return true;
    //showDialog:显示一个悬浮在当前app的内容上方的材料设计的对话框，
    // 带有材料设计的进入和退出动画，模态障碍颜色和模态障碍行为
    // （对话框可以由点击障碍物关闭）。
    return await showDialog(
      context: context,
      //材料设计的警告对话框。
      builder: (BuildContext context) => AlertDialog(
            content: Text('Discard new medicine notification ?'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Cancle'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              FlatButton(
                child: const Text('DISCARD'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
    );
  }
}
