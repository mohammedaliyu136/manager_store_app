import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopmanager_v21/model/manager.dart';
import 'package:flutter_shopmanager_v21/model/seller.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';
import 'package:flutter_shopmanager_v21/model/stock2.dart';
import 'package:flutter_shopmanager_v21/repository/api.dart';
import 'package:flutter_shopmanager_v21/repository/dummy_api.dart';

class BlocManager with ChangeNotifier {
  bool isLoading = false;
  List<Stock> Stocks = [];
  List<Shop> Shops = [];
  List<Shop2> shops2 = [];
  List<StockCategory2> stockCategories = [];
  List<Seller> Sellers = [];

  Manager manager;

  get mStocks => Stocks;
  get mShops => shops2;
  get mStockCategories => stockCategories;
  get mSellers => Sellers;

  setManager(manager){
    this.manager = manager;
  }

  setStocks(stock){
    Stocks.add(stock);
    notifyListeners();
  }
  setShop(shop){
    Shops.add(shop);
    notifyListeners();
  }


  BlocManager() {}

  void getStocks()async{
    isLoading=true;
    Stocks.length==0?Stocks = await getStockAPI():'';
    isLoading=false;
    notifyListeners();
  }
  void getStocks2()async{
    isLoading=true;
    await getStocksAPI('ajisaq', '1234567890').then((res){
      var body = json.decode(res.body);
      if(body['status']=="Ok"){
        for(var i=0; i<body['data'].length; i++){
          print(body['data'][i]);
          /*
          Stock212(id:body['data'][i]['id'],
                 item:body['data'][i]['item'],
             quantity:body['data'][i]['quantity'],
                price:body['data'][i]['price'],
                 shop:Shop1(id:body['data'][i]['shop']['id'],name:body['data'][i]['shop']['name'],address:body['data'][i]['shop']['address']),
             category:itemCategory(id:body['data'][i]['category']['id'],name:body['data'][i]['category']['name'],description:body['data'][i]['category']['description'],));
           */
        }
      }
    });
    isLoading=false;
    notifyListeners();
  }

  void updateStock(stock, position)async{
    isLoading=true;
    notifyListeners();
    Stocks[position].update(stock.item, stock.quantity, stock.price);
    isLoading=false;
    notifyListeners();
  }
  void deleteStock(stock, position)async{
    isLoading=true;
    notifyListeners();
    Stocks.removeAt(position);
    isLoading=false;
    notifyListeners();
  }
  void addStock(stock)async{
    isLoading=true;
    notifyListeners();
    int id = stock.id;
    Stocks.add(Stock(id:Stocks.length+1,item:stock.item, quantity:stock.quantity, price:stock.price));
    isLoading=false;
    notifyListeners();
  }

  void getSells(){}
  void getSellers2(){}

  void getShops()async{
    isLoading=true;
    //Shops.length==0?Shops = await getShopAPI():'';
    String apiUser = 'ajisaq';
    String apiKey = '1234567890';
    //Shops.length==0?Shops = await getShopsAPI(apiUser, apiKey):'';
    var sh = await getShopsAPI(apiUser, apiKey);
    var body = json.decode(sh.body);
    print(body);
    print(body['data'][0]);
    Shop2(id:body['data'][0]['id'], name:body['data'][0]['name'], manager:'l', address: body['data'][0]['address']);
    print(Shop2(id:body['data'][0]['id'], name:body['data'][0]['name'], manager:'l', address: body['data'][0]['address']));
    if(body['status']=="Ok") {
      shops2 = [];
      for (var i = 0; i < body['data'].length; i++) {
        Shop2 shop = Shop2(
            id:body['data'][i]['id'],
            name:body['data'][i]['name'], manager:'l',
            address: body['data'][i]['address']);
        shops2.add(shop);
      }
    }
    //id: 551901e2-79a3-4d10-851d-08b07575bcfa,
    //name: Kijana,
    //address: 10 Plot 6 Galadima aminu way yola,
    //stockCategory: {nextToken: null},
    //manager: {id: tishaq, name: Ahmed T ishaq, address: ajisaq, phone: 07030100804, email: ahmedt@ajisaq.com, username: tishaq, password: pass1234}, sellers: {nextToken: null}, stocks: {nextToken: null
    isLoading=false;
    notifyListeners();
  }
  void updateShop(shop, position)async{
    isLoading=true;
    Shops[position].update(shop.shop_id, shop.sells, shop.location);
    isLoading=false;
    notifyListeners();
  }
  void addShop(shop)async{
    isLoading=true;
    //Shops.add(shop);
    String apiUser = 'ajisaq';
    String apiKey = '1234567890';
    var sh = await addShopsAPI(apiUser, apiKey, shop);
    var body = json.decode(sh.body);
    if(body['status']=="Ok") {
      Shop2 shop = Shop2(
          id:body['data']['id'],
          name:body['data']['name'], manager:'l',
          address: body['data']['address']);
      shops2.add(shop);
    }else{
      print("????????????????????????????");
      print(body);
    }
    isLoading=false;
    notifyListeners();
  }
  void deleteShop(shop, position)async{
    isLoading=true;
    print("deleting: $position");
    //Shops.removeAt(position);
    String apiUser = 'ajisaq';
    String apiKey = '1234567890';
    var sh = await deleteShopAPI(apiUser, apiKey, shop);
    var body = json.decode(sh.body);
    if(body['status']=="Ok") {
      shops2.removeAt(position);
    }else{
      print("????????????????????????????");
      print(body);
    }
    isLoading=false;
    notifyListeners();
  }

  //stock category
  void getStockCategories()async{
    isLoading=true;
    //Shops.length==0?Shops = await getShopAPI():'';
    String apiUser = 'ajisaq';
    String apiKey = '1234567890';
    //Shops.length==0?Shops = await getShopsAPI(apiUser, apiKey):'';
    var sh = await getStockCategoriesAPI(apiUser, apiKey);
    var body = json.decode(sh.body);
    print(body);
    if(body['status']=="Ok") {
      shops2 = [];
      for (var i = 0; i < body['data'].length; i++) {
        StockCategory2 stockCategory = StockCategory2(
            id:body['data'][i]['id'],
            name:body['data'][i]['name'],
            description: body['data'][i]['description'],
            shop: Shop2(id: body['data'][i]['shop']['id'],
                      name:body['data'][i]['shop']['name'],
                   manager: '',
                   address: body['data'][i]['shop']['address'])
        );
        stockCategories.add(stockCategory);
      }
    }
    //id: 551901e2-79a3-4d10-851d-08b07575bcfa,
    //name: Kijana,
    //address: 10 Plot 6 Galadima aminu way yola,
    //stockCategory: {nextToken: null},
    //manager: {id: tishaq, name: Ahmed T ishaq, address: ajisaq, phone: 07030100804, email: ahmedt@ajisaq.com, username: tishaq, password: pass1234}, sellers: {nextToken: null}, stocks: {nextToken: null
    isLoading=false;
    notifyListeners();
  }
  void addStockCategory(stockCategory)async{
    isLoading=true;
    //Shops.add(shop);
    String apiUser = 'ajisaq';
    String apiKey = '1234567890';
    var sh = await addStockCategoryAPI(apiUser, apiKey, stockCategory);
    var body = json.decode(sh.body);
    if(body['status']=="Ok") {
      StockCategory2 stockCategory = StockCategory2(
          id:body['data']['id'],
          name:body['data']['name'],
          description: body['data']['description'],
          shop: Shop2(id: body['data']['shop']['id'],
              name:body['data']['shop']['name'],
              manager: '',
              address: body['data']['shop']['address'])
      );
      stockCategories.add(stockCategory);
    }else{
      print("????????????????????????????");
      print(body);
    }
    isLoading=false;
    notifyListeners();
  }
  void deleteStockCategory(stockCategory, position)async{
    isLoading=true;
    print("deleting: $position");
    //Shops.removeAt(position);
    String apiUser = 'ajisaq';
    String apiKey = '1234567890';
    var sh = await deleteStockCategoryAPI(apiUser, apiKey, stockCategory);
    var body = json.decode(sh.body);
    if(body['status']=="Ok") {
      stockCategories.removeAt(position);
    }else{
      print("????????????????????????????");
      print(body);
    }
    isLoading=false;
    notifyListeners();
  }

  //seller
  void getSellers()async{
    isLoading=true;
    Sellers.length==0?Sellers = await getSellerAPI():'';
    isLoading=false;
    notifyListeners();
  }
  void updateSeller(shop, position)async{
    isLoading=true;
    Sellers[position].update(shop.name, shop.sells, shop.shopID);
    isLoading=false;
    notifyListeners();
  }
  void addSeller(shop)async{
    isLoading=true;
    Sellers.add(shop);
    isLoading=false;
    notifyListeners();
  }
  void deleteSeller(shop, position)async{
    isLoading=true;
    Sellers.removeAt(position);
    isLoading=false;
    notifyListeners();
  }
}