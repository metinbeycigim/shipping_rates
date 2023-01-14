import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shipping_rates/shipstation_credentials.dart';
import 'package:shipping_rates/shipstation_model.dart';

class OrderDetails extends StatefulWidget {
  final Order order;
  const OrderDetails({required this.order, super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  TextEditingController weightLbsController = TextEditingController();
  TextEditingController weightOzController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final apiKey = ShipstationCredentials.key;
  final apiSecret = ShipstationCredentials.secret;
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    weightLbsController.text = (widget.order.weight?.value != null)
        ? (widget.order.weight!.value! / 16).floorToDouble().toStringAsFixed(1)
        : '0';
    weightOzController.text =
        (widget.order.weight?.value != null) ? (widget.order.weight!.value! % 16).toStringAsFixed(1) : '0';
    heightController.text =
        (widget.order.dimensions?.height != null) ? widget.order.dimensions!.height.toString() : '0';
    widthController.text = (widget.order.dimensions?.width != null) ? widget.order.dimensions!.width.toString() : '0';
    lengthController.text =
        (widget.order.dimensions?.length != null) ? widget.order.dimensions!.length.toString() : '0';
  }

  @override
  void dispose() {
    weightLbsController.dispose();
    weightOzController.dispose();
    heightController.dispose();
    widthController.dispose();
    lengthController.dispose();
    super.dispose();
  }

//! this screen shows single item details. multiple items should be added.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.order.orderNumber.toString())),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: weightLbsController,
                          decoration: const InputDecoration(
                            labelText: 'lbs',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                          validator: validator,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                          onTap: () => weightLbsController.selection =
                              TextSelection(baseOffset: 0, extentOffset: weightLbsController.text.length),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: weightOzController,
                          decoration: const InputDecoration(
                            labelText: 'oz',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                          validator: validator,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                          onTap: () => weightOzController.selection =
                              TextSelection(baseOffset: 0, extentOffset: weightOzController.text.length),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: lengthController,
                    decoration: const InputDecoration(
                      labelText: 'Length',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    validator: validator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                    onTap: () => lengthController.selection =
                        TextSelection(baseOffset: 0, extentOffset: lengthController.text.length),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: widthController,
                    decoration: const InputDecoration(
                      labelText: 'Width',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    validator: validator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                    onTap: () => widthController.selection =
                        TextSelection(baseOffset: 0, extentOffset: widthController.text.length),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: heightController,
                    decoration: const InputDecoration(
                      labelText: 'Height',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                    validator: validator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                    onTap: () => heightController.selection =
                        TextSelection(baseOffset: 0, extentOffset: heightController.text.length),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final modifiedOrder = widget.order
                            .copyWith(
                              weight: Weight(
                                value:
                                    double.parse(weightLbsController.text) * 16 + double.parse(weightOzController.text),
                              ),
                              dimensions: Dimensions(
                                length: double.parse(lengthController.text),
                                width: double.parse(widthController.text),
                                height: double.parse(heightController.text),
                              ),
                            )
                            .toMap();
                        try {
                          await dio.post('https://$apiKey:$apiSecret@ssapi.shipstation.com/orders/createorder',
                              data: modifiedOrder);
                          if (mounted) {
                            Navigator.of(context).pop();
                          }

                          FocusManager.instance.primaryFocus?.unfocus();
                        } catch (e) {
                          Text(e.toString());
                        }
                      }
                    },
                    child: const Text('Submit')),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Input a value';
    } else {
      return null;
    }
  }
}
