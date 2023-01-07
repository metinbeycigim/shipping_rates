import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_orders.dart';

class Rates extends ConsumerWidget {
  final Map<String, dynamic> fedexJson;
  final Map<String, dynamic> upsJson;
  final String orderNumber;
  final Order order;

  const Rates(
      {super.key, required this.fedexJson, required this.upsJson, required this.orderNumber, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const fedexAccNumber = ShipstationCredentials.fedexAccountNumber;
    const upsAccNumber = ShipstationCredentials.upsAccountNumber;

    return Scaffold(
        appBar: AppBar(
          title: Text(orderNumber),
        ),
        body: FutureBuilder(
          future: Future.wait([
            ShipstationOrders().getFedExRates(fedexJson),
            ShipstationOrders().getUpsRates(upsJson),
          ]),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            final fedexRates = snapshot.data?[0];
            final upsRates = snapshot.data?[1];
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(height: 50),
                  const Center(
                    child: Text('FedEx Rates'),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: fedexRates?.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          final Order selectedOrder = order.copyWith(
                            carrierCode: 'fedex',
                            serviceCode: 'fedex_home_delivery',
                            packageCode: 'package',
                            advancedOptions: order.advancedOptions?.copyWith(
                              billToParty: 'my_other_account',
                              billToMyOtherAccount: fedexAccNumber,
                            ),
                          );
                          await shipstationPostFunction(selectedOrder);
                        },
                        leading: Text(fedexRates![index].serviceName.toString()),
                        trailing:
                            Text((fedexRates[index].shipmentCost! + fedexRates[index].otherCost!).toStringAsFixed(2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Center(
                    child: Text('UPS Rates'),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: upsRates?.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () async {
                                final Order selectedOrder = order.copyWith(
                                  carrierCode: 'ups_walleted',
                                  serviceCode: 'ups_ground',
                                  packageCode: 'package',
                                  advancedOptions: order.advancedOptions?.copyWith(
                                    billToParty: 'my_other_account',
                                    billToMyOtherAccount: upsAccNumber,
                                  ),
                                );
                                await shipstationPostFunction(selectedOrder);
                              },
                              leading: Text(upsRates![index].serviceName.toString()),
                              trailing:
                                  Text((upsRates[index].shipmentCost! + upsRates[index].otherCost!).toStringAsFixed(2)),
                            ),
                          )),
                ],
              );
            } else {
              return const Text('Loading...');
            }
          },
        ));
  }

  Future<Response<dynamic>> shipstationPostFunction(Order selectedOrder) {
    final dio = Dio();
    const apiKey = ShipstationCredentials.key;
    const apiSecret = ShipstationCredentials.secret;
    return dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders/createorder', data: selectedOrder.toMap());
  }
}
