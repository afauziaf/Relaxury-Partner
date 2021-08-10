import 'package:get/get.dart';

import '../../controllers/auth.controller.dart';
import '../../controllers/chat.controller.dart';
import '../../controllers/main.controller.dart';
import '../../controllers/notification.controller.dart';
import '../../controllers/order.controller.dart';
import '../../controllers/profile.controller.dart';
import '../../controllers/splash.controller.dart';
import '../../controllers/wallet.controller.dart';
import '../../presentation/auth/screens/login.screen.dart';
import '../../presentation/auth/screens/register.screen.dart';
import '../../presentation/auth/screens/reset_password.screen.dart';
import '../../presentation/auth/screens/verification.screen.dart';
import '../../presentation/chat/screens/chat.screen.dart';
import '../../presentation/main.screen.dart';
import '../../presentation/order/screens/order.screen.dart';
import '../../presentation/order/screens/order_details.screen.dart';
import '../../presentation/order/screens/order_history.screen.dart';
import '../../presentation/profile/screens/notification.screen.dart';
import '../../presentation/profile/screens/profile.screen.dart';
import '../../presentation/splash/splash.screen.dart';
import '../../presentation/wallet/screens/convert.screen.dart';
import '../../presentation/wallet/screens/transaction_history.screen.dart';
import '../../presentation/wallet/screens/transfer.screen.dart';
import '../../presentation/wallet/screens/withdraw.screen.dart';
import 'name.route.dart';

class RoutePage {
  static final GetPage unknowRoute = GetPage(name: RouteName.splash, page: () => SplashScreen(), binding: SplashBinding());

  static final List<GetPage> pages = [
    // Splash
    GetPage(name: RouteName.splash, page: () => SplashScreen(), binding: SplashBinding()),

    // Auth
    GetPage(name: RouteName.login, page: () => LoginScreen(), binding: AuthBinding()),
    GetPage(name: RouteName.resetPassword, page: () => ResetPasswordScreen(), binding: AuthBinding()),
    GetPage(name: RouteName.register, page: () => RegisterScreen(), binding: AuthBinding()),
    GetPage(name: RouteName.accountVerification, page: () => AccountVerificationScreen(), binding: AuthBinding()),

    // Main
    GetPage(name: RouteName.main, page: () => MainScreen(), binding: MainBinding()),

    // Wallet
    GetPage(name: RouteName.wallet, page: () => MainScreen(), binding: WalletBinding()),
    GetPage(name: RouteName.transactionHistory, page: () => TransactionHistoryScreen(), binding: WalletBinding()),
    GetPage(name: RouteName.transfer, page: () => TransferScreen(), binding: WalletBinding()),
    GetPage(name: RouteName.withdraw, page: () => WithdrawScreen(), binding: WalletBinding()),
    GetPage(name: RouteName.convert, page: () => ConvertScreen(), binding: WalletBinding()),

    // Notification
    GetPage(name: RouteName.notitification, page: () => NotificationScreen(), binding: NotificationBinding()),

    // Order
    GetPage(name: RouteName.order, page: () => OrderScreen(), binding: OrderBinding()),
    GetPage(name: RouteName.orderDetails, page: () => OrderDetailsScreen(), binding: OrderBinding()),
    GetPage(name: RouteName.orderHistory, page: () => OrderHistoryScreen(), binding: OrderBinding()),

    // Chat
    GetPage(name: RouteName.chat, page: () => ChatScreen(), binding: ChatBinding()),

    // Menu
    GetPage(name: RouteName.profile, page: () => ProfileScreen(), binding: ProfileBinding()),
  ];
}
