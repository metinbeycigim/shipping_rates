import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/shipstation_orders.dart';

class Rates extends ConsumerWidget {
  const Rates({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.read(ShipstationOrders.shipStationGetOrders);
   
    final fedexJson = {
      "carrierCode": "fedex",
      "serviceCode": null,
      "packageCode": null,
      "fromPostalCode": "78041",
      "toState": "GA",
      "toCountry": "US",
      "toPostalCode": "30024",
      "toCity": 'SUWANEE',
      "weight": {"value": 120, "units": "ounces"},
      "dimensions": {"units": "inches", "length": 4, "width": 12, "height": 25},
      "confirmation": "delivery",
      "residential": true
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text('Rates'),
        ),
        body: FutureBuilder(
          future: ShipstationOrders().getRates(fedexJson),
          builder: (context, snapshot) {
            final rates = snapshot.data;
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: Text(rates![index].serviceName),
                        trailing: Text((rates[index].shipmentCost + rates[index].otherCost).toStringAsFixed(2)),
                      ));
            } else {
              return const Text('Loading...');
            }
          },
        )
        // RefreshIndicator(
        //   onRefresh: () async => await ref.refresh(ShipstationOrders.shipStationGetOrders.future),
        //   child: rates.when(
        //     data: (data) {
        //       return Text(data[0].serviceCode);
        //     },
        //     error: (error, stackTrace) => Text(error.toString()),
        //     loading: () => const CircularProgressIndicator(),
        //   ),
        // ),
        );
  }
}
