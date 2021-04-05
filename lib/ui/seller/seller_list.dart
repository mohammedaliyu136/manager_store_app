import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_search_bar/simple_search_bar.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';

import 'edit_seller.dart';

class SellerList2 extends StatefulWidget {
  @override
  SellerListState createState() => SellerListState();
}
class SellerListState extends State<SellerList2> {
  final AppBarController appBarController = AppBarController();

  var mContext;

  List<TableRow> allSellers = [];
  var sellers = [];
  bool isSearched = false;

  void setSellers(sellers, bloc){
    allSellers=[];
    for(var i=0; i<sellers.length; i++){
      allSellers.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(sellers[i].name, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                child: Text(sellers[i].shopID, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: GestureDetector(
                    onTap: (){
                      showAlertDialog(mContext, bloc, sellers[i], i);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.edit),Icon(Icons.delete)],)
                ),
              ),
            ])
        );
      allSellers.add(
          TableRow(children: [
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
    !isSearched?setSellers(bloc.mSellers, bloc):'';
    return Scaffold(
        appBar: SearchAppBar(
          primary: Theme.of(context).primaryColor,
          appBarController: appBarController,
          // You could load the bar with search already active
          autoSelected: false,
          searchHint: "Search Sellers...",
          mainTextColor: Colors.white,
          onChange: (String value) {
            //Your function to filter list. It should interact with
            //the Stream that generate the final list
            //compareTo
            var searched = [];
            for(var i=0; i<bloc.mSellers.length; i++){
              if(bloc.mSellers[i].name.toLowerCase().contains(value.toLowerCase())){
                searched.add(bloc.mSellers[i]);
              }
            }
            setState(() {
              if(value.trim()==""){
                isSearched=false;
              }else{
                isSearched=true;
                setSellers(searched, bloc);
              }
            });
          },
          //Will show when SEARCH MODE wasn't active
          mainAppBar: AppBar(
            title: Text("Sellers"),
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
                columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.4), 2: FractionColumnWidth(.2)},
                border: TableBorder.all(
                    color: Colors.black26, width: 1, style: BorderStyle.solid),
                children: [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("Sellers Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("Shop", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
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
                      columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.4), 2: FractionColumnWidth(.2)},
                          border: TableBorder.all(
                          color: Colors.black26, width: 1, style: BorderStyle.solid),
                          children: allSellers
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
  showAlertDialog(BuildContext context, bloc, seller, position) {
    // Create button
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        bloc.deleteSeller(seller, position);
        setState(() {
          isSearched=false;
        });
        Navigator.of(context).pop();
      },
    );
    Widget editButton = FlatButton(
      child: Text("Edit"),
      onPressed: ()async{
        var result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditSeller(seller, position)),
        );
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Seller: ${seller.name}"),
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
