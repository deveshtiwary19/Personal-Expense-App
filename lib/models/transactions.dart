import 'package:flutter/foundation.dart';

class Transactions {
  @required
  final String id; //Transaction id
  @required
  final String title; //The title to store
  @required
  final double amount; //To store the amount
  @required
  final DateTime date; //To store date

  //Following is the constructor
  Transactions({
    this.id,
    this.title,
    this.amount,
    this.date,
  });
}
