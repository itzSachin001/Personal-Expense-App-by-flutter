import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty? LayoutBuilder(builder: (ctx,constraints){
       return Container(height: constraints.maxHeight * 0.7,
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Image.asset('assets/images/no_transaction_image.png',fit: BoxFit.cover),
           ));
    }):ListView.builder(
        itemBuilder: (context,index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(child: Text('₹ ${transactions[index].amount}')),
                ),
              ),
              title: Text(transactions[index].title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date,)),
              trailing: MediaQuery.of(context).size.width > 500 ? TextButton.icon(onPressed: (){
                deleteTx(transactions[index].id);
              }, icon: Icon(Icons.delete,color: Colors.red,size: 26,), label: Text("Delete")) :
              IconButton(
                icon: Icon(Icons.delete,color: Colors.red,size: 26,),
                onPressed: (){
                  deleteTx(transactions[index].id);
                },
              ),
            ),
          );
          },
          itemCount: transactions.length,
    );
  }
}

// Card(child: Row(
// children: [
// Container(
// margin:EdgeInsets.symmetric(vertical: 10,horizontal: 15),
// padding: EdgeInsets.all(10),
// decoration: BoxDecoration(
// border: Border.all(width: 2,color: Colors.red)
// ),
//
// child: Text('₹ '+ transactions[index].amount.toStringAsFixed(2),
// style:TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 17,
// color: Colors.red,
// fontFamily:"MyFont") ,),),
//
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(transactions[index].title,
// style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
//
// Text(DateFormat.yMMMd().format(transactions[index].date),
// style: TextStyle(color: Colors.grey),),
// ],)
// ],
// ));