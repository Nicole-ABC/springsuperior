import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:spring_superior/widgets/member_list_item.dart';

class Members extends StatefulWidget {
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  MemberServices memberServices = MemberServices();
  bool _collapsedSearch = true;
  bool _collapsedActive = true;
  bool _collapsedInactive = true;
  bool _isSearching = false;
  bool _isCheckingActivity = false;
  String keyword;
  String activityKeyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: _collapsedSearch ? 50.0 : 250.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white.withOpacity(0.9),
                      boxShadow: kElevationToShadow[3],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: _collapsedSearch
                                ? null
                                : TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color:
                                    Colors.grey.withOpacity(0.6)),
                                border: InputBorder.none,
                              ),
                              onChanged: (val){
                                keyword = val;
                                setState(() {
                                  _isSearching = true;
                                });
                              },
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      _collapsedSearch ? 20.0 : 0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(
                                      _collapsedSearch ? 20.0 : 0),
                                  bottomRight: Radius.circular(20.0)),
                              onTap: () {
                                setState(() {
                                  _collapsedSearch = !_collapsedSearch;
                                  _collapsedActive = true;
                                  _collapsedInactive = true;
                                });
                                if(_collapsedSearch == true){
                                  _isSearching = false;
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  _collapsedSearch ? Icons.search : Icons.close,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: _collapsedActive ? 50.0 : 150.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _collapsedActive
                          ? Colors.white.withOpacity(0.9)
                          : Theme.of(context).accentColor.withOpacity(0.8),
                      boxShadow: kElevationToShadow[3],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 16.0),
                              child: _collapsedActive
                                  ? null
                                  : Center(
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.5),
                                  ))),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      _collapsedActive ? 20.0 : 0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(
                                      _collapsedActive ? 20.0 : 0),
                                  bottomRight: Radius.circular(20.0)),
                              onTap: () {
                                setState(() {
                                  _collapsedActive = !_collapsedActive;
                                  _collapsedSearch = true;
                                  _collapsedInactive = true;
                                  _isCheckingActivity = !_isCheckingActivity;
                                  activityKeyword = 'true';
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  _collapsedActive ? Icons.person : Icons.close,
                                  color: _collapsedActive
                                      ? Theme.of(context).accentColor
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: _collapsedInactive ? 50.0 : 150.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _collapsedInactive
                          ? Colors.white.withOpacity(0.9)
                          : Colors.white.withOpacity(0.5),
                      boxShadow: kElevationToShadow[3],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 16.0),
                              child: _collapsedInactive
                                  ? null
                                  : Center(
                                  child: Text(
                                    "Inactive",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.5),
                                  ))),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      _collapsedInactive ? 20.0 : 0),
                                  topRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(
                                      _collapsedInactive ? 20.0 : 0),
                                  bottomRight: Radius.circular(20.0)),
                              onTap: () {
                                setState(() {
                                  _collapsedInactive = !_collapsedInactive;
                                  _collapsedSearch = true;
                                  _collapsedActive = true;
                                  _isCheckingActivity = !_isCheckingActivity;
                                  activityKeyword = 'false';
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  _collapsedInactive ? Icons.person : Icons.close,
                                  color: _collapsedInactive
                                      ? Colors.grey.withOpacity(0.6)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _isCheckingActivity ? ActivityBody(keyword: activityKeyword): _isSearching ? FutureBuilder(
              future: memberServices.searchMembers(keyword),
              builder: (context, snapshot){
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        'An error has occured',
                        style: TextStyle(color: Colors.red.withOpacity(0.7)),
                      ));
                }
                else if (!snapshot.hasData) {
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
                        Text("Loading",
                            style: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                                fontSize: 20.0))
                      ],
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: Text("No members available.",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 25.0)));
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key("${snapshot.data[index].id}"),
                      child: MemberListItem(
                        id: snapshot.data[index].id,
                        firstName: snapshot.data[index].firstName,
                        surname: snapshot.data[index].surname,
                        date: snapshot.data[index].date,
                        active: snapshot.data[index].active,
                      ),
                      onDismissed: (direction) {
                        memberServices.deleteMember(snapshot.data[index]);
                      },
                    ));
              }
            ) : FutureBuilder(
              future: memberServices.getAllMembers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'An error has occured',
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
                        Text("Loading",
                            style: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                                fontSize: 20.0))
                      ],
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: Text("No members available.",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 25.0)));
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Dismissible(
                          key: Key("${snapshot.data[index].id}"),
                          child: MemberListItem(
                            id: snapshot.data[index].id,
                            firstName: snapshot.data[index].firstName,
                            surname: snapshot.data[index].surname,
                            date: snapshot.data[index].date,
                            active: snapshot.data[index].active,
                          ),
                          onDismissed: (direction) {
                            memberServices.deleteMember(snapshot.data[index]);
                          },
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityBody extends StatefulWidget {
  final String keyword;

  ActivityBody({this.keyword});
  @override
  _ActivityBodyState createState() => _ActivityBodyState(
    keyword: keyword
  );
}

class _ActivityBodyState extends State<ActivityBody> {
  final String keyword;

  _ActivityBodyState({this.keyword});

  MemberServices memberServices = MemberServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: memberServices.getMemberActivity(keyword),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
                'An error has occured',
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
                Text("Loading",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 20.0))
              ],
            ),
          );
        } else if (snapshot.data.length == 0) {
          return Center(
              child: Text("No members available.",
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 25.0)));
        }
        return ListView.builder(
            itemCount: snapshot.data.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Dismissible(
              key: Key("${snapshot.data[index].id}"),
              child: MemberListItem(
                id: snapshot.data[index].id,
                firstName: snapshot.data[index].firstName,
                surname: snapshot.data[index].surname,
                date: snapshot.data[index].date,
                active: snapshot.data[index].active,
              ),
              onDismissed: (direction) {
                memberServices.deleteMember(snapshot.data[index]);
              },
            ));
      },
    );
  }
}
