import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:save_quests/models/transaction/transaction.dart';
import 'package:save_quests/models/wallet/wallet.dart';

class WalletController extends GetxController {
  late Box<Wallet> walletBox;
  late Box<Transaction> transactionBox;

  final RxList<Wallet> wallets = <Wallet>[].obs;
  final RxList<Transaction> transactions = <Transaction>[].obs;

  Wallet get defaultWallet => wallets[0];

  @override
  void onInit() {
    super.onInit();
    //
    walletBox = Hive.box<Wallet>('wallets');
    transactionBox = Hive.box<Transaction>('transactions');
    //
    initialWallet();
  }

  void initialWallet() {
    final wallet = walletBox.values.toList();
    if (wallet.isEmpty) {
      walletBox.add(
        Wallet(
          name: "default",
          desc: "-",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
    loadWallets();
  }

  void loadWallets() {
    wallets.value = walletBox.values.toList();
  }
}
