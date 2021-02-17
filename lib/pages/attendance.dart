import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/attendance_services.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:spring_superior/widgets/attendance_list_item.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  AttendanceServices attendanceServices = AttendanceServices();
  MemberServices memberServices = MemberServices();
  List<int> numId;
  List<Member> memberList;
  String cDate;

  Future<List<Member>> getMembers() async {
      if(cDate != null){
        numId = await attendanceServices.getPresentMemberId(cDate);
        memberList = await memberServices.getMembersById(numId);
      }
      return memberList;
  }


  final f = DateFormat.yMMMMd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance')),
      body: Column(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2100))
                    .then((val) {
                  setState(() {
                    cDate = f.format(val);
                  });
                });
              },
              child: Container(
                height: 60.0,
                width: double.infinity,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Center(
                  child: Text(
                    cDate == null ? 'Pick a date' : cDate,
                    style: TextStyle(
                        color: cDate == null
                            ? Colors.grey
                            : Theme.of(context).primaryColor,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: FutureBuilder(
            future: getMembers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                    child: Text(
                  'An error has occurred',
                  style: TextStyle(color: Colors.red.withOpacity(0.7)),
                ));
              } else if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text("Loading",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 20.0))
                    ],
                  ),
                );
              } else if (snapshot.data.length == 0) {
                return Center(
                    child: Text("No details available for this date",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: 25.0)));
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return AttendanceListItem(
                      member: snapshot.data[index],
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}
