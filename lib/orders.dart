import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        body: RefreshIndicator(
          onRefresh: () async => ref.refresh(ShipstationOrders.shipStationGetOrders.future),
          child: orders.when(
              data: (shipstation) {
                final orderList = shipstation.orders ?? [];
              
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            leading: Text(orderList[index].orderNumber.toString()),
                            trailing: Text(orderList[index].shippingAmount.toString()),
                          ));
                    });
              },
              error: ((error, stackTrace) => Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator())),
        ));
  }
}
