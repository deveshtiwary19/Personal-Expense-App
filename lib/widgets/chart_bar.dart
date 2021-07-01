import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  //Following are the properties we need to show the chart bar
  final String label;
  final double spndingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spndingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        children: [
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$${spndingAmount.toStringAsFixed(0)}'))),

          SizedBox(
            height: constraint.maxHeight * 0.05,
          ), //A spacing of 4

          //The main bar
          Container(
            height: constraint.maxHeight * 0.6,
            width: 20,
            child: Stack(
              children: [
                //The background container
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),

                //Following will be the component for the overlapping according to required percentage
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: constraint.maxHeight * 0.05,
          ), //A spacing of 4
          Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
