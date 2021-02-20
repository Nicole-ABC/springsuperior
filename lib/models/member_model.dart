class Member{
  int id;
  String surname;
  String firstName;
  String date;
  String amount;
  String active;

  Member({
    this.id,
    this.active,
    this.date,
    this.amount,
    this.firstName,
    this.surname,
  });

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if(id != null)
      map['_id'] = id;
    map['surname'] = surname;
    map['name'] = firstName;
    map['amount'] = amount;
    map['active'] = active;
    map['date'] = date;
    return map;
  }

  Member.fromMap(dynamic map){
    id = map['_id'];
    surname = map['surname'];
    firstName = map['name'];
    amount = map['amount'];
    active = map['active'];
    date = map['date'];

  }
}