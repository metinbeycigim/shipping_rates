import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:dio/dio.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

class FirebaseDatabase {
  FirebaseFirestore get firebaseDatabase => FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get firebaseOrderRef => firebaseDatabase.collection('Orders');
  CollectionReference<Map<String, dynamic>> get firebaseRatesRef => firebaseDatabase.collection('Rates');
  final dio = Dio();
  final apiKey = ShipstationCredentials.key;
  final apiSecret = ShipstationCredentials.secret;

  Future<void> addOrder(Order order) async {
    final orderRef = firebaseOrderRef.doc(order.orderNumber);
    await orderRef.set(order.toMap());
  }

  Future<void> addFedexRates(Order order) async {
    final rateRef = firebaseRatesRef.doc(order.orderNumber);

    final Map<String, dynamic> fedexJson = {
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
        await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/shipments/getrates', data: fedexJson);

    
  }
}
