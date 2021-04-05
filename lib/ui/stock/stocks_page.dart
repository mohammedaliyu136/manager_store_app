import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/repository/api.dart';
import 'package:flutter_shopmanager_v21/ui/seller/sellers_page.dart';
import 'package:flutter_shopmanager_v21/ui/stock/stock_list.dart';
import 'package:flutter_shopmanager_v21/ui/stockCategory/stockCategory_page.dart';
import 'package:provider/provider.dart';
import '../barchartsample.dart';

import '../shop/shops_page.dart';
import 'new_stock.dart';

class StocksPage extends StatefulWidget {
  @override
  StocksPageState createState() => StocksPageState();
}
class StocksPageState extends State<StocksPage> {
  List<TableRow> itemRemaining = [];
  List<TableRow> allStocks = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void setRemaining(stocks){
    itemRemaining=[];
    for(var i=0; i<stocks.length; i++){
      if(i<5){
        itemRemaining.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(stocks[i].item, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(child: Text(stocks[i].quantity.toString(), style: TextStyle(fontSize: 16,),)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text("₦${stocks[i].price}", style: TextStyle(fontSize: 16,),),
              ),
            ])
        );
        itemRemaining.add(
          TableRow(children: [
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
          ]),
        );
      }
    }
  }

  void setStocks(stocks){
    allStocks=[];
    for(var i=0; i<stocks.length; i++){
      if(i<5){
        allStocks.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(stocks[i].item, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(child: Text(stocks[i].quantity.toString(), style: TextStyle(fontSize: 16,),)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text("₦${stocks[i].price}", style: TextStyle(fontSize: 16,),),
              ),
            ])
        );
        allStocks.add(
          TableRow(children: [
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
          ]),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //var stocks_data = parseStock(stocks);

    var bloc = Provider.of<BlocManager>(context);
    print("-------------------------------------===================");
    if(bloc.mStocks!=null){
      setRemaining(bloc.mStocks);
      setStocks(bloc.mStocks);
    }

    return !bloc.isLoading?Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("STOCKS"),
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.more_vert, color: Colors.white,),),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text('Manager', style: TextStyle(color: Colors.white, fontSize: 30, ),)),
              decoration: BoxDecoration(
                color: Color.fromRGBO(90, 0, 40, 1),
              ),
            ),
            Container(
              color: Color.fromRGBO(90, 0, 40, 1),
              child: ListTile(
                leading: Icon(Icons.storage, color: Colors.white, size: 30,),
                title: Text('Stocks', style: TextStyle(fontSize: 20, color: Colors.white)),
                onTap: () {

                },
              ),
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
            ListTile(
              leading: Icon(Icons.storage, color: Color.fromRGBO(90, 0, 40, 1), size: 30,),
              title: Text('Sellers', style: TextStyle(fontSize: 20, color: Color.fromRGBO(90, 0, 40, 1))),
              onTap: () {
                bloc.getSellers();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellersPage()),
                );
              },
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
            ListTile(
              leading: Icon(Icons.store, color: Color.fromRGBO(90, 0, 40, 1), size: 30,),
              title: Text('Shops', style: TextStyle(fontSize: 20),),
              onTap: () {
                bloc.getShops();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopsPage()),
                );
              },
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
            ListTile(
              leading: Icon(Icons.store, color: Color.fromRGBO(90, 0, 40, 1), size: 30,),
              title: Text('Stock Categories', style: TextStyle(fontSize: 20),),
              onTap: () {
                bloc.getStockCategories();
              },
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
          ],
        ),
      ),
      body: ListView(children: [
        /**
        Container(
          color: Color.fromRGBO(90, 0, 40, 1),//Color(0xff2c4260),
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width * 1,
          child: BarChartSample2(),
        ),
        SizedBox(height: 20,),
        */
        Padding(
          padding: const EdgeInsets.only(top:18.0, left: 18.0, right: 18, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("20 Items is running low", style: TextStyle(fontSize: 18, ),),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StockList()),
                    );
                  },
                  child: Text("See All", style: TextStyle(fontSize: 16, color: Colors.grey),)
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: {0: FractionColumnWidth(.5),1: FractionColumnWidth(.3), 2: FractionColumnWidth(.2),},
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
                child: Center(child: Text("Qty Left", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,),
                child: Text("Price", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ),
            ]),
          ],),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
          child: Table(
            columnWidths: {0: FractionColumnWidth(.5),1: FractionColumnWidth(.3), 2: FractionColumnWidth(.2),},
            children: itemRemaining

              /**
              TableRow(children: [
              Container(color: Colors.grey[300], height: 1,),
              Container(color: Colors.grey[300], height: 1,),
              Container(color: Colors.grey[300], height: 1,),
              ]),
                  **/
            ),
        ),
        
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(top:18.0, left: 18.0, right: 18, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Stocks", style: TextStyle(fontSize: 18),),
              GestureDetector(
                  onTap: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StockList()),
                        );
                  },
                  child: Text("See All", style: TextStyle(fontSize: 16, color: Colors.grey),)
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            columnWidths: {0: FractionColumnWidth(.5),1: FractionColumnWidth(.3), 2: FractionColumnWidth(.2),},
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
                      child: Center(child: Text("Qty Left", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,),
                      child: Text("Price", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    ),
                  ]),

            ],),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
          child: Table(
            columnWidths: {0: FractionColumnWidth(.5),1: FractionColumnWidth(.3), 2: FractionColumnWidth(.2),},
            children: allStocks
          ),
        ),

      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewStock()),
          );

          final snackBar = SnackBar(content: Text('Yay! A SnackBar! $result'), backgroundColor: Colors.green,);
          _scaffoldKey.currentState.showSnackBar(snackBar);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(90, 0, 40, 1),
      ),
    ):Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 0, 40, 1),),),
            SizedBox(height: 20,),
            Text("Loading, Please wait", style: TextStyle(fontSize: 20,),),
          ],
        ),
      ),
    );
  }
}
