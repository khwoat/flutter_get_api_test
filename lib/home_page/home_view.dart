import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neversitup_exam/home_page/home_controller.dart';

import '../_model/currency_btc.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => FutureBuilder(
            future: controller.currencyBTC.value,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Bpi bpi = snapshot.data!.bpi;
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                    horizontal: 30,
                  ),
                  children: [
                    Text(
                      snapshot.data!.chartName,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    // Show currency data of USD, GBP, and EUR
                    getEachCurrency(context, bpi.usd.code, bpi.usd.description, bpi.usd.rate),
                    getEachCurrency(context, bpi.gbp.code, bpi.gbp.description, bpi.gbp.rate),
                    getEachCurrency(context, bpi.eur.code, bpi.eur.description, bpi.eur.rate),

                    Text(
                      snapshot.data!.disclaimer,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                );
              } else {
                Text(snapshot.error.toString());
              }
              
              return const CircularProgressIndicator();
              
            },
          ),
        ),
      )
    );
  }

  // Get Each currency with code, description, and rate
  Widget getEachCurrency(BuildContext context, String code, String description, String rate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(code, style: Theme.of(context).textTheme.headlineSmall),
        Text(description, style: Theme.of(context).textTheme.bodyLarge),

        Row(
          children: [
            Text("Rate: ", style: Theme.of(context).textTheme.headlineSmall),
            Text(rate, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        
        const SizedBox(height: 20),
      ],
    );
  }
}