import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/seller.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';

class EditSeller extends StatefulWidget {
  EditSeller(this.seller, this.position);
  Seller seller;
  int position;
  @override
  EditSellerState createState() => EditSellerState(seller, position);
}
class EditSellerState extends State<EditSeller> {
  Seller mSeller;
  int position;
  EditSellerState(this.mSeller, this.position);
  bool isLoading = false;
  String sellerName = "";
  String shop = "";
  String sells = "";
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  TextEditingController sellsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      sellerNameController.text=mSeller.name;
      shopController.text=mSeller.shopID;
      sellsController.text=mSeller.sells.toString();
      sellerName = mSeller.name;
      shop = mSeller.shopID;
      sells = mSeller.sells.toString();
    });
    super.initState();
  }

  @override
  void dispose() {
    sellerNameController.dispose();
    shopController.dispose();
    sellsController.dispose();
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
              controller: sellerNameController,
              decoration: InputDecoration(
                labelText: "Seller Name",
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
            TextField(
              controller: sellsController,
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
                  sells=value;
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
                print("sellerName: ${sellerName}");
                print("shop: ${shop}");
                print("sells: ${sells}");
                //Shop({this.id, this.shop_id, this.sells, this.location}); this.id, this.name, this.sells, this.shopID
                Seller seller = Seller(id:mSeller.id,name:sellerName, sells:int.parse(sells), shopID:shop);
                bloc.updateShop(seller, position);
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
