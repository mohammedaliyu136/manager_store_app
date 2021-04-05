import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shopmanager_v21/bloc/bloc.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';

class NewStockCategory extends StatefulWidget {
  Shop2 shop;
  NewStockCategory(this.shop);
  @override
  NewStockCategoryState createState() => NewStockCategoryState(shop);
}
class NewStockCategoryState extends State<NewStockCategory> {
  Shop2 shop;
  NewStockCategoryState(this.shop);
  bool isLoading = false;
  String name = "";
  String description = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<BlocManager>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Add Stock Category"), ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
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
                  name=value;
                });
              },
            ),
            SizedBox(height: 20,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
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
                  description=value;
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
                print("Name: ${name}");
                print("Description: ${description}");
                //Shop({this.id, this.shop_id, this.sells, this.location});
                //Shop shop = Shop(id:bloc.mShops.length+1,shop_id:shopName, location:shopAddress, sells:1234);
                //Shop2 shop = Shop2(id:"0000",name:shopName, address:shopAddress, manager:bloc.manager.id);
                print(shop.name+shop.address+shop.manager);
                //StockCategory2 stockCategory = StockCategory2(id:'', name: name, description: description, shop:shop);
                //bloc.addStockCategory(stockCategory);
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
