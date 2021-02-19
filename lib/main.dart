import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:spring_superior/services/notification_services.dart';

import 'pages/home.dart';

callbackDispatcher() {
  print('got here four');
  Workmanager.executeTask((taskName, inputData) {
    NotificationServices.initializer();
    NotificationServices.showNotification();
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  print('got here three');
  Workmanager.registerPeriodicTask(
    '8',
    'simplePeriodicTask',
    frequency: Duration(minutes: 15),
  );

  runApp(MyApp());
}


Future<List<Member>>checkDate() async {
  MemberServices memServices = MemberServices();
  List<Member> memList = List<Member>();
  DateTime now = DateTime.now();
  List<Member> membersList = await memServices.getAllMembers();
  membersList.forEach((member) async {
    DateTime expiryDate = DateTime.parse(member.date);
    if (now.isAfter(expiryDate)) {
      member = Member(
          id: member.id,
          surname: member.surname,
          firstName: member.firstName,
          date: member.date,
          active: 'false');
      await memServices.updateMember(member);
      memList.add(member);
    }
  });
  return memList;
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF070707),
        accentColor: Colors.purple[800]
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}


