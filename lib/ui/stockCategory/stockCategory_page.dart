import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/ui/shop/shop_list.dart';
import 'package:flutter_shopmanager_v21/ui/stock/stock_list.dart';
import 'package:flutter_shopmanager_v21/ui/stock/stocks_page.dart';
import 'package:provider/provider.dart';

import '../BarChartSample1.dart';
import 'new_stockCategory.dart';
import '../seller/sellers_page.dart';
import 'stockCategories_list.dart';

class StockCategoryPage extends StatefulWidget {
  Shop2 shop;
  StockCategoryPage(this.shop);
  @override
  StockCategoryPageState createState() => StockCategoryPageState(shop);
}

class StockCategoryPageState extends State<StockCategoryPage> {
  Shop2 shop;
  StockCategoryPageState(shop);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<TableRow> shopsList = [];
  void setStockCategories(List<StockCategory2> stockCategories){
    shopsList=[];
    for(var i=0; i<stockCategories.length; i++){
      if(i<5){
        shopsList.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(stockCategories[i].name, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(stockCategories[i].description, style: TextStyle(fontSize: 16,),),
              ),
            ])
        );
        shopsList.add(
          TableRow(children: [
            Container(color: Colors.grey[300], height: 1,),
            Container(color: Colors.grey[300], height: 1,),
          ]),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);

    !bloc.isLoading?setState((){setStockCategories(bloc.mStockCategories);}):'';

    return !bloc.isLoading?Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Stock Categories"),
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
            ListTile(
              leading: Icon(Icons.storage, color: Color.fromRGBO(90, 0, 40, 1), size: 30,),
              title: Text('Stocks', style: TextStyle(fontSize: 20, color: Color.fromRGBO(90, 0, 40, 1))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StocksPage()),
                );
              },
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
            Container(
              color: Color.fromRGBO(90, 0, 40, 1),
              child: ListTile(
                leading: Icon(Icons.store, color: Colors.white, size: 30,),
                title: Text('Shops', style: TextStyle(fontSize: 20, color: Colors.white),),
                onTap: () {

                },
              ),
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
          ],
        ),
      ),
      body: ListView(children: [
        Container(
          color: Colors.green,
          child: Container(
            color: Color.fromRGBO(90, 0, 40, 1),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width * 1,
            child: BarChartSample1(),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(top:18.0, left: 18.0, right: 18, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Stock Categories", style: TextStyle(fontSize: 18),),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StockCategoriesList()),
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
            columnWidths: {0: FractionColumnWidth(.3), 1: FractionColumnWidth(.7),},
            children: [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: Text("Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Center(child: Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                    ),
                  ]),

            ],),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
          child: Table(
            columnWidths: {0: FractionColumnWidth(.3), 1: FractionColumnWidth(.7),},
            children: shopsList
          ),
        ),

      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewStockCategory(shop)),
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

