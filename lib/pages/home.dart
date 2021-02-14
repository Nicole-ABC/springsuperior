import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/pages/member_form.dart';
import 'package:spring_superior/pages/members.dart';

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
                              color: Theme.of(context).primaryColor.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                          ),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                          )
                        ],
                        borderRadius: BorderRadius.circular(40.0)
                    ),
                    child: InkWell(
                      splashColor: Colors.pink.withOpacity(0.3),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Members()));
                      },
                      child: Container(child: Center(child: Text("All Users"))),
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
                              color: Theme.of(context).primaryColor.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                            ),
                            BoxShadow(
                                offset: Offset(-4.0, -4.0),
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 2.0,
                                spreadRadius: 5.0
                            )
                          ],
                          borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: InkWell(
                          splashColor: Colors.pink.withOpacity(0.3),
                          onTap: (){
                            print("tapped");
                          },
                          child: Container(child: Center(child: Text("Active Users"))),
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
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              ),
                              BoxShadow(
                                  offset: Offset(-4.0, -4.0),
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: InkWell(
                          splashColor: Colors.pink.withOpacity(0.3),
                          onTap: (){
                            print("tapped");
                          },
                          child: Container(child: Center(child: Text("Inactive Users"))),
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
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              ),
                              BoxShadow(
                                  offset: Offset(-4.0, -4.0),
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: InkWell(
                          splashColor: Colors.pink.withOpacity(0.3),
                          onTap: (){
                            print("tapped");
                          },
                          child: Container(child: Center(child: Text("Stats"))),
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
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              ),
                              BoxShadow(
                                  offset: Offset(-4.0, -4.0),
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 2.0,
                                  spreadRadius: 5.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(40.0)
                        ),
                        child: InkWell(
                          splashColor: Colors.pink.withOpacity(0.3),
                          onTap: (){
                            print("tapped");
                          },
                          child: Container(child: Center(child: Text("Attendance records"))),
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
                              color: Theme.of(context).primaryColor.withOpacity(0.2),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                          ),
                          BoxShadow(
                              offset: Offset(-4.0, -4.0),
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 2.0,
                              spreadRadius: 5.0
                          )
                        ],
                        borderRadius: BorderRadius.circular(40.0)
                    ),
                    child: InkWell(
                      splashColor: Colors.pink.withOpacity(0.3),
                      onTap: (){
                        print("tapped");
                      },
                      child: Container(child: Center(child: Text("Services provided"))),
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
                //TODO implement carousel slider as background
                background: Center( child: Container(width: 100, height: 100, color: Theme.of(context).accentColor,),),
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
