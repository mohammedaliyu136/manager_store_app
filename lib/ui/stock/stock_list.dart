import 'package:flutter/material.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'package:simple_search_bar/simple_search_bar.dart';

import 'edit_stock.dart';

class StockList extends StatefulWidget {
  @override
  StockListState createState() => StockListState();
}
class StockListState extends State<StockList> {
  final AppBarController appBarController = AppBarController();

  var mContext;

  List<TableRow> allStocks = [];
  var stocks = [];
  bool isSearched = false;

  void setStocks(stocks, bloc){
    allStocks=[];
    for(var i=0; i<stocks.length; i++){
        allStocks.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(stocks[i].item, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(child: Text(stocks[i].quantity.toString(), style: TextStyle(fontSize: 16,),)),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Text("₦${stocks[i].price}", style: TextStyle(fontSize: 16,),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: GestureDetector(
                    onTap: (){
                      showAlertDialog(mContext, bloc, stocks[i], i);
                    },
                    child: Row(children: [Icon(Icons.edit),Icon(Icons.delete)],)
                ),
              ),
            ])
        );
        allStocks.add(
          TableRow(children: [
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
          ]),
        );
      }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      mContext = context;
    });

    var bloc = Provider.of<BlocManager>(context);
    !isSearched?setStocks(bloc.mStocks, bloc):'';
    return Scaffold(
        appBar: SearchAppBar(
          primary: Theme.of(context).primaryColor,
          appBarController: appBarController,
          // You could load the bar with search already active
          autoSelected: false,
          searchHint: "Search Inventory...",
          mainTextColor: Colors.white,
          onChange: (String value) {
            //Your function to filter list. It should interact with
            //the Stream that generate the final list
            //compareTo
            //print("Stock - Chicken, White".contains("Stock"));
            var searched = [];
            for(var i=0; i<bloc.mStocks.length; i++){
              if(bloc.mStocks[i].item.toLowerCase().contains(value.toLowerCase())){
                print(bloc.mStocks[i].item);
                searched.add(bloc.mStocks[i]);
              }
            }
            setState(() {
              if(value.trim()==""){
                isSearched=false;
              }else{
                isSearched=true;
                setStocks(searched, bloc);
              }
            });
          },
          //Will show when SEARCH MODE wasn't active
          mainAppBar: AppBar(
            title: Text("INVENTORY"),
            actions: <Widget>[
              InkWell(
                child: Icon(
                  Icons.search,
                ),
                onTap: () {
                  //This is where You change to SEARCH MODE. To hide, just
                  //add FALSE as value on the stream
                  appBarController.stream.add(true);

                },
              ),
              SizedBox(width: 15,)
            ],
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Table(
                columnWidths: {0: FractionColumnWidth(.5),1: FractionColumnWidth(.13), 2: FractionColumnWidth(.2),},
                border: TableBorder.all(
                    color: Colors.black26, width: 1, style: BorderStyle.solid),
                children: [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("Item Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("Qty", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                            child: Text("Price", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: Text("Action", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                        ),
                      ]),
                ]
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Table(
                      columnWidths: {0: FractionColumnWidth(.5),1: FractionColumnWidth(.13), 2: FractionColumnWidth(.2),},
                          border: TableBorder.all(
                          color: Colors.black26, width: 1, style: BorderStyle.solid),
                          children: allStocks
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
  showAlertDialog(BuildContext context, bloc, stock, position) {
    // Create button
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        bloc.deleteStock(stock, position);
        Navigator.of(context).pop();
      },
    );
    Widget editButton = FlatButton(
      child: Text("Edit"),
      onPressed: ()async{
        var result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditStock(stock, position)),
        );
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("Simple Alert"),
      content: Text("Item: ${stock.item}"),
      actions: [
        deleteButton,
        editButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
