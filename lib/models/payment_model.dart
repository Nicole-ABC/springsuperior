class Payment{
  int id;
  String firstName;
  String surname;
  int amount;
  String date;

  Payment({
    this.id,
    this.firstName,
    this.surname,
    this.amount,
    this.date
});

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    if(id != null)
      map['paymentId'] = id;
    map['paymentSurname'] = surname;
    map['paymentName'] = firstName;
    map['paymentAmount'] = amount;
    map['paymentDate'] = date;
    return map;
  }

  Payment.fromMap(dynamic map){
    id = map['paymentId'];
    surname = map['paymentSurname'];
    firstName = map['paymentName'];
    amount = map['paymentAmount'];
    date = map['paymentDate'];

  }
}