import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ShipstationModel {
  List<Order>? orders;
  ShipstationModel({
    this.orders,
  });

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
  String? orderKey;
  String? orderDate;
  String? createDate;
  String? modifyDate;
  String? paymentDate;
  String? shipByDate;
  String? orderStatus;
  int? customerId;
  String? customerUsername;
  String? customerEmail;
  Address? billTo;
  Address? shipTo;
  List<Item>? items;
  int? orderTotal;
  int? amountPaid;
  double? taxAmount;
  int? shippingAmount;
  String? customerNotes;
  String? internalNotes;
  bool? gift;
  String? giftMessage;
  String? paymentMethod;
  String? requestedShippingService;
  String? carrierCode;
  String? serviceCode;
  String? packageCode;
  String? confirmation;
  String? shipDate;
  String? holdUntilDate;
  Weight? weight;
  Dimensions? dimensions;
  InsuranceOptions? insuranceOptions;
  InternationalOptions? internationalOptions;
  AdvancedOptions? advancedOptions;
  List<int>? tagIds;
  String? userId;
  bool? externallyFulfilled;
  String? externallyFulfilledBy;
  String? externallyFulfilledById;
  String? externallyFulfilledByName;
  String? labelMessages;
  ShipstationRateModel? cheapRate;

  Order(
    this.orderId,
    this.orderNumber,
    this.orderKey,
    this.orderDate,
    this.createDate,
    this.modifyDate,
    this.paymentDate,
    this.shipByDate,
    this.orderStatus,
    this.customerId,
    this.customerUsername,
    this.customerEmail,
    this.billTo,
    this.shipTo,
    this.items,
    this.orderTotal,
    this.amountPaid,
    this.taxAmount,
    this.shippingAmount,
    this.customerNotes,
    this.internalNotes,
    this.gift,
    this.giftMessage,
    this.paymentMethod,
    this.requestedShippingService,
    this.carrierCode,
    this.serviceCode,
    this.packageCode,
    this.confirmation,
    this.shipDate,
    this.holdUntilDate,
    this.weight,
    this.dimensions,
    this.insuranceOptions,
    this.internationalOptions,
    this.advancedOptions,
    this.tagIds,
    this.userId,
    this.externallyFulfilled,
    this.externallyFulfilledBy,
    this.externallyFulfilledById,
    this.externallyFulfilledByName,
    this.labelMessages,
    this.cheapRate,
  );

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'orderNumber': orderNumber,
      'orderKey': orderKey,
      'orderDate': orderDate,
      'createDate': createDate,
      'modifyDate': modifyDate,
      'paymentDate': paymentDate,
      'shipByDate': shipByDate,
      'orderStatus': orderStatus,
      'customerId': customerId,
      'customerUsername': customerUsername,
      'customerEmail': customerEmail,
      'billTo': billTo?.toMap(),
      'shipTo': shipTo?.toMap(),
      'items': items?.map((x) => x.toMap()).toList(),
      'orderTotal': orderTotal,
      'amountPaid': amountPaid,
      'taxAmount': taxAmount,
      'shippingAmount': shippingAmount,
      'customerNotes': customerNotes,
      'internalNotes': internalNotes,
      'gift': gift,
      'giftMessage': giftMessage,
      'paymentMethod': paymentMethod,
      'requestedShippingService': requestedShippingService,
      'carrierCode': carrierCode,
      'serviceCode': serviceCode,
      'packageCode': packageCode,
      'confirmation': confirmation,
      'shipDate': shipDate,
      'holdUntilDate': holdUntilDate,
      'weight': weight?.toMap(),
      'dimensions': dimensions?.toMap(),
      'insuranceOptions': insuranceOptions?.toMap(),
      'internationalOptions': internationalOptions?.toMap(),
      'advancedOptions': advancedOptions?.toMap(),
      'tagIds': tagIds,
      'userId': userId,
      'externallyFulfilled': externallyFulfilled,
      'externallyFulfilledBy': externallyFulfilledBy,
      'externallyFulfilledById': externallyFulfilledById,
      'externallyFulfilledByName': externallyFulfilledByName,
      'labelMessages': labelMessages,
      'theCheapestRate': cheapRate?.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      map['orderId']?.toInt(),
      map['orderNumber'],
      map['orderKey'],
      map['orderDate'],
      map['createDate'],
      map['modifyDate'],
      map['paymentDate'],
      map['shipByDate'],
      map['orderStatus'],
      map['customerId']?.toInt(),
      map['customerUsername'],
      map['customerEmail'],
      map['billTo'] != null ? Address.fromMap(map['billTo']) : null,
      map['shipTo'] != null ? Address.fromMap(map['shipTo']) : null,
      map['items'] != null
          ? List<Item>.from(map['items']?.map((x) => Item.fromMap(x)))
          : null,
      map['orderTotal']?.toInt(),
      map['amountPaid']?.toInt(),
      map['taxAmount']?.toDouble(),
      map['shippingAmount']?.toInt(),
      map['customerNotes'],
      map['internalNotes'],
      map['gift'],
      map['giftMessage'],
      map['paymentMethod'],
      map['requestedShippingService'],
      map['carrierCode'],
      map['serviceCode'],
      map['packageCode'],
      map['confirmation'],
      map['shipDate'],
      map['holdUntilDate'],
      map['weight'] != null ? Weight.fromMap(map['weight']) : null,
      map['dimensions'] != null ? Dimensions.fromMap(map['dimensions']) : null,
      map['insuranceOptions'] != null
          ? InsuranceOptions.fromMap(map['insuranceOptions'])
          : null,
      map['internationalOptions'] != null
          ? InternationalOptions.fromMap(map['internationalOptions'])
          : null,
      map['advancedOptions'] != null
          ? AdvancedOptions.fromMap(map['advancedOptions'])
          : null,
      map['tagIds'] != null ? List<int>.from(map['tagIds']) : [0],
      map['userId'],
      map['externallyFulfilled'],
      map['externallyFulfilledBy'],
      map['externallyFulfilledById'],
      map['externallyFulfilledByName'],
      map['labelMessages'],
      map['theCheapestRate'] != null
          ? ShipstationRateModel.fromMap(map['rates'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  Order copyWith({
    int? orderId,
    String? orderNumber,
    String? orderKey,
    String? orderDate,
    String? createDate,
    String? modifyDate,
    String? paymentDate,
    String? shipByDate,
    String? orderStatus,
    int? customerId,
    String? customerUsername,
    String? customerEmail,
    Address? billTo,
    Address? shipTo,
    List<Item>? items,
    int? orderTotal,
    int? amountPaid,
    double? taxAmount,
    int? shippingAmount,
    String? customerNotes,
    String? internalNotes,
    bool? gift,
    String? giftMessage,
    String? paymentMethod,
    String? requestedShippingService,
    String? carrierCode,
    String? serviceCode,
    String? packageCode,
    String? confirmation,
    String? shipDate,
    String? holdUntilDate,
    Weight? weight,
    Dimensions? dimensions,
    InsuranceOptions? insuranceOptions,
    InternationalOptions? internationalOptions,
    AdvancedOptions? advancedOptions,
    List<int>? tagIds,
    String? userId,
    bool? externallyFulfilled,
    String? externallyFulfilledBy,
    String? externallyFulfilledById,
    String? externallyFulfilledByName,
    String? labelMessages,
    ShipstationRateModel? theCheapestRate,
  }) {
    return Order(
      orderId ?? this.orderId,
      orderNumber ?? this.orderNumber,
      orderKey ?? this.orderKey,
      orderDate ?? this.orderDate,
      createDate ?? this.createDate,
      modifyDate ?? this.modifyDate,
      paymentDate ?? this.paymentDate,
      shipByDate ?? this.shipByDate,
      orderStatus ?? this.orderStatus,
      customerId ?? this.customerId,
      customerUsername ?? this.customerUsername,
      customerEmail ?? this.customerEmail,
      billTo ?? this.billTo,
      shipTo ?? this.shipTo,
      items ?? this.items,
      orderTotal ?? this.orderTotal,
      amountPaid ?? this.amountPaid,
      taxAmount ?? this.taxAmount,
      shippingAmount ?? this.shippingAmount,
      customerNotes ?? this.customerNotes,
      internalNotes ?? this.internalNotes,
      gift ?? this.gift,
      giftMessage ?? this.giftMessage,
      paymentMethod ?? this.paymentMethod,
      requestedShippingService ?? this.requestedShippingService,
      carrierCode ?? this.carrierCode,
      serviceCode ?? this.serviceCode,
      packageCode ?? this.packageCode,
      confirmation ?? this.confirmation,
      shipDate ?? this.shipDate,
      holdUntilDate ?? this.holdUntilDate,
      weight ?? this.weight,
      dimensions ?? this.dimensions,
      insuranceOptions ?? this.insuranceOptions,
      internationalOptions ?? this.internationalOptions,
      advancedOptions ?? this.advancedOptions,
      tagIds ?? this.tagIds,
      userId ?? this.userId,
      externallyFulfilled ?? this.externallyFulfilled,
      externallyFulfilledBy ?? this.externallyFulfilledBy,
      externallyFulfilledById ?? this.externallyFulfilledById,
      externallyFulfilledByName ?? this.externallyFulfilledByName,
      labelMessages ?? this.labelMessages,
      theCheapestRate ?? cheapRate,
    );
  }

  @override
  String toString() {
    return 'Order(orderId: $orderId, orderNumber: $orderNumber, orderKey: $orderKey, orderDate: $orderDate, createDate: $createDate, modifyDate: $modifyDate, paymentDate: $paymentDate, shipByDate: $shipByDate, orderStatus: $orderStatus, customerId: $customerId, customerUsername: $customerUsername, customerEmail: $customerEmail, billTo: $billTo, shipTo: $shipTo, items: $items, orderTotal: $orderTotal, amountPaid: $amountPaid, taxAmount: $taxAmount, shippingAmount: $shippingAmount, customerNotes: $customerNotes, internalNotes: $internalNotes, gift: $gift, giftMessage: $giftMessage, paymentMethod: $paymentMethod, requestedShippingService: $requestedShippingService, carrierCode: $carrierCode, serviceCode: $serviceCode, packageCode: $packageCode, confirmation: $confirmation, shipDate: $shipDate, holdUntilDate: $holdUntilDate, weight: $weight, dimensions: $dimensions, insuranceOptions: $insuranceOptions, internationalOptions: $internationalOptions, advancedOptions: $advancedOptions, tagIds: $tagIds, userId: $userId, externallyFulfilled: $externallyFulfilled, externallyFulfilledBy: $externallyFulfilledBy, externallyFulfilledById: $externallyFulfilledById, externallyFulfilledByName: $externallyFulfilledByName, labelMessages: $labelMessages, theCheapestRate: $cheapRate)';
  }
}

class Address {
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
  Address({
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
    return {
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

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      name: map['name'],
      company: map['company'],
      street1: map['street1'],
      street2: map['street2'],
      street3: map['street3'],
      city: map['city'],
      state: map['state'],
      postalCode: map['postalCode'],
      country: map['country'],
      phone: map['phone'],
      residential: map['residential'],
      addressVerified: map['addressVerified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  Address copyWith({
    String? name,
    String? company,
    String? street1,
    String? street2,
    String? street3,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    String? phone,
    bool? residential,
    String? addressVerified,
  }) {
    return Address(
      name: name ?? this.name,
      company: company ?? this.company,
      street1: street1 ?? this.street1,
      street2: street2 ?? this.street2,
      street3: street3 ?? this.street3,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      residential: residential ?? this.residential,
      addressVerified: addressVerified ?? this.addressVerified,
    );
  }
}

class Item {
  int? orderItemId;
  String? lineItemKey;
  String? sku;
  String? name;
  String? imageUrl;
  Weight? weight;
  int? quantity;
  int? unitPrice;
  double? taxAmount;
  int? shippingAmount;
  String? warehouseLocation;
  ItemOption? options;
  int? productId;
  String? fulfillmentSku;
  bool? adjustment;
  String? upc;
  String? createDate;
  String? modifyDate;
  Item({
    this.orderItemId,
    this.lineItemKey,
    this.sku,
    this.name,
    this.imageUrl,
    this.weight,
    this.quantity,
    this.unitPrice,
    this.taxAmount,
    this.shippingAmount,
    this.warehouseLocation,
    this.productId,
    this.fulfillmentSku,
    this.adjustment,
    this.upc,
    this.createDate,
    this.modifyDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderItemId': orderItemId,
      'lineItemKey': lineItemKey,
      'sku': sku,
      'name': name,
      'imageUrl': imageUrl,
      'weight': weight?.toMap(),
      'quantity': quantity,
      'unitPrice': unitPrice,
      'taxAmount': taxAmount,
      'shippingAmount': shippingAmount,
      'warehouseLocation': warehouseLocation,
      'productId': productId,
      'fulfillmentSku': fulfillmentSku,
      'adjustment': adjustment,
      'upc': upc,
      'createDate': createDate,
      'modifyDate': modifyDate,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      orderItemId: map['orderItemId']?.toInt(),
      lineItemKey: map['lineItemKey'],
      sku: map['sku'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      weight: map['weight'] != null ? Weight.fromMap(map['weight']) : null,
      quantity: map['quantity']?.toInt(),
      unitPrice: map['unitPrice']?.toInt(),
      taxAmount: map['taxAmount']?.toDouble(),
      shippingAmount: map['shippingAmount']?.toInt(),
      warehouseLocation: map['warehouseLocation'],
      productId: map['productId']?.toInt(),
      fulfillmentSku: map['fulfillmentSku'],
      adjustment: map['adjustment'],
      upc: map['upc'],
      createDate: map['createDate'],
      modifyDate: map['modifyDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));
}

class ItemOption {
  String? name;
  String? value;
  ItemOption({
    this.name,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory ItemOption.fromMap(Map<String, dynamic> map) {
    return ItemOption(
      name: map['name'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOption.fromJson(String source) =>
      ItemOption.fromMap(json.decode(source));
}

class Weight {
  double? value;
  String? units;
  int? weightUnits;
  Weight({
    this.value,
    this.units,
    this.weightUnits,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'units': units,
      'weightUnits': weightUnits,
    };
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      value: map['value']?.toDouble(),
      units: map['units'],
      weightUnits: map['weightUnits']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) => Weight.fromMap(json.decode(source));

  @override
  String toString() =>
      'Weight(value: $value, units: $units, weightUnits: $weightUnits)';
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
    return {
      'units': units,
      'length': length,
      'width': width,
      'height': height,
    };
  }

  factory Dimensions.fromMap(Map<String, dynamic> map) {
    return Dimensions(
      units: map['units'],
      length: map['length']?.toDouble(),
      width: map['width']?.toDouble(),
      height: map['height']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Dimensions.fromJson(String source) =>
      Dimensions.fromMap(json.decode(source));
}

class InsuranceOptions {
  String? provider;
  bool? insureShipment;
  double? insuredValue;
  InsuranceOptions({
    this.provider,
    this.insureShipment,
    this.insuredValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'provider': provider,
      'insureShipment': insureShipment,
      'insuredValue': insuredValue,
    };
  }

  factory InsuranceOptions.fromMap(Map<String, dynamic> map) {
    return InsuranceOptions(
      provider: map['provider'],
      insureShipment: map['insureShipment'],
      insuredValue: map['insuredValue']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory InsuranceOptions.fromJson(String source) =>
      InsuranceOptions.fromMap(json.decode(source));
}

class InternationalOptions {
  String? contents;
  CustomsItem? customsItem;
  String? nondelivery;
  InternationalOptions({
    this.contents,
    this.customsItem,
    this.nondelivery,
  });

  Map<String, dynamic> toMap() {
    return {
      'contents': contents,
      'customsItem': customsItem?.toMap(),
      'nondelivery': nondelivery,
    };
  }

  factory InternationalOptions.fromMap(Map<String, dynamic> map) {
    return InternationalOptions(
      contents: map['contents'],
      customsItem: map['customsItem'] != null
          ? CustomsItem.fromMap(map['customsItem'])
          : null,
      nondelivery: map['nondelivery'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InternationalOptions.fromJson(String source) =>
      InternationalOptions.fromMap(json.decode(source));
}

class CustomsItem {
  String? customsItemId;
  String? description;
  int? quantity;
  double? value;
  String? harmonizedTariffCode;
  String? countryOfOrigin;
  CustomsItem({
    this.customsItemId,
    this.description,
    this.quantity,
    this.value,
    this.harmonizedTariffCode,
    this.countryOfOrigin,
  });

  Map<String, dynamic> toMap() {
    return {
      'customsItemId': customsItemId,
      'description': description,
      'quantity': quantity,
      'value': value,
      'harmonizedTariffCode': harmonizedTariffCode,
      'countryOfOrigin': countryOfOrigin,
    };
  }

  factory CustomsItem.fromMap(Map<String, dynamic> map) {
    return CustomsItem(
      customsItemId: map['customsItemId'],
      description: map['description'],
      quantity: map['quantity']?.toInt(),
      value: map['value']?.toDouble(),
      harmonizedTariffCode: map['harmonizedTariffCode'],
      countryOfOrigin: map['countryOfOrigin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomsItem.fromJson(String source) =>
      CustomsItem.fromMap(json.decode(source));
}

class AdvancedOptions {
  int? warehouseId;
  bool? nonMachinable;
  bool? saturdayDelivery;
  bool? containsAlcohol;
  bool? mergedOrSplit;
  List<int>? mergedIds;
  int? parentId;
  int? storeId;
  String? customField1;
  String? customField2;
  String? customField3;
  String? source;
  String? billToParty;
  String? billToAccount;
  String? billToPostalCode;
  String? billToCountryCode;
  int? billToMyOtherAccount;
  AdvancedOptions({
    this.warehouseId,
    this.nonMachinable,
    this.saturdayDelivery,
    this.containsAlcohol,
    this.mergedOrSplit,
    this.mergedIds,
    this.parentId,
    this.storeId,
    this.customField1,
    this.customField2,
    this.customField3,
    this.source,
    this.billToParty,
    this.billToAccount,
    this.billToPostalCode,
    this.billToCountryCode,
    this.billToMyOtherAccount,
  });

  Map<String, dynamic> toMap() {
    return {
      'warehouseId': warehouseId,
      'nonMachinable': nonMachinable,
      'saturdayDelivery': saturdayDelivery,
      'containsAlcohol': containsAlcohol,
      'mergedOrSplit': mergedOrSplit,
      'mergedIds': mergedIds,
      'parentId': parentId,
      'storeId': storeId,
      'customField1': customField1,
      'customField2': customField2,
      'customField3': customField3,
      'source': source,
      'billToParty': billToParty,
      'billToAccount': billToAccount,
      'billToPostalCode': billToPostalCode,
      'billToCountryCode': billToCountryCode,
      'billToMyOtherAccount': billToMyOtherAccount,
    };
  }

  factory AdvancedOptions.fromMap(Map<String, dynamic> map) {
    return AdvancedOptions(
      warehouseId: map['warehouseId']?.toInt(),
      nonMachinable: map['nonMachinable'],
      saturdayDelivery: map['saturdayDelivery'],
      containsAlcohol: map['containsAlcohol'],
      mergedOrSplit: map['mergedOrSplit'],
      mergedIds: List<int>.from(map['mergedIds']),
      parentId: map['parentId']?.toInt(),
      storeId: map['storeId']?.toInt(),
      customField1: map['customField1'],
      customField2: map['customField2'],
      customField3: map['customField3'],
      source: map['source'],
      billToParty: map['billToParty'],
      billToAccount: map['billToAccount'],
      billToPostalCode: map['billToPostalCode'],
      billToCountryCode: map['billToCountryCode'],
      billToMyOtherAccount: map['billToMyOtherAccount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvancedOptions.fromJson(String source) =>
      AdvancedOptions.fromMap(json.decode(source));

  AdvancedOptions copyWith({
    int? warehouseId,
    bool? nonMachinable,
    bool? saturdayDelivery,
    bool? containsAlcohol,
    bool? mergedOrSplit,
    List<int>? mergedIds,
    int? parentId,
    int? storeId,
    String? customField1,
    String? customField2,
    String? customField3,
    String? source,
    String? billToParty,
    String? billToAccount,
    String? billToPostalCode,
    String? billToCountryCode,
    int? billToMyOtherAccount,
  }) {
    return AdvancedOptions(
      warehouseId: warehouseId ?? this.warehouseId,
      nonMachinable: nonMachinable ?? this.nonMachinable,
      saturdayDelivery: saturdayDelivery ?? this.saturdayDelivery,
      containsAlcohol: containsAlcohol ?? this.containsAlcohol,
      mergedOrSplit: mergedOrSplit ?? this.mergedOrSplit,
      mergedIds: mergedIds ?? this.mergedIds,
      parentId: parentId ?? this.parentId,
      storeId: storeId ?? this.storeId,
      customField1: customField1 ?? this.customField1,
      customField2: customField2 ?? this.customField2,
      customField3: customField3 ?? this.customField3,
      source: source ?? this.source,
      billToParty: billToParty ?? this.billToParty,
      billToAccount: billToAccount ?? this.billToAccount,
      billToPostalCode: billToPostalCode ?? this.billToPostalCode,
      billToCountryCode: billToCountryCode ?? this.billToCountryCode,
      billToMyOtherAccount: billToMyOtherAccount ?? this.billToMyOtherAccount,
    );
  }
}

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
    return {
      'serviceName': serviceName,
      'serviceCode': serviceCode,
      'shipmentCost': shipmentCost,
      'otherCost': otherCost,
    };
  }

  factory ShipstationRateModel.fromMap(Map<String, dynamic> map) {
    return ShipstationRateModel(
      serviceName: map['serviceName'],
      serviceCode: map['serviceCode'],
      shipmentCost: map['shipmentCost']?.toDouble(),
      otherCost: map['otherCost']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipstationRateModel.fromJson(String source) =>
      ShipstationRateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShipstationRateModel(serviceName: $serviceName, serviceCode: $serviceCode, shipmentCost: $shipmentCost, otherCost: $otherCost)';
  }
}
