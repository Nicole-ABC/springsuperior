import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/pages/member_form.dart';
import 'package:spring_superior/pages/members.dart';
import 'package:spring_superior/pages/services.dart';
import 'package:spring_superior/pages/stats.dart';
import 'package:spring_superior/services/member_services.dart';
import 'attendance.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MemberServices memberServices = MemberServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: Scrollbar(
          child: Container(
            color: Colors.grey.withOpacity(0.3),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    height: 170.0,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(4.0, 4.0),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 2.0,
                          spreadRadius: 5.0),
                      BoxShadow(
                          offset: Offset(-4.0, -4.0),
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 3.0,
                          spreadRadius: 5.0)
                    ], borderRadius: BorderRadius.circular(40.0)),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        splashColor: Colors.pink.withOpacity(0.3),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Members()));
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Icon(
                                  Icons.people,
                                  color: Theme.of(context).primaryColor,
                                  size: 30.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Text(
                                  'Gym Members',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: MediaQuery.of(context).size.width * 0.04),
                                ),
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
                    crossAxisSpacing: 3.0,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.035,
                          top: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.05),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(4.0, 4.0),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              blurRadius: 2.0,
                              spreadRadius: 5.0),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 2.0,
                              spreadRadius: 5.0)
                        ], borderRadius: BorderRadius.circular(40.0)),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            splashColor: Colors.pink.withOpacity(0.3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StatsPage()));
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.02,
                                  top:
                                      MediaQuery.of(context).size.height * 0.05,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.05,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0, right: 6.0),
                                    child: Icon(
                                      Icons.show_chart,
                                      color: Theme.of(context).primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: Text(
                                      'Stats',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.035),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              offset: Offset(4.0, 4.0),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              blurRadius: 2.0,
                              spreadRadius: 5.0),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white.withOpacity(0.6),
                              blurRadius: 2.0,
                              spreadRadius: 5.0)
                        ], borderRadius: BorderRadius.circular(40.0)),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            splashColor: Colors.pink.withOpacity(0.3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttendancePage()));
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.02,
                                  top:
                                      MediaQuery.of(context).size.height * 0.05,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.05,
                                  left:
                                      MediaQuery.of(context).size.width * 0.02),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0),
                                    child: Icon(
                                      Icons.done,
                                      color: Theme.of(context).primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: Text(
                                      'Attendance',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: MediaQuery.of(context).size.width * 0.04),
                                    ),
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
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(4.0, 4.0),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          blurRadius: 2.0,
                          spreadRadius: 5.0),
                      BoxShadow(
                          offset: Offset(-4.0, -4.0),
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 3.0,
                          spreadRadius: 5.0)
                    ], borderRadius: BorderRadius.circular(40.0)),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        splashColor: Colors.pink.withOpacity(0.3),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Services()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Icon(
                                  Icons.room_service,
                                  color: Theme.of(context).primaryColor,
                                  size: 30.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Text(
                                  'Services',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: MediaQuery.of(context).size.width * 0.04),
                                ),
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
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/wallpaper.jpg'),
                              fit: BoxFit.fill)),
                    ),
                  ],
                ),
                title: Text(
                  "Spring Superior Fitness Club",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
                centerTitle: true,
              ),
            )
          ];
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewMember())),
        child:  Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


}
