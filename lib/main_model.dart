import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

class MainModel {
  final ShipstationModel order;
  final List<ShipstationRateModel> rates;

  MainModel(this.order, this.rates);

  factory MainModel.fromModels(ShipstationModel order, List<ShipstationRateModel> rates) {
    return MainModel(order,rates);
  }
}
