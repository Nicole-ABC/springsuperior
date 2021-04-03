class Member{
  int id;
  String surname;
  String firstName;
  String date;
  String phoneNumber;
  String active;

  Member({
    this.id,
    this.active,
    this.date,
    this.firstName,
    this.phoneNumber,
    this.surname,
  });

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if(id != null)
      map['_id'] = id;
    map['surname'] = surname;
    map['name'] = firstName;
    map['active'] = active;
    map['phoneNumber'] = phoneNumber;
    map['date'] = date;
    return map;
  }

  Member.fromMap(dynamic map){
    id = map['_id'];
    surname = map['surname'];
    firstName = map['name'];
    active = map['active'];
    phoneNumber = map['phoneNumber'];
    date = map['date'];

  }
}