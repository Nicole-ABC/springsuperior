import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spring_superior/services/payment_services.dart';
import 'package:intl/intl.dart';

class PaymentDetails extends StatefulWidget {
  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  PaymentServices paymentServices = PaymentServices();
  DateFormat f = DateFormat.yMMMMd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment History'
        ),
      ),
      body: FutureBuilder(
        future: paymentServices.getAllPayments(),
        builder: (context, snapshot){
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
                child: Text(
                  'An error has occurred',
                  style:
                  TextStyle(color: Colors.red.withOpacity(0.7)),
                ));
          } else if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: CircularProgressIndicator(
                      backgroundColor:
                      Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
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
                child: Text("No payment details available yet",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 25.0)));
          }
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Container(
                    margin: EdgeInsets.all(6.0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '${snapshot.data[index].surname} ${snapshot.data[index].firstName} paid ${snapshot.data[index].amount} naira on ${f.format(DateTime.parse(snapshot.data[index].date))}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04
                        ),
                      ),
                    )
                );
              }
          );
        },
      ),
    );
  }
}
