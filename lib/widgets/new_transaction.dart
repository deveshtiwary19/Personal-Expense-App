import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
//Following are the variables, to get the input

  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

//Following is the method, that build a new date picker calendar
  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10, //Picking the height ofkeyboard and adjuting th padding accordingly
              left: 10,
              right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: amountController,
              ),

              //The date picker options
              Container(
                height: 70,
                child: Row(children: [
                  Text(selectedDate == null
                      ? 'No Date Chosen'
                      : 'Picked date: ${DateFormat.yMd().format(selectedDate)}'),
                  Expanded(
                    child: FlatButton(
                      textColor: Colors.purple,
                      child: Text(
                        'Chose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: presentDatePicker,
                    ),
                  ),
                ]),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.purple,
                onPressed: () {
                  widget.addTransaction(titleController.text,
                      double.parse(amountController.text), selectedDate);

                  Navigator.of(context).pop();

                  titleController.clear();
                  amountController.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
