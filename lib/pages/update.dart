import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/models/payment_model.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:spring_superior/services/payment_services.dart';

class Update extends StatefulWidget {
  Member member;

  Update({this.member});
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController amountController = TextEditingController();
  MemberServices memberServices = MemberServices();
  PaymentServices paymentServices = PaymentServices();
  DateTime _dateTime;

  DateFormat f = DateFormat.yMMMMd();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width *0.05),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width *0.05),
        child: Column(
          children: [
            Text(
              '${widget.member.surname} ${widget.member.firstName}'
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: amountController,
              decoration: InputDecoration(
                hintText: 'Amount',
              ),
            ),
            Container(
              height: 50.0,
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
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  if(amountController.text == ''){
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Text field cannot be empty!'),
                    ));
                  }
                  else if(_dateTime == null){
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please select a date!'),
                    ));
                  }
                  else if(DateTime.now().isAfter(_dateTime)){
                    final member = Member(
                        id: widget.member.id,
                        firstName: widget.member.firstName,
                        surname: widget.member.surname,
                        date: _dateTime.toString(),
                        active: 'false'
                    );
                    final payment = Payment(
                        firstName: widget.member.firstName,
                        surname: widget.member.surname,
                        date: DateTime.now().toString(),
                        amount: int.parse(amountController.text)
                    );
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('${widget.member.surname} ${widget.member.firstName} has been updated.'),
                    ));
                    setState(() {
                      paymentServices.createPayment(payment);
                      memberServices.updateMember(member);
                      amountController.clear();
                    });
                    _dateTime = null;
                  }
                  else {
                    final member = Member(
                        id: widget.member.id,
                        firstName: widget.member.firstName,
                        surname: widget.member.surname,
                        date: _dateTime.toString(),
                        active: 'true'
                    );
                    final payment = Payment(
                        firstName: widget.member.firstName,
                        surname: widget.member.surname,
                        date: DateTime.now().toString(),
                        amount: int.parse(amountController.text)
                    );
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('${widget.member.surname} ${widget.member
                          .firstName} has been updated.'),
                    ));
                    setState(() {
                      paymentServices.createPayment(payment);
                      memberServices.updateMember(member);
                      amountController.clear();
                    });
                    _dateTime = null;
                  }
                },
                child: Container(
                  width: 300.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
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
                      'Done',
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
      )
    );
  }
}
