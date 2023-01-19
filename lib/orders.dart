import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/order_details.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_orders.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ShipstationOrders.shipStationGetOrders);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Orders'),
            if (isLoading)
              const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                ),
              )
          ],
        ),
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
            // The list contains the weights are not null.
            final List<Order> orderList = shipstation.orders ?? [];

            Future<void> getRates() async {
              setState(() {
                isLoading = !isLoading;
              });

              for (var order in orderList) {
                if (order.weight?.value != 0.00) {
                  List<ShipstationRateModel> rateList = [];
                  await Future.delayed(const Duration(milliseconds: 1800));
                  final fedexRate = await ShipstationOrders().getFedExRate(order);
                  rateList.addAll(fedexRate);
                  final upsRate = await ShipstationOrders().getUpsRate(order);
                  rateList.addAll(upsRate);
                  rateList.sort((a, b) => (a.shipmentCost! + a.otherCost!).compareTo(b.shipmentCost! + b.otherCost!));
                  order.cheapRate = rateList[0];
                } else {
                  order.cheapRate =
                      ShipstationRateModel(serviceName: 'Weight data missing!!!', otherCost: 0, shipmentCost: 0);
                }
              }
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () => getRates().then((_) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                          }),
                      child: const Text('Get Rates')),
                  const SizedBox(height: 10),
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderDetails(order: orderList[index].copyWith()))),
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
                              title: Row(
                                children: [
                                  const Text('|   '),
                                  Text(orderList[index].cheapRate?.serviceName ?? ''),
                                  if (orderList[index].cheapRate?.serviceName != null) const Text(' ------ '),
                                  if (orderList[index].cheapRate?.serviceName != null)
                                    Text(
                                        '\$ ${((orderList[index].cheapRate?.otherCost! ?? 0) + (orderList[index].cheapRate?.shipmentCost! ?? 0)).toStringAsFixed(2)}')
                                ],
                              ),
                              trailing: (orderList[index].shipTo?.addressVerified == "Address validated successfully")
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : const Icon(Icons.question_mark_sharp, color: Colors.red),
                            ));
                      }),
                ],
              ),
            );
          },
          error: ((error, stackTrace) => Text(stackTrace.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
