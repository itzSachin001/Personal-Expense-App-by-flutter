import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double SpendingPercentOfTotal;

  ChartBar(this.label,this.spendingAmount,this.SpendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints)=>
      Column(
        children: [
          Container(
              height:constraints.maxHeight * 0.10,
              child: FittedBox(child: Text('₹$spendingAmount'))),

          SizedBox(height: constraints.maxHeight * 0.05,),

          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:Border.all(color: Colors.grey,width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                FractionallySizedBox(
                  heightFactor: SpendingPercentOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: constraints.maxHeight * 0.05,),

          Container(height: constraints.maxHeight * 0.10,
              child: FittedBox(
                  child: Text(label),)),
        ],
      ),
    );
  }
}
