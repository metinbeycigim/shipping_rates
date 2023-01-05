import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/shipstation_credentials.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShipstationModel {
  List<Order>? orders;
  ShipstationModel({
    this.orders,
  });

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orders': orders?.map((x) => x.toMap()).toList(),
    };
  }

  factory ShipstationModel.fromMap(Map<String, dynamic> map) {
    return ShipstationModel(
      orders: map['orders'] != null
          ? List<Order>.from(
              (map['orders']).map<Order?>(
                (x) => Order.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipstationModel.fromJson(String source) =>
      ShipstationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ShipstationModel(orders: $orders)';
}

class Order {
  int? orderId;
  String? orderNumber;
  String? orderDate;
  String? orderKey;
  String? createDate;
  String? modifyDate;
  String? paymentDate;
  String? orderStatus;
  String? customerNote;
  String? internalNote;
  int? customerId;
  String? customerUsername;
  ShipTo? shipTo;
  List<Item>? items;
  double? shippingAmount;
  String? customerNotes;
  String? carrierCode;
  String? serviceCode;
  String? packageCode;
  Weight? weight;
  Dimensions? dimensions;
  Order({
    this.orderId,
    this.orderNumber,
    this.orderDate,
    this.orderKey,
    this.createDate,
    this.modifyDate,
    this.paymentDate,
    this.orderStatus,
    this.customerNote,
    this.internalNote,
    this.customerId,
    this.customerUsername,
    this.shipTo,
    this.items,
    this.shippingAmount,
    this.customerNotes,
    this.carrierCode,
    this.serviceCode,
    this.packageCode,
    this.weight,
    this.dimensions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderNumber': orderNumber,
      'orderDate': orderDate,
      'orderKey': orderKey,
      'createDate': createDate,
      'modifyDate': modifyDate,
      'paymentDate': paymentDate,
      'orderStatus': orderStatus,
      'customerNote': customerNote,
      'internalNote': internalNote,
      'customerId': customerId,
      'customerUsername': customerUsername,
      'shipTo': shipTo?.toMap(),
      'items': items?.map((x) => x.toMap()).toList(),
      'shippingAmount': shippingAmount,
      'customerNotes': customerNotes,
      'carrierCode': carrierCode,
      'serviceCode': serviceCode,
      'packageCode': packageCode,
      'weight': weight?.toMap(),
      'dimensions': dimensions?.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] != null ? map['orderId'] as int : null,
      orderNumber: map['orderNumber'] != null ? map['orderNumber'] as String : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
      orderKey: map['orderKey'] != null ? map['orderKey'] as String : null,
      createDate: map['createDate'] != null ? map['createDate'] as String : null,
      modifyDate: map['modifyDate'] != null ? map['modifyDate'] as String : null,
      paymentDate: map['paymentDate'] != null ? map['paymentDate'] as String : null,
      orderStatus: map['orderStatus'] != null ? map['orderStatus'] as String : null,
      customerNote: map['customerNote'] != null ? map['customerNote'] as String : null,
      internalNote: map['internalNote'] != null ? map['internalNote'] as String : null,
      customerId: map['customerId'] != null ? map['customerId'] as int : null,
      customerUsername: map['customerUsername'] != null ? map['customerUsername'] as String : null,
      shipTo: map['shipTo'] != null ? ShipTo.fromMap(map['shipTo'] as Map<String, dynamic>) : null,
      items: map['items'] != null
          ? List<Item>.from(
              (map['items']).map<Item?>(
                (x) => Item.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      shippingAmount: map['shippingAmount'] != null ? map['shippingAmount'] as double : null,
      customerNotes: map['customerNotes'] != null ? map['customerNotes'] as String : null,
      carrierCode: map['carrierCode'] != null ? map['carrierCode'] as String : null,
      serviceCode: map['serviceCode'] != null ? map['serviceCode'] as String : null,
      packageCode: map['packageCode'] != null ? map['packageCode'] as String : null,
      weight: map['weight'] != null ? Weight.fromMap(map['weight'] as Map<String, dynamic>) : null,
      dimensions: map['dimensions'] != null ? Dimensions.fromMap(map['dimensions'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(orderId: $orderId, orderNumber: $orderNumber, orderDate: $orderDate, orderKey: $orderKey, createDate: $createDate, modifyDate: $modifyDate, paymentDate: $paymentDate, orderStatus: $orderStatus, customerNote: $customerNote, internalNote: $internalNote, customerId: $customerId, customerUsername: $customerUsername, shipTo: $shipTo, items: $items, shippingAmount: $shippingAmount, customerNotes: $customerNotes, carrierCode: $carrierCode, serviceCode: $serviceCode, packageCode: $packageCode, weight: $weight, dimensions: $dimensions)';
  }
}

class Item {
  String? sku;
  String? name;
  int? quantity;
  Weight? weight;
  Item({
    this.sku,
    this.name,
    this.quantity,
    this.weight,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sku': sku,
      'name': name,
      'quantity': quantity,
      'weight': weight?.toMap(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      sku: map['sku'] != null ? map['sku'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      weight: map['weight'] != null ? Weight.fromMap(map['weight'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(sku: $sku, name: $name, quantity: $quantity, weight: $weight)';
  }
}

class ShipTo {
  String? name;
  String? company;
  String? street1;
  String? street2;
  String? street3;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phone;
  bool? residential;
  String? addressVerified;
  ShipTo({
    this.name,
    this.company,
    this.street1,
    this.street2,
    this.street3,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.phone,
    this.residential,
    this.addressVerified,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'company': company,
      'street1': street1,
      'street2': street2,
      'street3': street3,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'phone': phone,
      'residential': residential,
      'addressVerified': addressVerified,
    };
  }

  factory ShipTo.fromMap(Map<String, dynamic> map) {
    return ShipTo(
      name: map['name'] != null ? map['name'] as String : null,
      company: map['company'] != null ? map['company'] as String : null,
      street1: map['street1'] != null ? map['street1'] as String : null,
      street2: map['street2'] != null ? map['street2'] as String : null,
      street3: map['street3'] != null ? map['street3'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      postalCode: map['postalCode'] != null ? map['postalCode'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      residential: map['residential'] != null ? map['residential'] as bool : null,
      addressVerified: map['addressVerified'] != null ? map['addressVerified'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipTo.fromJson(String source) => ShipTo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShipTo(name: $name, company: $company, street1: $street1, street2: $street2, street3: $street3, city: $city, state: $state, postalCode: $postalCode, country: $country, phone: $phone, residential: $residential, addressVerified: $addressVerified)';
  }
}

class Weight {
  double? value;
  String? units;
  Weight({
    this.value,
    this.units,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'units': units,
    };
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      value: map['value'] != null ? map['value'] as double : null,
      units: map['units'] != null ? map['units'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) => Weight.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Weight(value: $value, units: $units)';
}

class Dimensions {
  String? units;
  double? length;
  double? width;
  double? height;
  Dimensions({
    this.units,
    this.length,
    this.width,
    this.height,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'units': units,
      'length': length,
      'width': width,
      'height': height,
    };
  }

  factory Dimensions.fromMap(Map<String, dynamic> map) {
    return Dimensions(
      units: map['units'] != null ? map['units'] as String : null,
      length: map['length'] != null ? map['length'] as double : null,
      width: map['width'] != null ? map['width'] as double : null,
      height: map['height'] != null ? map['height'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dimensions.fromJson(String source) => Dimensions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Dimensions(units: $units, length: $length, width: $width, height: $height)';
  }
}
