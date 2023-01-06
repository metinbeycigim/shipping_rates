import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

class MainModel {
  final List<Map<String, dynamic>>? ratedOrders;

  MainModel({this.ratedOrders});

  factory MainModel.fromModels(ShipstationModel orders, List<ShipstationRateModel> rates) {
    final processedOrders = <Map<String, dynamic>>[];
    for (var order in orders.orders!) {
      final eachOrder = order.toMap();
      eachOrder['rates'] = rates;
      processedOrders.add(eachOrder);
    }

    return MainModel(ratedOrders: processedOrders);
  }
}
