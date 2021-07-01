import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transactions.dart';

class TransactionList extends StatelessWidget {
  List<Transactions> list = [];
  final Function deleteFunc;

  TransactionList(this.list, this.deleteFunc);

  @override
  Widget build(BuildContext context) {
//Checking the orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      child: list.isEmpty
          ? Column(
              //TO show on empty list
              children: [
                Image.asset(
                  'assets/images/empty_list.png',
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    'List is empty!!\nAdd some items now!!',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          : ListView.builder(
              //To show if items present under list
              itemBuilder: (ctx, index) {
                return Card(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '\$${list[index].amount}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        list[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle:
                          Text(DateFormat.yMMMd().format(list[index].date)),
                      trailing: isLandscape
                          ? FlatButton.icon(
                              onPressed: () {
                                deleteFunc(list[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              textColor: Colors.red,
                              label: Text('Delete'),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                deleteFunc(list[index].id);
                              },
                            ),
                    ),
                  ),
                );
              },
              itemCount: list.length,
            ),
    );
  }
}
