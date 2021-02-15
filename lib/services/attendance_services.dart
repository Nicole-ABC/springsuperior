import 'package:spring_superior/data/database.dart';
import 'package:spring_superior/models/attendance_model.dart';

class AttendanceServices{
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  createAttendance(Attendance attendance) async{
    final db = await dbHelper.database;
    db.insert(
        'memberAttendance',
        attendance.toMap()
    );
  }

  Future<List<Attendance>> getAllAttendances() async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('memberAttendance', where: 'date ?');

    List<Attendance> attendanceList =  allRows.map((attendance) => Attendance.fromMap(attendance)).toList();
    return attendanceList;
  }

}