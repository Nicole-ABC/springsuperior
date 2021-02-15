
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/member_services.dart';

class MemberDetails extends StatefulWidget {
  final int id;
  final String firstName;
  final String surname;
  final String date;
  final bool active;

  MemberDetails({
    this.id,
    this.firstName,
    this.surname,
    this.date,
    this.active
  });


  @override
  _MemberDetailsState createState() => _MemberDetailsState(
    id: id,
    firstName: firstName,
    surname: surname,
    date: date,
    active: active
  );
}

class _MemberDetailsState extends State<MemberDetails> {
   int id;
   String firstName;
   String surname;
   String date;
   bool active;

   MemberServices memberServices = MemberServices();
   DateTime _expiryDate;

  _MemberDetailsState({
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


  String dateString (){
    DateTime dateTime = DateTime.parse(date);
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *0.85,
          height: MediaQuery.of(context).size.height *0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: active ? Theme.of(context).accentColor : Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: active ? Theme.of(context).accentColor : Colors.grey.withOpacity(0.7)
                    ),
                    child: Center(
                      child: Text(
                        '$surname $firstName',
                        style: TextStyle(
                            fontSize: 30.0,
                          color: Colors.white
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: Text(
                      active ? 'Subscription is still active. It will expire on ${dateString()}': 'Subscription has expired on ${dateString()}',
                      style: TextStyle(
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: active ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){},
                      child: Center(
                        child: Container(
                          width: 150.0,
                          height: 60.0,
                          padding: EdgeInsets.only(right: 4.0, left: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: 150.0,
                        height: 60.0,
                        padding: EdgeInsets.only(right: 10.0, left: 4.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(
                          child: Text(
                            'Present',
                            style: TextStyle(
                                fontSize: 20.0
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
                InkWell(
                  onTap: ()async{
                    showDatePicker(
                        context: context,
                        initialDate: _expiryDate == null ? DateTime.parse(date) : _expiryDate,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2100),
                    ).then((expDate) async{
                        setState(() {
                          _expiryDate = expDate;
                          date = _expiryDate.toString();

                        });
                    });
                    final member = Member(
                        id: id,
                        firstName: firstName,
                        surname: surname,
                        date: date,
                        active: 'true'
                    );
                    await memberServices.updateMember(member);
                    await memberServices.getAllMembers();
                    print(member.date);
                    print(_expiryDate);
                  },
                  child: Container(
                    width: 350.0,
                    height: 60.0,
                    margin: EdgeInsets.only(right: 16.0, left: 16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.7)),
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'Renew Subscription',
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius:  BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)
                  ),
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)
                      ),
                      color: Theme.of(context).primaryColor.withOpacity(0.9)
                    ),
                    child: Center(
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
