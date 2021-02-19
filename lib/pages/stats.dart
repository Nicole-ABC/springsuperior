import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'dart:math';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/pages/stats_details.dart';
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
  bool created = false;
  List<int> ids = List<int>();

  Future<List<double>> getNumPresent() async {
    if(!created) {
      attendance = await attendanceServices.getAllDates();
      for (int i = 0; i < attendance.length; i++) {
        ids = await attendanceServices.getPresentMemberId(attendance[i]);
        presentList = [0.0];
        presentList.add(ids.length.toDouble());
      }
      presentList.forEach((element) {
        print(element);
      });
    }else{
      presentList = [];
    }
    created = true;
    return presentList;
  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  getMembers() async{
    memberList = await memberServices.getAllMembers();
    memberCount = memberList.length;
    return memberCount;
  }

  Future<double> getNumPresentAverage() async {
    attendance = await attendanceServices.getAllDates();
    if(!created){
      int attendanceCount = attendance.length;
      for (int i = 0; i < attendance.length; i++) {
        ids = await attendanceServices.getPresentMemberId(attendance[i]);
        present += ids.length;
      }
      present = present/attendanceCount;
    }
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
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01, vertical: MediaQuery.of(context).size.height * 0.02),
              margin: EdgeInsets.only(left: 8.0, right: 10.0, top: 30.0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  color: Colors.white.withOpacity(0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Attendance Progression',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 25.0, left: 12.0, right: 12.0),
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
                          }else if (snapshot.data.length == 0) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.height *0.20,
                                child:
                                Column(
                                  children: [
                                    Center(child: Text('This data does not reflect actual attendance information', style: TextStyle(color: Colors.grey),),),
                                    Sparkline(
                                      lineGradient: new LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.blueGrey[800],
                                          Colors.grey[400]
                                        ],
                                      ),
                                      data: [2.0, 4.0, 3.0, 5.0],
                                      pointsMode: PointsMode.none,
                                      pointColor: Colors.purple[900],
                                      lineWidth: 5.0,
                                      pointSize: 12.0,
                                    ),
                                  ],
                                )
                            );
                          }
                          else {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                height: MediaQuery.of(context).size.height *0.20,
                                child:Sparkline(
                              lineGradient: new LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.purple[900],
                                  Colors.purple[200]
                                ],
                              ),
                              data: snapshot.data,
                              pointsMode: PointsMode.last,
                              pointColor: Colors.purple[900],
                              lineWidth: 5.0,
                              pointSize: 12.0,
                            )
                            );
                          }
                        }),
                  ),
                  Center(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StatsDetails(memberCount: memberCount)));
                          },
                          splashColor: Colors.grey.withOpacity(0.7),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 30.0,
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
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01, vertical: MediaQuery.of(context).size.height * 0.02),
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)
                    ),
                    color: Colors.white.withOpacity(0.4)
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Average attendance vs. membership',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        color: Colors.purple[900]
                                      ),
                                    ),
                                    Text('Average attendance')
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 12.0,
                                      height: 12.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          color: Colors.purple[200]
                                      ),
                                    ),
                                    Text('Total number of members')
                                  ],
                                )
                              ],
                            )
                          ),
                          Expanded(
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
                                else if (snapshot.data == 0) {
                                  return new AnimatedCircularChart(
                                    size: MediaQuery.of(context).size * 0.5,
                                    holeRadius: 50.0,
                                    initialChartData: <CircularStackEntry>[
                                      new CircularStackEntry(
                                        <CircularSegmentEntry>[
                                          new CircularSegmentEntry(
                                            0.0,
                                            Colors.purple[900],
                                          ),
                                          new CircularSegmentEntry(
                                           0.0,
                                            Colors.purple[200],
                                          ),
                                        ],
                                      ),
                                    ],
                                    holeLabel: '0',
                                    labelStyle: TextStyle(
                                      color: Colors.purple[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  );
                                }

                                double average = snapshot.data;
                                double percentage = roundDouble((average/memberCount)*100, 2);
                                return new AnimatedCircularChart(
                                  size: MediaQuery.of(context).size * 0.5,
                                  initialChartData: <CircularStackEntry>[
                                    new CircularStackEntry(
                                      <CircularSegmentEntry>[
                                        new CircularSegmentEntry(
                                          average,
                                          Colors.purple[900],
                                          rankKey: 'completed',
                                        ),
                                        new CircularSegmentEntry(
                                          memberCount.toDouble(),
                                          Colors.purple[200],
                                          rankKey: 'remaining',
                                        ),
                                      ],
                                      rankKey: 'progress',
                                    ),
                                  ],
                                  holeLabel: '$percentage%',
                                  labelStyle: TextStyle(
                                    color: Colors.purple[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
