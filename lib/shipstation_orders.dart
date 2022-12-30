import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

class ShipstationOrders {
  final apiKey = ShipstationCredentials.key;
  final apiSecret = ShipstationCredentials.secret;
  final dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 5000));
  

  //! shipstation has 40 requests limit in every 1 minute. DO NOT use post method for 'every' order in one function.
  

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

  Future<List<ShipstationRateModel>> getRates(Map<String, dynamic> json) async {
    final response = await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/shipments/getrates', data: json);

    try {
      return List<ShipstationRateModel>.from(
          response.data.map<ShipstationRateModel>((e) => ShipstationRateModel.fromMap(e)));
    } on DioError catch (error) {
      Fluttertoast.showToast(msg: error.message.toString());
    }
    throw Exception('Failed to load orders');
  }

  static final shipStationGetOrders = FutureProvider<ShipstationModel>((ref) => ShipstationOrders().getOrders());
  static final shipStationGetRates = FutureProvider.family<List<ShipstationRateModel>, Map<String, dynamic>>(
      (ref, json) => ShipstationOrders().getRates(json));
}
