import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:workmanager/workmanager.dart';
import 'pages/home.dart';

const simplePeriodicTask = 'simplePeriodicTask';
MemberServices memberServices = MemberServices();

void _showNotification(FlutterLocalNotificationsPlugin fltrNotification) async {

  var androidSettings = AndroidNotificationDetails(
      'Expiry Id', 'Expiry', 'Expired',
      playSound: true, enableVibration: true,
      importance: Importance.max, priority: Priority.max);
  var iosSettings = IOSNotificationDetails();
  var notifDetails =  NotificationDetails(android: androidSettings, iOS: iosSettings);

  await fltrNotification.show(
      1,
      'Subscription Notification',
      'Hello! Time to check for updates',
      notifDetails,
  );

}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  await Workmanager.registerPeriodicTask(
    '5',
    simplePeriodicTask,
    frequency: Duration(hours: 12),
    initialDelay: Duration(seconds: 10),
  );

  runApp(MyApp());
}

void callbackDispatcher(){
  Workmanager.executeTask((taskName, inputData) async{
    FlutterLocalNotificationsPlugin fltrNotification = FlutterLocalNotificationsPlugin();
    var androidInitialize = new AndroidInitializationSettings('exercise_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    fltrNotification.initialize(initializationSettings);

    _showNotification(fltrNotification);

    return Future.value(true);
  });
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spring Superior',
      theme: ThemeData(
          primaryColor: Color(0xFF070707),
          accentColor: Colors.purple[800]
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}


