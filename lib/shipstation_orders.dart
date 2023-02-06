import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';

class ShipstationOrders {
  final apiKey = ShipstationCredentials.mapleKey;
  final apiSecret = ShipstationCredentials.mapleSecret;
  final dio = Dio();

  //! shipstation has 40 requests limit in every 1 minute. DO NOT use post method for 'every' order in one function.

  Future<ShipstationModel> getOrders() async {
    final response = await dio
        .get('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders?orderStatus=awaiting_shipment&pageSize=500');

    try {
      return ShipstationModel.fromMap(response.data);
    } on DioError catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  Future<Response<dynamic>> shipstationPostFunction(Order selectedOrder) {

    return dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders/createorder', data: selectedOrder.toMap());
  }

  Future<List<ShipstationRateModel>> getFedExRate(Order order) async {
    final Map<String, dynamic> jsonFedex = {
      "carrierCode": "fedex",
      "serviceCode": null,
      "packageCode": null,
      "fromPostalCode": 75041,
      "toState": order.shipTo?.state,
      "toCountry": order.shipTo?.country,
      "toPostalCode": order.shipTo?.postalCode?.split('-')[0],
      "toCity": order.shipTo?.city,
      "weight": order.weight?.toMap(),
      "dimensions": order.dimensions?.toMap(),
      "confirmation": "delivery",
      "residential": order.shipTo?.residential,
    };

    final response =
        await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/shipments/getrates', data: jsonFedex);

    try {
      return List<ShipstationRateModel>.from(
          response.data.map<ShipstationRateModel>((e) => ShipstationRateModel.fromMap(e)));
    } on DioError catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  Future<List<ShipstationRateModel>> getUpsRate(Order order) async {
    final Map<String, dynamic> upsJson = {
      "carrierCode": "ups_walleted",
      "serviceCode": null,
      "packageCode": null,
      "fromPostalCode": 75041,
      "toState": order.shipTo?.state,
      "toCountry": order.shipTo?.country,
      "toPostalCode": order.shipTo?.postalCode,
      "toCity": order.shipTo?.city,
      "weight": order.weight?.toMap(),
      "dimensions": order.dimensions?.toMap(),
      "confirmation": "delivery",
      "residential": order.shipTo?.residential,
    };
    final response =
        await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/shipments/getrates', data: upsJson);

    try {
      return List<ShipstationRateModel>.from(
          response.data.map<ShipstationRateModel>((e) => ShipstationRateModel.fromMap(e)));
    } on DioError catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  Future<Response<dynamic>> postRates(Order selectedOrder) {
    return dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders/createorder', data: selectedOrder.toMap());
  }

  static final shipStationGetOrders = FutureProvider<ShipstationModel>((ref) => ShipstationOrders().getOrders());
}
