import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/attendance_services.dart';

class StatsDetails extends StatefulWidget {
  int memberCount;

  StatsDetails({this.memberCount});
  @override
  _StatsDetailsState createState() => _StatsDetailsState();
}

class _StatsDetailsState extends State<StatsDetails> {
  AttendanceServices attendanceServices = AttendanceServices();
  List<String> attendance = List<String>();
  List<Details> dList = [];
  bool created = false;
  List<int> ids = List<int>();
  int memLength;

  Future<List<Details>> getNumPresent() async {
    attendance = await attendanceServices.getAllDates();
    if(!created){
      for (int i = 0; i < attendance.length; i++) {
        ids = await attendanceServices.getPresentMemberId(attendance[i]);
        dList.add(Details(
            date: attendance[i],
            count: ids.length
        ));
      }
    }
    created = true;
    return dList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *0.025, horizontal: MediaQuery.of(context).size.width * 0.03),
        child: FutureBuilder(
          future: getNumPresent(),
          builder: (context, snapshot){
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                  child: Text(
                    'An error has occurred',
                    style:
                    TextStyle(color: Colors.red.withOpacity(0.7)),
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
                        Theme.of(context).accentColor,
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
                  child: Text("No attendance details available yet",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontSize: 25.0)));
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.all(6.0),
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${snapshot.data[index].date}: ${snapshot.data[index].count} members were present out of ${widget.memberCount}',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        ),
                      ),
                    ),
                  )
                );
              }
            );
          },
        ),
      ),
    );
  }
}

class Details{
  String date;
  int count;

  Details({this.date, this.count});
}