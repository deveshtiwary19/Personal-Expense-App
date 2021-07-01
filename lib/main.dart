import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expense/models/transactions.dart';
import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';

//Following is the driver method
void main() => runApp(MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple, accentColor: Colors.amber),
      home: MyApp(),
    ));

//Following class draws UI by returing state
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

//Following class renders the state of Application
class MyAppState extends State<MyApp> {
  final List<Transactions> transactions = [];

  //Following is the method, to add value to the list
  void addTransaction(String title, double amount, DateTime date) {
    Transactions newTx = Transactions(
      title: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );

    if (title != null && amount != null && date != null) {
      setState(() {
        transactions.add(newTx);
      });
    }
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  //Following is the method, that will build a bottom sheet dialog on the screen
  void addNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext cont) {
          return GestureDetector(
            child: NewTransaction(addTransaction),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          );
        });
  }

//Following is the gettter to sort the list of transactions of last seven days
  List<Transactions> get recentTransactionsList {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //Following ios the variable, to get chart and switch
  bool type = false;

  @override
  Widget build(BuildContext context) {
    //Following is variable, to check whether the app is in Landscape or potrait
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: [
        Builder(
            builder: (ctx) => IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  addNewTransaction(ctx);
                }))
      ],
    );

    //Following is the UI tree for potrait mode
    final potraiUI = SingleChildScrollView(
        child: Column(
      children: [
        Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.3,
            child: Chart(recentTransactionsList)),
        Container(
            height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.7,
            child: TransactionList(transactions, deleteTransaction)),
      ],
    ));

    //Following is the UI for the landscape UI
    final landcapeUI = SingleChildScrollView(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show List'),
            Switch(
                value: type,
                onChanged: (val) {
                  setState(() {
                    type = val;
                  });
                }),
            Text('Show Chart'),
          ],
        ),
        type
            ? Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: Chart(recentTransactionsList))
            : Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(transactions, deleteTransaction)),
      ],
    ));

    return Scaffold(
        appBar: appBar,
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            backgroundColor: Colors.purple,
            child: Icon(Icons.add),
            onPressed: () {
              addNewTransaction(ctx);
            },
          ),
        ),
        //Checking the UI orienttion ns then rendering UI accordingly
        body: isLandscape ? landcapeUI : potraiUI);
  }
}
