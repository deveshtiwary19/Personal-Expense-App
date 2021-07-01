import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transactions.dart';
import 'package:personal_expense/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> transactionList;

  Chart(this.transactionList);

  //Getter Method to generate the the list with spenditure amount for 7 days
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      //The loop calculates the total sum for the day
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].date.day == weekDay.day &&
            transactionList[i].date.month == weekDay.month &&
            transactionList[i].date.year == weekDay.year) {
          totalSum += transactionList[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  //Following is the getter for returning the sum or maximum expense for week
  double get maxSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);

    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  maxSpending == 0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
