import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_quests/controllers/bindings/initial_bindings.dart';
import 'package:save_quests/views/main_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const SavingQuests());
}

class SavingQuests extends StatelessWidget {
  const SavingQuests({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Saving Quests',
      theme: ThemeData(
        textTheme: GoogleFonts.itimTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          onError: Colors.red,
        ),
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
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.grey[200]!),
            iconColor: WidgetStateProperty.all<Color>(Colors.black),
            shape: WidgetStateProperty.all<OutlinedBorder>(CircleBorder()),
          ),
        ),
      ),
      initialBinding: InitialBinding(),
      home: const MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
