import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);


  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput=TextEditingController();
  final _amountInput=TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    var enteredAmount = double.parse(_amountInput.text);
    var enteredTitle = _titleInput.text;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle,enteredAmount,_selectedDate);

    Navigator.of(context).pop();
  }

  void _datePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1945),
        lastDate: DateTime.now()).then((pickedDate) {
          if(pickedDate==null){
            return;
          }

          _selectedDate=pickedDate;
          setState(() {

          });
    });
}

  @override
  Widget build(BuildContext context) {




    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          //margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom +10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration:const InputDecoration(
                  label: Text("Title",style:TextStyle(fontSize: 20,color: Colors.black) ,),
                  border:OutlineInputBorder(
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2,color: Colors.orange)
                  ),
                ),
                controller: _titleInput,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 10,),

              TextField(
                decoration:const InputDecoration(
                  label: Text("Amount",style: TextStyle(fontSize: 20,color: Colors.black),),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2,color: Colors.orange)
                  ),
                ),
                controller: _amountInput,
                keyboardType: TextInputType.number,
              ),



              Container(
                margin: EdgeInsets.symmetric(vertical: 20,horizontal:5 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedDate == null ?Text("No Date Chosen !"):Text('Picked Date: '+ DateFormat.yMMMd().format(_selectedDate!),) ,
                    TextButton(onPressed: _datePicker, child: Text("Choose Date",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 16),)),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: submitData,
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text("Add Transaction"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

