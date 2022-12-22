import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

class ShipstationOrders {
  final apiKey = ShipstationCredentials.key;
  final apiSecret = ShipstationCredentials.secret;
  final dio = Dio();

  Future<ShipstationModel> getOrders() async {
    final response =
        await dio.get('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders?orderStatus=awaiting_shipment');

    try {
      return ShipstationModel.fromMap(response.data);
    } on PlatformException catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  Future<List<ShipstationRateModel>> getRates(json) async {
    final response = await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/shipments/getrates', data: json);
    print(response.data);
    try {
      return List<ShipstationRateModel>.from((response.data as List).map((e) => ShipstationRateModel.fromMap(e)));
    } on PlatformException catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  static final shipStationGetOrders = FutureProvider<ShipstationModel>((ref) => ShipstationOrders().getOrders());
  static final shipStationGetRates = FutureProvider.family<List<ShipstationRateModel>, Map<String, dynamic>>(
      (ref, json) => ShipstationOrders().getRates(json));
}
