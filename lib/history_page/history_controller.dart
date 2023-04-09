import 'dart:convert';

import 'package:get/get.dart';
import 'package:neversitup_exam/_model/currency_btc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {

  Map<String, Bpi> historyData = {}; 

  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    isLoading.value = true;

    // Set data from SharedPreference
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString("currency-data");
    if (data != null && data != "") {
      Map<String, dynamic> mapData = jsonDecode(data);
      mapData.forEach((key, value) {
        historyData[key] = Bpi.fromJson(value);
      });
    }
    // Sort data
    historyData = Map.fromEntries(historyData.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));

    isLoading.value = false;

    super.onInit();
  }
}