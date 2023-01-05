import 'package:flutter/material.dart';
import 'package:shipping_rates/shipstation_model.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ShipstationModel().getOrders(),
        child: FutureBuilder(
          future: ShipstationModel().getOrders(),
          builder: (context, snapshot) {
            final orderList = snapshot.data?.orders;
            if (orderList != null) {
              return ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(orderList[index].orderNumber.toString()),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
