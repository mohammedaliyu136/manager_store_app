import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/seller.dart';

class NewSeller extends StatefulWidget {
  @override
  NewSellerState createState() => NewSellerState();
}
class NewSellerState extends State<NewSeller> {
  bool isLoading = false;
  String sellerName = "";
  String shop = "";
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController shopController = TextEditingController();

  @override
  void dispose() {
    sellerNameController.dispose();
    shopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add Seller"), ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextField(
              controller: sellerNameController,
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
                  sellerName=value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              controller: shopController,
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
                  shop=value;
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
                print("sellerName: ${sellerName}");
                print("shop: ${shop}");
                Seller seller = Seller(id:bloc.mSellers.length+1,name:sellerName, shopID:shop, sells:1234);
                bloc.addSeller(seller);
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
