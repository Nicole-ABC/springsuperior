import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemberListItem extends StatefulWidget {
  int id;
  String firstName;
  String surname;
  String date;
  String active;

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


  _MemberListItemState({
    this.id,
    this.firstName,
    this.surname,
    this.date,
    this.active
  });

  String dateString (){
    DateTime dateTime = DateTime.parse(date);
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                height: 30.0,
                width: 30.0,
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
                      Text("$surname $firstName"),
                      Text(dateString())
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
    );
  }
}
