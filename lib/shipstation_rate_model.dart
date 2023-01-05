import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShipstationRateModel {
  String? serviceName;
  String? serviceCode;
  double? shipmentCost;
  double? otherCost;
  ShipstationRateModel({
    this.serviceName,
    this.serviceCode,
    this.shipmentCost,
    this.otherCost,
  });

  final apiKey = ShipstationCredentials.key;
  final apiSecret = ShipstationCredentials.secret;
  final dio = Dio();

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceName': serviceName,
      'serviceCode': serviceCode,
      'shipmentCost': shipmentCost,
      'otherCost': otherCost,
    };
  }

  factory ShipstationRateModel.fromMap(Map<String, dynamic> map) {
    return ShipstationRateModel(
      serviceName: map['serviceName'] ?? 'No service name',
      serviceCode: map['serviceCode'] ?? 'No service code',
      shipmentCost: map['shipmentCost'] ?? 0.00,
      otherCost: map['otherCost'] ?? 0.00,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipstationRateModel.fromJson(String source) =>
      ShipstationRateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '(serviceName: $serviceName, serviceCode: $serviceCode, shipmentCost: $shipmentCost, otherCost: $otherCost)';
  }
}
