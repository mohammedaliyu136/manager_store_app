import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/ui/seller/seller_list.dart';
import 'package:flutter_shopmanager_v21/ui/shop/shops_page.dart';
import 'package:flutter_shopmanager_v21/ui/stock/stocks_page.dart';

import '../PieChartSample2.dart';
import 'new_seller.dart';

class SellersPage extends StatefulWidget {
  @override
  SellerPageState createState() => SellerPageState();
}

class SellerPageState extends State<SellersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<TableRow> sellerList = [];
  void setSellers(sellers){
    sellerList=[];
    for(var i=0; i<sellers.length; i++){
      if(i<5){
        sellerList.add(
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(sellers[i].name, style: TextStyle(fontSize: 16,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(sellers[i].shopID, style: TextStyle(fontSize: 16,),),
              ),
            ])
        );
        sellerList.add(
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

    print("99999999999999999");
    !bloc.isLoading?setState((){setSellers(bloc.mSellers);}):'';

    return !bloc.isLoading?Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("SELLERS"),
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
              child: Center(child: Text('Shop Manager', style: TextStyle(color: Colors.white, fontSize: 30, ),)),
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
            Container(
              color: Color.fromRGBO(90, 0, 40, 1),
              child: ListTile(
                leading: Icon(Icons.storage, color: Colors.white, size: 30,),
                title: Text('Sellers', style: TextStyle(fontSize: 20, color: Colors.white)),
                onTap: () {
                },
              ),
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
            ListTile(
              leading: Icon(Icons.store, color: Color.fromRGBO(90, 0, 40, 1), size: 30,),
              title: Text('Shops', style: TextStyle(fontSize: 20, color: Color.fromRGBO(90, 0, 40, 1)),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopsPage()),
                );
              },
            ),
            SizedBox(height: 1, child: Container(color: Color.fromRGBO(90, 0, 40, 1),),),
          ],
        ),
      ),
      body: ListView(children: [
        Container(
          color: Color.fromRGBO(90, 0, 40, 1),
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width * 1,
          child: PieChartSample2(),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.only(top:18.0, left: 18.0, right: 18, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("SELLERS", style: TextStyle(fontSize: 18),),
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellerList2()),
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
            columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.4),},
            children: [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: Text("Seller Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Center(child: Text("Shop", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)),
                    ),
                  ]),

            ],),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0, right: 8.0, bottom: 8.0),
          child: Table(
            columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.4),},
            children: sellerList
          ),
        ),

      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewSeller()),
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

