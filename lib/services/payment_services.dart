import 'package:spring_superior/data/database.dart';
import 'package:spring_superior/models/payment_model.dart';

class PaymentServices{
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> createPayment(Payment payment) async{
    final db = await dbHelper.database;
    return await db.insert(
        'memberPayment',
        payment.toMap()
    );
  }

  Future<int> deletePayment(Payment payment) async{
    final db = await dbHelper.database;
    return await db.delete(
        'memberPayment',
        where: 'paymentId',
        whereArgs: [payment.id]
    );
  }

  Future<List<Payment>> getAllPayments() async{
    final db = await dbHelper.database;
    List<Map<String, dynamic>> allRows = await db.query('memberPayment');

    List<Payment> paymentList = allRows.map((payment) => Payment.fromMap(payment)).toList();
    return paymentList;
  }

}