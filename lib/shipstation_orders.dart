import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';

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

  static final shipStationGetOrders = FutureProvider<ShipstationModel>((ref) => ShipstationOrders().getOrders());
}
