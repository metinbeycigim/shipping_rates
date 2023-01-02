import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/shipstation_orders.dart';

class Rates extends ConsumerWidget {
  final Map<String, dynamic> fedexJson;
  final Map<String, dynamic> upsJson;
  final String orderNumber;
  
  const Rates({
    super.key,
    required this.fedexJson,
    required this.upsJson,
    required this.orderNumber,
  });

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
                        leading: Text(fedexRates![index].serviceName),
                        trailing:
                            Text((fedexRates[index].shipmentCost + fedexRates[index].otherCost).toStringAsFixed(2)),
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
                              leading: Text(upsRates![index].serviceName),
                              trailing:
                                  Text((upsRates[index].shipmentCost + upsRates[index].otherCost).toStringAsFixed(2)),
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
