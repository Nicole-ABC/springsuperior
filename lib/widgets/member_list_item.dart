import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/pages/member_details.dart';
import 'package:spring_superior/services/member_services.dart';

class MemberListItem extends StatefulWidget {
  final int id;
  final String firstName;
  final String surname;
  final String date;
  final String active;

  MemberListItem({
    this.id,
    this.firstName,
    this.surname,
    this.date,
    this.active
  });
  @override
  _MemberListItemState createState() => _MemberListItemState(
    firstName: firstName,
    surname: surname,
    date: date,
    active: active == "true" ? true : false
  );
}

class _MemberListItemState extends State<MemberListItem> {
  int id;
  String firstName;
  String surname;
  String date;
  bool active;

  MemberServices memberServices = MemberServices();


  _MemberListItemState({
    this.id,
    this.firstName,
    this.surname,
    this.date,
    this.active
  });

  @override
  void initState() {
    memberServices.checkDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MemberDetails(
          firstName: firstName,
          surname: surname,
          active: active,
          date: date,
          id: id,
        ))),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: active ? Theme.of(context).accentColor : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(15.0)
          ),
          margin: EdgeInsets.all(8.0),
          height: 100.0,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 12.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                    color: active ? Theme.of(context).accentColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15.0)
                  )

                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("$surname $firstName", style: TextStyle(fontSize: 18.0),),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Icon(
                    Icons.more_vert
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
