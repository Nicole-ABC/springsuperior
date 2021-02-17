import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/models/member_model.dart';

class AttendanceListItem extends StatefulWidget {
  Member member;

  AttendanceListItem({this.member});
  @override
  _AttendanceListItemState createState() => _AttendanceListItemState();
}

class _AttendanceListItemState extends State<AttendanceListItem> {

  check(){
    print('got here');
    setState(() {});
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 50.0,
        color: Colors.blue,
        child: Text(widget.member.firstName),
      );

  }
}
