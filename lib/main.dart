import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neversitup_exam/home_page/home_binding.dart';

import 'home_page/home_view.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      initialBinding: HomeBinding(),

      theme: ThemeData(
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
        )
      ),

      getPages: [
        GetPage(
          name: "/",
          page: () => const HomeView(),
          binding: HomeBinding()
        )
      ],
    )
  );
}