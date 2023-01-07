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
    // final fedexJsonSample = {
    //   "carrierCode": "fedex",
    //   "serviceCode": null,
    //   "packageCode": null,
    //   "fromPostalCode": "78041",
    //   "toState": "GA",
    //   "toCountry": "US",
    //   "toPostalCode": "30024",
    //   "toCity": 'SUWANEE',
    //   "weight": {"value": 120, "units": "ounces"},
    //   "dimensions": {"units": "inches", "length": 4, "width": 12, "height": 25},
    //   "confirmation": "delivery",
    //   "residential": true
    // };
    final dio = Dio();
    const apiKey = ShipstationCredentials.key;
    const apiSecret = ShipstationCredentials.secret;
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
                          final selectedOrder = order.copyWith(
                            carrierCode: 'fedex',
                            serviceCode: 'fedex_home_delivery',
                            packageCode: 'package',
                            advancedOptions: order.advancedOptions?.copyWith(
                              billToParty: 'my_other_account',
                              billToMyOtherAccount: fedexAccNumber,
                            ),
                          );

                          await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders/createorder',
                              data: selectedOrder.toMap());
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
                                final selectedOrder = order.copyWith(
                                  carrierCode: 'ups_walleted',
                                  serviceCode: 'ups_ground',
                                  packageCode: 'package',
                                  advancedOptions: order.advancedOptions?.copyWith(
                                    billToParty: 'my_other_account',
                                    billToMyOtherAccount: upsAccNumber,
                                  ),
                                );
                                

                                await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders/createorder',
                                    data: selectedOrder.toMap());
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
}
