import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:spring_superior/services/notification_services.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'models/member_model.dart';
import 'pages/home.dart';

// callbackDispatcher() {
//   print('got here four');
//   Workmanager.executeTask((taskName, inputData) {
//     NotificationServices.initializer();
//     NotificationServices.showNotification();
//     return Future.value(true);
//   });
// }
//

const simplePeriodicTask = 'simplePeriodicTask';

void _showNotification(fltrNotification) async {

  var androidSettings = AndroidNotificationDetails(
      'Expiry Id', 'Expiry', 'Expired',
      playSound: true, enableVibration: true,
      importance: Importance.max, priority: Priority.max);
  var iosSettings = IOSNotificationDetails();
  var notifDetails =  NotificationDetails(android: androidSettings, iOS: iosSettings);


  fltrNotification.show(
      1,
      'Subscription Notification',
      'Faith\'s subscription has expired.',
      notifDetails
  );
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print('here ****************************************************************');
  await Workmanager.initialize(
    callbackDispatcher,
    // isInDebugMode: true,
  );

  print('got here three');
  await Workmanager.registerPeriodicTask(
    '5',
    simplePeriodicTask,
    frequency: Duration(minutes: 15),
    initialDelay: Duration(seconds: 10)
  );

  runApp(MyApp());
}

void callbackDispatcher(){
  print('dispatch -----------------------------------------------------------------');
  Workmanager.executeTask((taskName, inputData) async{
    FlutterLocalNotificationsPlugin fltrNotification = FlutterLocalNotificationsPlugin();
    var androidInitialize = new AndroidInitializationSettings('exercise_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings);


    MemberServices memberServices = MemberServices();
    List<Member> memList = await memberServices.checkDate();
    if(memList.isNotEmpty){
      for(Member m in memList){
        var scheduledTime = DateTime.now();
        final timeZone = TimeZone();
        String timeZoneName = await timeZone.getTimeZoneName();
        final location = await timeZone.getLocation(timeZoneName);
        final scheduledDate = tz.TZDateTime.from(scheduledTime, location).add(Duration(seconds: 20));
        print('here ==================================================================');
        _showNotification(fltrNotification);
        // await fltrNotification.zonedSchedule(
        //     m.id,
        //     'Subscription Notification',
        //     '${m.surname} ${m.firstName}\'s subscription has expired.',
        //     scheduledDate,
        //     notifDetails,
        //     uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.absoluteTime,
        //     androidAllowWhileIdle: true);
      }
    }

    return Future.value(true);
  });
}

// Future<List<Member>>checkDate() async {
//   MemberServices memServices = MemberServices();
//   List<Member> memList = List<Member>();
//   DateTime now = DateTime.now();
//   List<Member> membersList = await memServices.getAllMembers();
//   membersList.forEach((member) async {
//     DateTime expiryDate = DateTime.parse(member.date);
//     if (now.isAfter(expiryDate)) {
//       member = Member(
//           id: member.id,
//           surname: member.surname,
//           firstName: member.firstName,
//           date: member.date,
//           active: 'false');
//       await memServices.updateMember(member);
//       memList.add(member);
//     }
//   });
//   return memList;
// }



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


