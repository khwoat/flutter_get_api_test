import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios)
        ),
      ),

      body: Center(
        child: Obx(
          () => (!controller.isLoading.value)
          ? ListView(
            children: getAllHistoricData(context),
          )
          : const CircularProgressIndicator()
        ),
      )
    );
  }

  // Get all historic currency of BTC data
  List<Widget> getAllHistoricData(BuildContext context) {
    List<Widget> widgets = [];
    controller.historyData.forEach((key, value) {
      widgets.add(
        Card(
          margin: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Data at ", style: Theme.of(context).textTheme.headlineSmall,),
                    Text(key, style: Theme.of(context).textTheme.headlineSmall,),
                  ],
                ),
                  
                getEachCurrency(context, value.usd.code, value.usd.description, value.usd.rate),
                getEachCurrency(context, value.gbp.code, value.gbp.description, value.gbp.rate),
                getEachCurrency(context, value.eur.code, value.eur.description, value.eur.rate),
              ],
            ),
          ),
        )
      );
    });

    return widgets;
  }

  // Get Each currency with code, description, and rate
  Widget getEachCurrency(BuildContext context, String code, String description, String rate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(code, style: Theme.of(context).textTheme.headlineSmall),
        Text(description, style: Theme.of(context).textTheme.bodyLarge),

        Row(
          children: [
            Text("Rate: ", style: Theme.of(context).textTheme.headlineSmall),
            Text("$rate $code", style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}