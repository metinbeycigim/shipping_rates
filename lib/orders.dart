import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/shipstation_orders.dart';
import 'package:shipping_rates/shipstation_rate_model.dart';

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
            // Awaiting shipments list.
            final orderList = shipstation.orders ?? [];
            // The list contains the weights are not null.
            final weightedList = orderList.where((order) => order.weight?.value != 0).toList();
            // Weighted list rates in this Map. Initial value is empty.
            final rateList = <String, List<ShipstationRateModel>>{};

            Future<void> getRates() async {
              for (var i = 0; i < weightedList.length; i++) {
                await Future.delayed(const Duration(milliseconds: 1600));
                final fedexRate = await ShipstationOrders().getFedExRate(weightedList[i]);
                rateList['${weightedList[i].orderNumber} / FedEx'] = fedexRate;
                final upsRate = await ShipstationOrders().getUpsRate(weightedList[i]);
                rateList['${weightedList[i].orderNumber} / UPS'] = upsRate;
              }
            }

            getRates();

            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderList.length,
                itemBuilder: (context, index) {
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
