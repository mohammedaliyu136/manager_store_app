import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';

class NewShop extends StatefulWidget {
  @override
  NewShopState createState() => NewShopState();
}
class NewShopState extends State<NewShop> {
  bool isLoading = false;
  String shopName = "";
  String shopAddress = "";
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();

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
      appBar: AppBar(title: Text("Add Shop"), ),
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
                child: Text(isLoading?"Saving...":"Save", style: TextStyle(fontSize: 17, color: Colors.white),),
              ),
              onPressed: (){
                setState(() {
                  isLoading=true;
                });
                print("shopName: ${shopName}");
                print("shopAddress: ${shopAddress}");
                //Shop({this.id, this.shop_id, this.sells, this.location});
                //Shop shop = Shop(id:bloc.mShops.length+1,shop_id:shopName, location:shopAddress, sells:1234);
                Shop2 shop = Shop2(id:"0000",name:shopName, address:shopAddress, manager:bloc.manager.id);
                bloc.addShop(shop);
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
