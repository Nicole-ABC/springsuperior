import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/pages/member_form.dart';
import 'package:spring_superior/pages/members.dart';
import 'package:spring_superior/pages/stats.dart';

import 'attendance.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: Scrollbar(
          child: Container(
            color: Colors.grey.withOpacity(0.3),
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4.0, 4.0),
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                          ),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 3.0,
                              spreadRadius: 5.0
                          )
                        ],
                        borderRadius: BorderRadius.circular(40.0)
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        splashColor: Colors.pink.withOpacity(0.3),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Members()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                child: Icon(
                                  Icons.people,
                                  color: Theme.of(context).primaryColor,
                                  size: 30.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                child: Text('Gym Members', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(4.0, 4.0),
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              ),
                              BoxShadow(
                                  offset: Offset(-4.0, -4.0),
                                  color: Colors.white.withOpacity(0.6),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            splashColor: Colors.pink.withOpacity(0.3),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StatsPage()));
                              setState(() {});
                            },
                            child: Container(margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 12.0),
                                    child: Icon(
                                      Icons.show_chart,
                                      color: Theme.of(context).primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 12.0),
                                    child: Text('Stats', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(4.0, 4.0),
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              ),
                              BoxShadow(
                                  offset: Offset(-4.0, -4.0),
                                  color: Colors.white.withOpacity(0.6),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            splashColor: Colors.pink.withOpacity(0.3),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AttendancePage()));
                              setState(() {});
                            },
                            child: Container(margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0,top: 12.0, bottom: 12.0),
                                    child: Icon(
                                      Icons.done,
                                      color: Theme.of(context).primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0,top: 12.0, bottom: 12.0),
                                    child: Text('Attendance', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.0),),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 170.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4.0, 4.0),
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                          ),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 3.0,
                              spreadRadius: 5.0
                          )
                        ],
                        borderRadius: BorderRadius.circular(40.0)
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        splashColor: Colors.pink.withOpacity(0.3),
                        onTap: (){
                          print('tapped');
                        },
                        child: Container(
                          margin: EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                child: Icon(
                                  Icons.room_service,
                                  color: Theme.of(context).primaryColor,
                                  size: 30.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                child: Text('Services', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        headerSliverBuilder: (context, isOk) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:Image.asset(
                  'assets/images/lands.jpg',
                  fit: BoxFit.fill,
                ),
                title: Text("Spring Superior Fitness Club", style: TextStyle(fontSize: 15.0),),
              ),
            )
          ];
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => NewMember())),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
