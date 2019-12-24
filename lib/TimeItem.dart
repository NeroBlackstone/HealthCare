import 'package:flutter/material.dart';
class TimeItem extends StatelessWidget{
  TimeItem({Key key,this.timeOfDay,@required this.onChanged})
      :assert(onChanged!=null),super(key:key);
  final TimeOfDay timeOfDay;
  //ValueChanged:报告基础值已更改的回调签名
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(

    );
  }

}