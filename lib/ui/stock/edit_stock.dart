import 'package:flutter/material.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';
import 'package:provider/provider.dart';

class EditStock extends StatefulWidget {
  EditStock(this.stock, this.position);
  Stock stock;
  int position;
  @override
  EditStockState createState() => EditStockState(stock, position);
}
class EditStockState extends State<EditStock> {
  Stock mStock;
  int position;
  EditStockState(this.mStock, this.position);
  bool isLoading = false;
  String itemName = "";
  String price = "";
  String quantity = "";
  String shopAddress = "";
  TextEditingController itemNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      itemNameController.text=mStock.item;
      priceController.text=mStock.price;
      quantityController.text=mStock.quantity.toString();
      shopAddressController.text="4312  Veltri Drive";
      itemName = mStock.item;
      price = mStock.price;
      quantity = mStock.quantity.toString();
      shopAddress = "4312  Veltri Drive";
    });
    super.initState();
  }

  @override
  void dispose() {
    itemNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    shopAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Stock"), ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextField(
              controller: itemNameController,
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
              controller: priceController,
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
              controller: quantityController,
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
              controller: shopAddressController,
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
                child: Text(isLoading?"Updating...":"Update", style: TextStyle(fontSize: 17, color: Colors.white),),
              ),
              onPressed: (){
                setState(() {
                  isLoading=true;
                });
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
                Stock stock = Stock(id:mStock.id,item:itemName, quantity:int.parse(quantity), price:price);
                bloc.updateStock(stock, position);
                //bloc.updateStocks(stock);
                Navigator.pop(context, 'Updated successfully');
              },
            )
          ],
        ),
      ),
    );
  }
}
