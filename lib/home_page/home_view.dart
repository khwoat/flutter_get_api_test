import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neversitup_exam/home_page/home_controller.dart';

import '../_model/currency_btc.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Center(
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
      
                      // Time of latest update
                      Row(
                        children: [
                          Text(
                            "Updated: ",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            snapshot.data!.time.updated,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
      
                      const SizedBox(height: 20),
      
                      // Show currency data of USD, GBP, and EUR
                      getEachCurrency(context, bpi.usd.code, bpi.usd.description, bpi.usd.rate),
                      getEachCurrency(context, bpi.gbp.code, bpi.gbp.description, bpi.gbp.rate),
                      getEachCurrency(context, bpi.eur.code, bpi.eur.description, bpi.eur.rate),
      
                      Text(
                        "*per 1 BTC.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
      
                      const SizedBox(height: 20),
      
                      // Converting currency module
                      Obx(() => getConvertCurrencyModule(context, bpi)),

                      const SizedBox(height: 20),
      
                      // A button that click for Going to history of currency data page.
                      ElevatedButton(
                        onPressed: () => controller.gotoHistoryPage(),
                        child: Text(
                          "History",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                        ),
                      ),
      
                      const SizedBox(height: 20),
      
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
            Text("$rate $code", style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        
        const SizedBox(height: 15),
      ],
    );
  }
  
  // A module that use to convert currency to BTC.
  Widget getConvertCurrencyModule(BuildContext context, Bpi bpi) {
    return Column(
      children: [
        Text("Currency to BTC", style: Theme.of(context).textTheme.headlineMedium,),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Dropdown to select a currency for converting to BTC.
            DropdownButton<String>(
              value: controller.dropdownValue.value,
              onChanged:(value) => controller.dropdownValue.value = value!,
              items: [
                getEachBpiDropdownMenuItem(context, bpi.usd.code),
                getEachBpiDropdownMenuItem(context, bpi.gbp.code),
                getEachBpiDropdownMenuItem(context, bpi.eur.code),
              ],
            ),

            SizedBox(
              width: 150,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller.textEditingController,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            // Convert currency button
            GestureDetector(
              onTap: () {
                Map map = bpi.toJson();
                controller.convertValue.value = double.parse(controller.textEditingController.text) / map[controller.dropdownValue.value]["rate_float"];
              },
              child: Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Convert",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                )
              ),
            )
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BTC: ", style: Theme.of(context).textTheme.bodyLarge,),
            Text(
              controller.currencyFormat.format(controller.convertValue.value),
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        )

      ],
    );
  }

  // Each dropdown menu item of each currency
  DropdownMenuItem<String> getEachBpiDropdownMenuItem(BuildContext context, String code) {
    return DropdownMenuItem(
      value: code,
      child: Text(code, style: Theme.of(context).textTheme.bodyLarge,),
    );
  }
}