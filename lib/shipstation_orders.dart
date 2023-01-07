import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

class ShipstationOrders {
  final apiKey = ShipstationCredentials.key;
  final apiSecret = ShipstationCredentials.secret;
  final dio = Dio();

  //! shipstation has 40 requests limit in every 1 minute. DO NOT use post method for 'every' order in one sync function.

  Future<ShipstationModel> getOrders() async {
    final response =
        await dio.get('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders?orderStatus=awaiting_shipment');

    try {
      return ShipstationModel.fromMap(response.data);
    } on DioError catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  Future<List<ShipstationRateModel>> getFedExRates(Map<String, dynamic> jsonFedex) async {
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

  Stream<List<ShipstationRateModel>> getFedExRatesStream(Map<String, dynamic> jsonFedex) async* {
    Stream.periodic(const Duration(seconds: 2))
        .asyncMap((_) => getFedExRates(jsonFedex).then((value) => print('Post sent')));

    throw Exception('Failed to load orders');
  }

  Future<List<ShipstationRateModel>> getUpsRates(Map<String, dynamic> upsJson) async {
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

  static final shipStationGetOrders = FutureProvider<ShipstationModel>((ref) => ShipstationOrders().getOrders());
}
