import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipping_rates/firebase_database.dart';
import 'package:shipping_rates/rates.dart';
import 'package:shipping_rates/shipstation_orders.dart';

class Orders extends ConsumerWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ShipstationOrders.shipStationGetOrders);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
              onPressed: () async => await ref.refresh(ShipstationOrders.shipStationGetOrders.future),
              icon: const Icon(Icons.refresh_sharp)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: orders.hasValue
                ? Text(
                    'Order Qty: ${orders.whenData((value) => value.orders!.length).value}',
                  )
                : const Text('Loading'),
          ),
        ],
      ),
      body: orders.when(
          data: (shipstation) {
            final orderList = shipstation.orders ?? [];
            for (var order in orderList) {
              FirebaseDatabase().addOrder(order);
            }
            final weightedList = orderList.where((order) => order.weight?.value != 0).toList();

            Future<void> runDioMethods() async {
              for (var i = 0; i < weightedList.length; i++) {
                await Future.delayed(const Duration(milliseconds: 1600));
                FirebaseDatabase().addFedexRates(weightedList[i]);
                if (i == weightedList.length - 1) {
                  Fluttertoast.showToast(msg: 'List is ready!', toastLength: Toast.LENGTH_SHORT);
                }
              }
            }

            runDioMethods();

            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> fedexJson = {
                    "carrierCode": "fedex",
                    "serviceCode": null,
                    "packageCode": null,
                    "fromPostalCode": 75041,
                    "toState": orderList[index].shipTo?.state,
                    "toCountry": orderList[index].shipTo?.country,
                    "toPostalCode": orderList[index].shipTo?.postalCode?.split('-')[0],
                    "toCity": orderList[index].shipTo?.city,
                    "weight": orderList[index].weight?.toMap(),
                    "dimensions": orderList[index].dimensions?.toMap(),
                    "confirmation": "delivery",
                    "residential": orderList[index].shipTo?.residential,
                  };
                  final Map<String, dynamic> upsJson = {
                    "carrierCode": "ups_walleted",
                    "serviceCode": null,
                    "packageCode": null,
                    "fromPostalCode": 75041,
                    "toState": orderList[index].shipTo?.state,
                    "toCountry": orderList[index].shipTo?.country,
                    "toPostalCode": orderList[index].shipTo?.postalCode?.split('-')[0],
                    "toCity": orderList[index].shipTo?.city,
                    "weight": orderList[index].weight?.toMap(),
                    "dimensions": orderList[index].dimensions?.toMap(),
                    "confirmation": "delivery",
                    "residential": orderList[index].shipTo?.residential,
                  };

                  return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        tileColor: (orderList[index].weight?.value == 0.00 ||
                                orderList[index].dimensions?.height == 0.00 ||
                                orderList[index].dimensions?.length == 0.00 ||
                                orderList[index].dimensions?.width == 0.00 ||
                                orderList[index].dimensions == null ||
                                orderList[index].weight == null)
                            ? Colors.red
                            : Colors.white,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return Rates(
                            fedexJson: fedexJson,
                            upsJson: upsJson,
                            orderNumber: orderList[index].orderNumber.toString(),
                            order: orderList[index],
                          );
                        })),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        leading: Text(orderList[index].orderNumber.toString()),
                      ));
                });
          },
          error: ((error, stackTrace) => Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
