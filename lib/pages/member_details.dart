
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:spring_superior/models/attendance_model.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/attendance_services.dart';
import 'package:spring_superior/services/member_services.dart';

class MemberDetails extends StatefulWidget {
  Member member;

  MemberDetails({
    this.member
  });


  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  int id;
  String firstName;
  String surname;
  String date;
  bool active;

  AttendanceServices attendanceServices = AttendanceServices();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   MemberServices memberServices = MemberServices();
   DateTime _expiryDate;
  bool _markedPresent = false;



   @override
   void initState() {
     id = widget.member.id;
     firstName = widget.member.firstName;
     surname = widget.member.surname;
     date = widget.member.date;
     if(widget.member.active == 'true'){
       active = true;
     }else{
       active = false;
     }
     memberServices.checkDate();
     markedPresent();
     super.initState();
   }


  String dateString (){
    DateTime dateTime = DateTime.parse(date);
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }

  String presentDate (){
     DateTime now = DateTime.now();
     final f = DateFormat.yMMMMd();
     return f.format(now);
  }

  markedPresent() async{
     List<Attendance> att = await attendanceServices.getAllAttendancesByDate(presentDate());
     for(int i = 0; i < att.length; i++){
       if(widget.member.id == att[i].memberId) {
         _markedPresent = true;
       }
     }
     setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *0.85,
          height: MediaQuery.of(context).size.height *0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: active? Theme.of(context).accentColor : Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: active ? Theme.of(context).accentColor : Colors.grey.withOpacity(0.7)
                    ),
                    child: Center(
                      child: Text(
                        '$surname $firstName',
                        style: TextStyle(
                            fontSize: 30.0,
                          color: Colors.white
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: Text(
                      active ? 'Subscription is still active. It will expire on ${dateString()}': 'Subscription has expired on ${dateString()}',
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: active ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: ()async{
                        await showDatePicker(
                          context: context,
                          initialDate: _expiryDate == null ? DateTime.parse(date) : _expiryDate,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2100),
                        ).then((expDate) async{
                          setState(() {
                            if(expDate != null){
                              _expiryDate = expDate;
                            }
                          });
                          bool act = true;
                          if(DateTime.now().isAfter(_expiryDate)){
                            act = false;
                          }
                          final member = Member(
                              id: id,
                              firstName: firstName,
                              surname: surname,
                              date: _expiryDate.toString(),
                              active: act.toString()
                          );
                          await memberServices.updateMember(member);
                          widget.member = member;
                        });
                      },
                      child: Center(
                        child: Container(
                          width: 150.0,
                          height: 60.0,
                          padding: EdgeInsets.only(right: 4.0, left: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      child: InkWell(
                        onTap: () async{
                          DateTime now = DateTime.now();
                          final f = DateFormat.yMMMMd();
                          String today = f.format(now);
                          Attendance attendance = Attendance(
                              date: today,
                              memberId: id,
                          );
                          _markedPresent ? scaffoldKey.currentState.showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 1000),
                            content: Text('This user has already been marked present.')
                          ))
                              : await attendanceServices.createAttendance(attendance);
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 150.0,
                          height: 60.0,
                          padding: EdgeInsets.only(right: 10.0, left: 4.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                            child: Text(
                              'Present',
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
                InkWell(
                  onTap: ()async{
                    await showDatePicker(
                        context: context,
                        initialDate: _expiryDate == null ? DateTime.parse(date) : _expiryDate,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2100),
                    ).then((expDate) async{
                        setState(() {
                          if(expDate != null){
                            _expiryDate = expDate;
                          }
                        });
                        bool act = true;
                        if(DateTime.now().isAfter(_expiryDate)){
                          act = false;
                        }
                        final member = Member(
                            id: id,
                            firstName: firstName,
                            surname: surname,
                            date: _expiryDate.toString(),
                            active: act.toString()
                        );
                        await memberServices.updateMember(member);
                        widget.member = member;
                    });
                  },
                  child: Container(
                    width: 350.0,
                    height: 60.0,
                    margin: EdgeInsets.only(right: 16.0, left: 16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.7)),
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Renew Subscription',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius:  BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)
                  ),
                  splashColor: Colors.white,
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)
                      ),
                      color: Theme.of(context).primaryColor.withOpacity(0.9)
                    ),
                    child: Center(
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
