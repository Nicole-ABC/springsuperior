import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/member_services.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class TimeZone {
  factory TimeZone() => _this ?? TimeZone._();

  TimeZone._() {
    initializeTimeZones();
  }
  static TimeZone _this;

  Future<String> getTimeZoneName() async => FlutterNativeTimezone.getLocalTimezone();

  Future<tz.Location> getLocation([String timeZoneName]) async {
    if(timeZoneName == null || timeZoneName.isEmpty){
      timeZoneName = await getTimeZoneName();
    }
    return tz.getLocation(timeZoneName);
  }
}

class NotificationServices{
  static AndroidNotificationDetails androidSettings;
  static IOSNotificationDetails iosSettings;
  static FlutterLocalNotificationsPlugin fltrNotification;
  static InitializationSettings initializationSettings;

  static initializer() async{
    fltrNotification = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidNotificationDetails(
        'Expiry Id', 'Expiry', 'Expired',
        playSound: true, enableVibration: true,
        importance: Importance.max, priority: Priority.max);
    iosSettings = IOSNotificationDetails();
    var androidInitialize = new AndroidInitializationSettings('exercise_icon');
    var iOSInitialize = new IOSInitializationSettings();
    initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    await fltrNotification.initialize(initializationSettings);
  }



  static showNotification() async {
    MemberServices memberServices = MemberServices();
    var notifDetails =  NotificationDetails(android: androidSettings, iOS: iosSettings);

    List<Member> memList = await memberServices.checkDate();
    if(memList.isNotEmpty){
      for(Member m in memList){
        var scheduledTime = DateTime.parse(m.date);
        final timeZone = TimeZone();
        String timeZoneName = await timeZone.getTimeZoneName();
        final location = await timeZone.getLocation(timeZoneName);
        final scheduledDate = tz.TZDateTime.from(scheduledTime, location).add(Duration(minutes: 35));

        print('got here');
        fltrNotification.show(
            1,
            'Subscription Notification',
            'Faith\'s subscription has expired.',
            notifDetails
        );

        print('got here too');

        // await fltrNotification.zonedSchedule(
        //     member.id,
        //     'Subscription Notification',
        //     '${member.surname} ${member.firstName}\'s subscription has expired.',
        //     scheduledDate,
        //     notifDetails,
        //     uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.absoluteTime,
        //     androidAllowWhileIdle: true);
      }
    }

  }
}