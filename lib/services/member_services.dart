import 'package:spring_superior/data/database.dart';
import 'package:spring_superior/models/member_model.dart';
import 'package:spring_superior/services/attendance_services.dart';

class MemberServices{
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  AttendanceServices attendanceServices = AttendanceServices();

  Future<int> createMember(Member member) async{
    final db = await dbHelper.database;
    return await db.insert(
      'memberInfoTable',
      member.toMap()
    );
  }

  Future<int> updateMember(Member member) async{
    final db = await dbHelper.database;
    return await db.update(
      'memberInfoTable',
      member.toMap(),
      where: '_id=?',
      whereArgs: [member.id]
    );
  }

  Future<int> deleteMember(Member member) async{
    final db = await dbHelper.database;
    return await db.delete(
        'memberInfoTable',
        where: '_id=?',
        whereArgs: [member.id]
    );
  }

  Future<List<Member>> checkDate() async{
    DateTime now = DateTime.now();
    List<Member> membersList = await getAllMembers();
    List<Member> expList = List<Member>();
    membersList.forEach((member) async{
      DateTime expiryDate = DateTime.parse(member.date);
      if (now.isAfter(expiryDate)) {
        member = Member(
            id: member.id,
            surname: member.surname,
            firstName: member.firstName,
            date: member.date,
            active: 'false'
        );
        await updateMember(member);
        expList.add(member);
      }
    });
    return expList;
  }

  Future<List<Member>> getAllMembers() async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('memberInfoTable');

    List<Member> membersList =  allRows.map((member) => Member.fromMap(member)).toList();
    return membersList;
  }

  Future<List<Member>> searchMembers(String keyword) async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> searchRows = await db.query(
        'memberInfoTable',
        where: 'name LIKE ?',
        whereArgs: ['%$keyword%']);

    List<Member> membersList =  searchRows.map((member) =>
        Member.fromMap(member)).toList();
    return membersList;
  }


  Future<List<Member>> getMembersById(List<int> idNums) async{
    List<Member> membersList = List<Member>();
    List<Member> memList = await getAllMembers();
    for(int i = 0; i<idNums.length; i++){
      membersList.add(memList.firstWhere((f) => f.id == idNums[i]));
    }
    return membersList;
  }


  Future<List<Member>> getMemberActivity(String keyword) async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> activityRows = await db.query('memberInfoTable', where: 'active LIKE ?', whereArgs: ['$keyword']);

    List<Member> membersList =  activityRows.map((member) => Member.fromMap(member)).toList();
    return membersList;
  }

}