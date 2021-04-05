
import 'package:flutter_shopmanager_v21/model/seller.dart';
import 'package:flutter_shopmanager_v21/model/shop.dart';
import 'package:flutter_shopmanager_v21/model/stock.dart';

import 'data/sells.dart';
import 'data/stocks.dart';
import 'data/shops.dart';

Future<List<Stock>> getStockAPI() async {
  var data = stocks;
  return data.map<Stock>((json) => Stock.fromJson(json)).toList();
}

Future<List<Shop>> getShopAPI() async {
  var data = shops;
  return data.map<Shop>((json) => Shop.fromJson(json)).toList();
}

Future<List<Seller>> getSellerAPI() async {
  var data = sellers_data;
  return data.map<Seller>((json) => Seller.fromJson(json)).toList();
}