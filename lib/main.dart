//import 'dart:html';
import 'dart:io';

import 'package:expense_app/Widgets/chart.dart';
import 'package:expense_app/Widgets/new_transaction.dart';
import 'package:expense_app/Widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/transaction.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());

}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'AppBarFont',
            fontSize: 20
          )
        )
      ),);
  }
}
class MyHomePage extends StatefulWidget{

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // final List<Transaction> _userTransaction = [
  //   Transaction(id: 'a1', title: 'Shirt', amount: 700, date: DateTime.now()),
  //   Transaction(id: 'a2', title: 'Pant', amount: 900, date: DateTime.now())];

  final List<Transaction> _userTransaction=[];
  
  List<Transaction> get _recentTransaction{
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle,double txAmount,DateTime datePicked){
    final newTransaction=Transaction(id: DateTime.now().toString(), title: txTitle, amount: txAmount, date: datePicked);

    setState(() {
      _userTransaction.add(newTransaction);
    });
  }
  
  
  void _startNewTransaction(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return GestureDetector(
        onTap: (){},
        child: NewTransaction(_addNewTransaction),
      behavior: HitTestBehavior.opaque,);
    },);
  }

  void _deleteTx(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id==id );
    });
  }

  bool _showChart=false;

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txListWidget){
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Show Chart"),
        Switch.adaptive(value: _showChart, onChanged: (val){
          _showChart=val;
          setState(() {

          });
        }),
      ],
    ), _showChart?
    Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
        child: Chart(_recentTransaction))
        :txListWidget];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txListWidget){
    return [Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.25,
        child: Chart(_recentTransaction)),txListWidget];
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery=MediaQuery.of(context);
    final PreferredSizeWidget appBar= Platform.isIOS ?
                                          CupertinoNavigationBar(
                                            middle:  Text("Expense App"),
                                            trailing: Row(
                                              children: [
                                                IconButton(onPressed:() {_startNewTransaction(context);}, icon: Icon(Icons.add,size: 30,)),
                                              ],
                                            ),
                                          ) as ObstructingPreferredSizeWidget :
                                          AppBar(
                                            title: Text("Expense App"),
                                            actions: [
                                              IconButton(onPressed:() {_startNewTransaction(context);}, icon: Icon(Icons.add,size: 30,)),
                                            ],);

    final isLandscape=mediaQuery.orientation == Orientation.landscape;

    final txListWidget=Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.65 ,
        child: TransactionList(_userTransaction,_deleteTx));

    final pageBody= SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [

            if(isLandscape) ..._buildLandscapeContent(mediaQuery, appBar,txListWidget),

            if(!isLandscape)  ..._buildPortraitContent(mediaQuery, appBar,txListWidget),


          ],
        ),
      ),
    );

    return Platform.isIOS ? CupertinoPageScaffold(child: pageBody,navigationBar: appBar as ObstructingPreferredSizeWidget,)  : Scaffold(
      appBar: appBar,

      body:pageBody,

      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        onPressed:() {_startNewTransaction(context);},
        child: Icon(Icons.add,size: 35,),
        backgroundColor: Colors.green,
      ),
    );
  }
}
