import 'package:spring_superior/data/database.dart';
import 'package:spring_superior/models/attendance_model.dart';
import 'package:spring_superior/models/member_model.dart';

class AttendanceServices{
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> createAttendance(Attendance attendance) async{
    final db = await dbHelper.database;
    return db.insert(
        'memberAttendance',
        attendance.toMap()
    );
  }

  Future<int> deleteAttendance(Member member) async{
    final db = await dbHelper.database;
    return await db.delete(
        'memberAttendance',
        where: 'FK_memberInfoTable_memberAttendance = ?',
        whereArgs: [member.id]
    );
  }

  Future<int> deleteDateAttendance(Member member, String date) async{
    final db = await dbHelper.database;
    return await db.delete(
        'memberAttendance',
        where: 'FK_memberInfoTable_memberAttendance = ? AND attendanceDate = ?',
        whereArgs: [member.id, '$date']
    );
  }

  Future<List<String>> getAllDates() async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('memberAttendance');

    List<Attendance> attendanceList =  allRows.map((attendance) => Attendance.fromMap(attendance)).toList();
    List<String> datesList = List<String>();

    attendanceList.forEach((attendance){
      if(!datesList.contains(attendance.date)){
        datesList.add(attendance.date);
      }
    });
    return datesList;
  }

  Future<List<Attendance>> getAllAttendancesByDate(String date) async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('memberAttendance', where: 'attendanceDate = ?', whereArgs: ['$date']);

    List<Attendance> attendanceList =  allRows.map((attendance) => Attendance.fromMap(attendance)).toList();
    return attendanceList;

  }


  Future<List<int>> getPresentMemberId(String date) async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('memberAttendance', where: 'attendanceDate = ?', whereArgs: ['$date']);

    List<Attendance> attendanceList = allRows.map((attendance) => Attendance.fromMap(attendance)).toList();
    List<int> idList = List<int>();

    attendanceList.forEach((attendance){
      idList.add(attendance.memberId);
    });
    return idList;
  }

}