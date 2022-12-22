import 'dart:convert';

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
      serviceName: map['serviceName'] != null ? map['serviceName'] as String : null,
      serviceCode: map['serviceCode'] != null ? map['serviceCode'] as String : null,
      shipmentCost: map['shipmentCost'] != null ? map['shipmentCost'] as double : null,
      otherCost: map['otherCost'] != null ? map['otherCost'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipstationRateModel.fromJson(String source) => ShipstationRateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
