import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_quests/controllers/bindings/initial_bindings.dart';
import 'package:save_quests/views/main_view.dart';

void main() {
  runApp(const SavingQuests());
}

class SavingQuests extends StatelessWidget {
  const SavingQuests({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: InitialBinding(),
      home: const MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
