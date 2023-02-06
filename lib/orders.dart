import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shipping_rates/order_details.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';
import 'package:shipping_rates/shipstation_orders.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  bool isLoading = false;
  final TextEditingController _orderNumberController = TextEditingController();
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void dispose() {
    super.dispose();
    _orderNumberController.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ShipstationOrders.shipStationGetOrders);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Orders'),
            StreamBuilder(
              builder: (context, snapshot) {
                final value = snapshot.data as int;
                final displayTime = StopWatchTimer.getDisplayTime(value, milliSecond: false);
                return Text(displayTime);
              },
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
            ),
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
              onPressed: () => ref
                  .refresh(ShipstationOrders.shipStationGetOrders.future)
                  .then((_) => _stopWatchTimer.onResetTimer()),
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
            final filteredOrders =
                orderList.where((order) => order.orderNumber!.contains(_orderNumberController.text)).toList();

            Future<void> getRates() async {
              _stopWatchTimer.onResetTimer();
              _stopWatchTimer.onStartTimer();
              setState(() {
                isLoading = !isLoading;
              });

              for (var order in filteredOrders) {
                // await Future.delayed(const Duration(milliseconds: 1600));
                if (order.weight?.value != 0.00) {
                  List<ShipstationRateModel> rateList = [];
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
                await ShipstationOrders().postRates(order.copyWith(
                  carrierCode: order.cheapRate!.serviceName!.contains('UPS') ? 'ups_walleted' : 'fedex',
                  serviceCode: order.cheapRate?.serviceCode ?? 'fedex_home_delivery',
                  packageCode: 'package',
                  advancedOptions: order.advancedOptions?.copyWith(
                    billToParty: 'my_other_account',
                    billToMyOtherAccount: order.cheapRate!.serviceName!.contains('FedEx')
                        ? ShipstationCredentials.mapleFedexAccountNumber
                        : ShipstationCredentials.mapleUpsAccountNumber,
                  ),
                ));
              }
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 150, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextField(
                            onChanged: (value) => setState(() {}),
                            controller: _orderNumberController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _orderNumberController.clear();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.clear),
                              ),
                              suffixText: filteredOrders.length.toString(),
                              border: const OutlineInputBorder(),
                              labelText: 'Order Number',
                              hintText: 'Enter an order number',
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => getRates().then((_) {
                                _stopWatchTimer.onStopTimer();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              }),
                          child: const Text('Get Rates')),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OrderDetails(order: filteredOrders[index].copyWith()))),
                              tileColor: (filteredOrders[index].weight?.value == 0.00 ||
                                      filteredOrders[index].dimensions?.height == 0.00 ||
                                      filteredOrders[index].dimensions?.length == 0.00 ||
                                      filteredOrders[index].dimensions?.width == 0.00 ||
                                      filteredOrders[index].dimensions == null ||
                                      filteredOrders[index].weight == null)
                                  ? Colors.red
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              leading: Text(filteredOrders[index].orderNumber.toString()),
                              title: Row(
                                children: [
                                  const Text('|   '),
                                  Text(filteredOrders[index].cheapRate?.serviceName ?? ''),
                                  if (filteredOrders[index].cheapRate?.serviceName != null) const Text(' ------ '),
                                  if (filteredOrders[index].cheapRate?.serviceName != null)
                                    Text(
                                        '\$ ${((filteredOrders[index].cheapRate?.otherCost! ?? 0) + (filteredOrders[index].cheapRate?.shipmentCost! ?? 0)).toStringAsFixed(2)}'),
                                ],
                              ),
                              trailing:
                                  (filteredOrders[index].shipTo?.addressVerified == "Address validated successfully")
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
