import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';

class EditStockCategory extends StatefulWidget {
  EditStockCategory(this.shop, this.position);
  Shop2 shop;
  int position;
  @override
  EditStockCategoryState createState() => EditStockCategoryState(shop, position);
}
class EditStockCategoryState extends State<EditStockCategory> {
  Shop2 mShop;
  int position;
  EditStockCategoryState(this.mShop, this.position);
  bool isLoading = false;
  String shopName = "";
  String shopAddress = "";
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      shopNameController.text=mShop.name;
      shopAddressController.text=mShop.address;
      shopName = mShop.name;
      shopAddress = mShop.address;
    });
    super.initState();
  }

  @override
  void dispose() {
    shopNameController.dispose();
    shopAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Shop"), ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextField(
              controller: shopNameController,
              decoration: InputDecoration(
                labelText: "Shop Name",
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
                  shopName=value;
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
                print("shopName: ${shopName}");
                print("shopAddress: ${shopAddress}");
                //Shop({this.id, this.shop_id, this.sells, this.location});

                Shop2 shop = Shop2(id:mShop.id,name:shopName, address:shopAddress, manager:mShop.manager);
                bloc.updateShop(shop, position);
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
