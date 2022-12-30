import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShipstationRateModel {
  String serviceName;
  String serviceCode;
  double shipmentCost;
  double otherCost;
  ShipstationRateModel({
    required this.serviceName,
    required this.serviceCode,
    required this.shipmentCost,
    required this.otherCost,
  });

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

  factory ShipstationRateModel.fromJson(String source) => ShipstationRateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '(serviceName: $serviceName, serviceCode: $serviceCode, shipmentCost: $shipmentCost, otherCost: $otherCost)';
  }
}
