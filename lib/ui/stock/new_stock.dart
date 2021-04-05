import 'package:flutter/material.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';
import 'package:provider/provider.dart';

class NewStock extends StatefulWidget {
  @override
  NewStockState createState() => NewStockState();
}
class NewStockState extends State<NewStock> {
  String itemName = "";
  String price = "";
  String quantity = "";
  String shopAddress = "";
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add New Stock"), ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                labelText: "Item Name",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, .5),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  itemName=value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                labelText: "Price",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, .5),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  price=value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                labelText: "Quantity",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, .5),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  quantity=value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                labelText: "Shop address",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, .5),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(90, 0, 40, 1),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  shopAddress=value;
                });
              },
            ),
            SizedBox(height: 20,),
            RaisedButton(
              color: Color.fromRGBO(90, 0, 40, 1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Submit", style: TextStyle(fontSize: 17, color: Colors.white),),
              ),
              onPressed: (){
                //Navigator.pop(context);
                print("itemName: ${itemName}");
                print("price: ${price}");
                print("quantity: ${quantity}");
                print("shopAddress: ${shopAddress}");
                /**
                id: json['id'] as String,
                itemCategory: json['itemCategory'] as String,
                item: json['item'] as String,
                price: json['price']
                **/
                Stock stock = Stock(id:bloc.Stocks.length+1,item:itemName, quantity:int.parse(quantity), price:price);
                bloc.addStock(stock);
                Navigator.pop(context, 'Nope!');
              },
            )
          ],
        ),
      ),
    );
  }
}
