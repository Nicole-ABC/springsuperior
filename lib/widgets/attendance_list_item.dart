import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:intl/intl.dart';
import 'package:spring_superior/services/attendance_services.dart';
import 'package:spring_superior/services/member_services.dart';

class AttendanceListItem extends StatefulWidget {
  Member member;
  String date;

  AttendanceListItem({this.member, this.date});
  @override
  _AttendanceListItemState createState() => _AttendanceListItemState();
}

class _AttendanceListItemState extends State<AttendanceListItem> {
  AttendanceServices attendanceServices = AttendanceServices();
  MemberServices memberServices = MemberServices();


  getMyFuture() async{
    final f = DateFormat.yMMMMd();
    memberServices.getMembersById(await attendanceServices.getPresentMemberId(f.format(DateTime.now())));
  }

  @override
  void initState() {
    getMyFuture();
    super.initState();
  }

  showDeleteDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Delete ${widget.member.surname} ${widget.member.firstName}\'s attendance?'),
          children: <Widget>[
            SimpleDialogOption(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
              ),
              onPressed: (){
                attendanceServices.deleteDateAttendance(widget.member, widget.date);
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(
                thickness: 3.0,
              ),
            ),
            SimpleDialogOption(
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: Text(
                      'Cancel',
                    style: TextStyle(
                        fontSize: 18.0
                    ),
                  ),
                ),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  void setState(fn) {
    getMyFuture();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.all(10.0),
        height: 80.0,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15.0)
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.offline_pin,
                  color: Colors.purple[800],
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.member.surname} ${widget.member.firstName}',
                  style: TextStyle(
                    fontSize: 17.0
                  ),

                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: (){
                      showDeleteDialog(context);
                      setState(() {
                        getMyFuture();
                      });
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              )
            ],
          ),
      );

  }
}
