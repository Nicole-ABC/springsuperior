
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:spring_superior/models/attendance_model.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/pages/update.dart';
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
 AttendanceServices attendanceServices = AttendanceServices();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   MemberServices memberServices = MemberServices();
   DateTime _expiryDate;
  bool _markedPresent = false;
  TextEditingController amountController = TextEditingController();
  DateFormat f = DateFormat.yMMMMd();
  bool isAlmostExpired = false;

  getIsAlmostExpired() async{
    isAlmostExpired = await memberServices.checkAlmostExpired(widget.member);
    setState(() {});
  }

   @override
   void initState() {
     memberServices.checkDate();
     memberServices.checkAlmostExpired(widget.member);
     getIsAlmostExpired();
     markedPresent();
     super.initState();
   }


  String dateString (){
    DateTime dateTime = DateTime.parse(widget.member.date);
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }

  String presentDate (){
     DateTime present = DateTime.now();
     final f = DateFormat.yMMMMd();
     return f.format(present);
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *0.85,
          height: MediaQuery.of(context).size.height *0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all()
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.4),
                      color: widget.member.active == 'true' ? isAlmostExpired ? Colors.red[500] : Theme.of(context).accentColor : Colors.grey.withOpacity(0.7)
                    ),
                    child: Center(
                      child: Text(
                        '${widget.member.surname} ${widget.member.firstName}',
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
                      widget.member.active == 'true' ? 'Subscription is still active. It will expire on ${dateString()}': 'Subscription has expired on ${dateString()}',
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: widget.member.active == 'true' ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: ()async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Update(member: widget.member)));
                        setState(() {
                          getIsAlmostExpired();
                        });
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.37,
                          height: MediaQuery.of(context).size.height *0.07,
                          padding: EdgeInsets.only(right: 6.0, left: 2.0),
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
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () async{
                            DateTime now = DateTime.now();
                            final f = DateFormat.yMMMMd();
                            String today = f.format(now);
                            Attendance attendance = Attendance(
                                date: today,
                                memberId: widget.member.id,
                            );
                            if(_markedPresent){
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('This user has already been marked present.')
                              ));
                            }
                            else{
                              await attendanceServices.createAttendance(attendance);
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('${widget.member.surname} ${widget.member.firstName} has been marked present.')
                              ));
                            }
                            setState(() {
                              markedPresent();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.37,
                            height: MediaQuery.of(context).size.height *0.07,
                            padding: EdgeInsets.only(right: 2.0, left: 6.0),
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
                    ),
                  ],
                ) :
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: ()async{
                      await showDatePicker(
                          context: context,
                          initialDate: _expiryDate == null ? DateTime.parse(widget.member.date) : _expiryDate,
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
                              id: widget.member.id,
                              firstName: widget.member.firstName,
                              surname: widget.member.surname,
                              date: _expiryDate.toString(),
                              active: act.toString()
                          );
                          await memberServices.updateMember(member);
                          widget.member = member;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height *0.05,
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
