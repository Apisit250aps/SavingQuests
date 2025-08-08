import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:save_quests/controllers/bindings/initial_bindings.dart';
import 'package:save_quests/models/enum/transaction_category/transaction_category.dart';
import 'package:save_quests/models/enum/transaction_type/transaction_type.dart';
import 'package:save_quests/models/transaction/transaction.dart';
import 'package:save_quests/models/wallet/wallet.dart';
import 'package:save_quests/views/main_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  await Hive.initFlutter();
  Hive.registerAdapter(WalletAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionCategoryAdapter());

  await Hive.openBox<Wallet>('wallets');
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<TransactionType>('transaction_types');
  await Hive.openBox<TransactionCategory>('transaction_categories');

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.pink.shade200,
          secondary: Colors.blue.shade200,
          seedColor: Colors.white,
          onError: Colors.red,
        ),
        timePickerTheme: TimePickerThemeData(
          helpTextStyle: TextStyle(
            color: Colors.pink.shade200
          ),
          // backgroundColor: Colors.pink.shade50, // พื้นหลังละมุน
          confirmButtonStyle: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.pink.shade200),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.pink.shade200),
          ),
          // dialBackgroundColor: Colors.pink.shade50, // พื้นหลังวงล้อ
          dialTextColor: Colors.pink.shade200, // ตัวเลขในวงล้อ
          dialHandColor: Colors.pink.shade50, // เข็มชี้เวลา
          hourMinuteColor: Colors.pink.shade50, // กล่องชั่วโมง/นาที
          hourMinuteTextColor:
              Colors.pink.shade200, // ตัวเลขในกล่องชั่วโมง/นาที
          dayPeriodColor: Colors.pink.shade50, // AM/PM พื้นหลัง
          dayPeriodTextColor: Colors.pink.shade200,
          dayPeriodBorderSide: BorderSide(color: Colors.pink.shade200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ), // มุมโค้งทั้งกล่อง
        ),

        datePickerTheme: DatePickerThemeData(
          rangePickerHeaderForegroundColor: Colors.pink.shade200,
          yearForegroundColor: WidgetStatePropertyAll(Colors.pink.shade300),
          headerForegroundColor: Colors.pink.shade300,
          weekdayStyle: TextStyle(color: Colors.pink.shade300),
          dividerColor: Colors.pink.shade50, // เส้นคั่นอ่อน
          dayOverlayColor: WidgetStatePropertyAll(Colors.pink.shade50),
          dayBackgroundColor: WidgetStatePropertyAll(
            Colors.pink.shade50,
          ), // พื้นหลังวัน
          dayForegroundColor: WidgetStatePropertyAll(
            Colors.pink.shade800,
          ), // สีตัวเลขวัน
          todayBackgroundColor: WidgetStatePropertyAll(
            Colors.pink.shade200,
          ), // พื้นหลังของวันนี้
          todayForegroundColor: WidgetStatePropertyAll(
            Colors.white,
          ), // ตัวหนังสือของวันนี้
          confirmButtonStyle: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.pink.shade200),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.pink.shade200),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        buttonTheme: ButtonThemeData(buttonColor: Colors.blue.shade200),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue.shade200),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            elevation: WidgetStatePropertyAll(0),
          ),
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
            backgroundColor: WidgetStateProperty.all<Color>(
              Colors.pink.shade50,
            ),
            iconColor: WidgetStateProperty.all<Color>(Colors.pink.shade200),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          surfaceTintColor: Colors.pink.shade200,
          backgroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Colors.pink.shade50,
          foregroundColor: Colors.pink.shade200,
          iconSize: 32,
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.pink.shade200,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black12, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pink.shade200, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      initialBinding: InitialBinding(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
