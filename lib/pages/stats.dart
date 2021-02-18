import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/attendance_services.dart';
import 'package:spring_superior/services/member_services.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  AttendanceServices attendanceServices = AttendanceServices();
  MemberServices memberServices = MemberServices();
  List<Member> memberList = List<Member>();
  List<double> presentList = List<double>();
  double present = 0.0;
  int memberCount = 0;
  List<String> attendance = List<String>();
  List<int> ids = List<int>();

  getNumPresent() async {
    attendance = await attendanceServices.getAllDates();
    for (int i = 0; i < attendance.length; i++) {
      ids = await attendanceServices.getPresentMemberId(attendance[i]);
      presentList.add(ids.length.toDouble());
    }
    return presentList;
  }

  getMembers() async{
    memberList = await memberServices.getAllMembers();
    memberCount = memberList.length;
    return memberCount;
  }

  Future<double> getNumPresentAverage() async {
    attendance = await attendanceServices.getAllDates();
    int attendanceCount = attendance.length;
    for (int i = 0; i < attendance.length; i++) {
      ids = await attendanceServices.getPresentMemberId(attendance[i]);
      present += ids.length;
    }
    present = present/attendance.length;
    print(attendanceCount);
    print(present);
    return present;
  }

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.only(left: 15.0, right: 20.0, top: 30.0),
              height: 320.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(4.0, 4.0),
                        color: Theme
                            .of(context)
                            .primaryColor
                            .withOpacity(0.3),
                        blurRadius: 2.0,
                        spreadRadius: 5.0),
                    BoxShadow(
                        offset: Offset(-4.0, -4.0),
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 2.0,
                        spreadRadius: 5.0)
                  ],
                  color: Colors.white.withOpacity(0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Attendance Progression',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0, left: 12.0, right: 12.0),
                      child: FutureBuilder(
                          future: getNumPresent(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return Center(
                                  child: Text(
                                    'An error has occurred',
                                    style: TextStyle(
                                        color: Colors.red.withOpacity(0.7)),
                                  ));
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 100.0,
                                      width: 100.0,
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                        Theme
                                            .of(context)
                                            .accentColor,
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
                            }
                            return Sparkline(
                              lineGradient: new LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.purple[800],
                                  Colors.purple[200]
                                ],
                              ),
                              data: snapshot.data,
                              pointsMode: PointsMode.last,
                              pointColor: Colors.purple[900],
                              lineWidth: 5.0,
                              pointSize: 12.0,
                            );
                          }),
                    ),
                  ),
                  Center(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.grey.withOpacity(0.7),
                          child: Container(
                            width: 400.0,
                            height: 50.0,
                            child: Center(
                              child: Text(
                                'Details',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 15.0, right: 10.0, bottom: 30.0),
                width:  400.0,
                height: 320.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4.0, 4.0),
                          color: Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.3),
                          blurRadius: 2.0,
                          spreadRadius: 5.0),
                      BoxShadow(
                          offset: Offset(-4.0, -4.0),
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 2.0,
                          spreadRadius: 5.0)
                    ],
                    color: Colors.white.withOpacity(0.4)
                ),
                child: FutureBuilder(
                  future: getNumPresentAverage(),
                  builder:(context, snapshot){
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                          child: Text(
                            'An error has occurred',
                            style: TextStyle(
                                color: Colors.red.withOpacity(0.7)),
                          ));
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 100.0,
                              width: 100.0,
                              child: CircularProgressIndicator(
                                backgroundColor:
                                Theme
                                    .of(context)
                                    .accentColor,
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
                    }
                    return new AnimatedCircularChart(
                      size: MediaQuery.of(context).size * 0.45,
                      initialChartData: <CircularStackEntry>[
                        new CircularStackEntry(
                          <CircularSegmentEntry>[
                            new CircularSegmentEntry(
                              snapshot.data,
                              Colors.purple[800],
                              rankKey: 'completed',
                            ),
                            new CircularSegmentEntry(
                              memberCount.toDouble(),
                              Colors.purple[300],
                              rankKey: 'remaining',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                    );
                  },
                ),
              )
          )
        ],
      ),
    );
  }
}
