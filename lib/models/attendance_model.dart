class Attendance{
  int id;
  String date;

  Attendance({
    this.id,
    this.date,
  });

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if(id != null) {
      map['attendanceId'] = id;
      map['attendanceDate'] = date;
    }

    return map;
  }

  Attendance.fromMap(dynamic map){
    id = map['attendanceId'];
    date = map['attendanceDate'];
  }
}