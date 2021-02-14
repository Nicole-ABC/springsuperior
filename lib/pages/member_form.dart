import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/member_services.dart';


class NewMember extends StatefulWidget {
  @override
  _NewMemberState createState() => _NewMemberState();
}

class _NewMemberState extends State<NewMember> {
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime _dateTime;

  MemberServices memberServices = MemberServices();

  final f = DateFormat.yMMMMd();

  checkDate() async{
    DateTime now = DateTime.now();
    MemberServices memberServices = MemberServices();
    List<Member> membersList = await memberServices.getAllMembers();
    membersList.forEach((member){
      DateTime expiryDate = DateTime.parse(member.date);

      if (now.isAfter(expiryDate)) {
        member = Member(
            id: member.id,
            surname: member.surname,
            firstName: member.firstName,
            date: member.date,
            active: 'false'
        );
        memberServices.updateMember(member);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
        elevation: 0.0,
        title: Text("New Member"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: Colors.white.withOpacity(0.5),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: TextField(
                  controller: surnameController,
                  decoration: InputDecoration(
                      hintText: 'Surname'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'First Name'
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          _dateTime == null ? "Pick an end date" :
                          f.format(_dateTime),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2100)
                          ).then((ddate) {
                            setState(() {
                              _dateTime = ddate;
                            });
                          });

                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).accentColor,
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Divider(
                  height: 1.0,
                  thickness: 1.5,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () {
                    final member = Member(
                      firstName: nameController.text,
                      surname: surnameController.text,
                      date: _dateTime.toString(),
                      active: 'true'
                    );
                    memberServices.createMember(member);
                    checkDate();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 300.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
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
    );
  }
}

