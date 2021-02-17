class Attendance{
  int id;
  String date;
  int memberId;

  Attendance({
    this.id,
    this.date,
    this.memberId,
  });

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if(id != null)
      map['attendanceId'] = id;
      map['attendanceDate'] = date;
      map['FK_memberInfoTable_memberAttendance'] = memberId;
      return map;
  }

  Attendance.fromMap(dynamic map){
    id = map['attendanceId'];
    date = map['attendanceDate'];
    memberId = map['FK_memberInfoTable_memberAttendance'];
  }
}