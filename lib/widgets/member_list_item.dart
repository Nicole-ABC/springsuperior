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

  DateTime dateP;

  final f = DateFormat.yMMMMd();

  _MemberListItemState({
    this.id,
    this.firstName,
    this.surname,
    this.date,
    this.active
  });


  @override
  void initState() {
    setDate();
    super.initState();
  }

  setDate(){
    dateP = DateTime.parse(date);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('$id'),
      child: Container(
        margin: EdgeInsets.all(8.0),
        height: 100.0,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    color: active ? Colors.green: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0)
                  )

                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("$surname $firstName"),
                      active ? Text("Active") : Text("Inactive"),
                      Text(
                        f.format(dateP),
                      )
                    ],
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
