import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/main_model.dart';
import 'package:shipping_rates/orders.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final testModel = ShipstationModel(orders: [Order(customerUsername: 'metin')]);
    final testrates = <ShipstationRateModel>[ShipstationRateModel(otherCost: 1), ShipstationRateModel(otherCost: 5)];
    final model = MainModel.fromModels(testModel, testrates);
    print(model.ratedOrders?[0]['rates'].length());
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orders',
      home: Orders(),
    );
  }
}
