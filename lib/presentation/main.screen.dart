import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main.controller.dart';
import '../controllers/profile.controller.dart';
import '../global/helpers/storage.dart';
import '../global/layouts/defauft.layout.dart';
import '../global/routes/name.route.dart';
import '../global/themes/color.theme.dart';
import 'chat/screens/chat.screen.dart';
import 'order/screens/order.screen.dart';
import 'profile/screens/notification.screen.dart';
import 'wallet/screens/wallet.screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Widget> screens = [
    WalletScreen(),
    NotificationScreen(),
    ChatScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (mainController) {
        return DefaultLayout(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: screens[_currentPageIndex],
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              onPressed: () => Get.to(() => OrderScreen()),
              backgroundColor: primaryColor,
              child: Icon(Icons.book),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            extendBodyBehindAppBar: true,
            extendBody: true,
            bottomNavigationBar: BottomAppBar(
              notchMargin: 10,
              shape: CircularNotchedRectangle(),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () => _onBottomNavigationTap(0), icon: Icon(Icons.account_balance_wallet, color: _changeBottomNavitionIconColor(0))),
                    IconButton(onPressed: () => _onBottomNavigationTap(1), icon: Icon(Icons.notifications, color: _changeBottomNavitionIconColor(1))),
                    IconButton(onPressed: null, icon: Icon(Icons.explore, color: Colors.transparent)),
                    IconButton(onPressed: () => _onBottomNavigationTap(2), icon: Icon(Icons.forum_rounded, color: _changeBottomNavitionIconColor(2))),
                    IconButton(
                      onPressed: () => Get.toNamed(RouteName.profile),
                      icon: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Hero(
                            tag: 'avatar',
                            child: GetBuilder<ProfileController>(
                              builder: (profileController) {
                                return Image.network(
                                  Storage(StorageName.baseUrl).read() + (profileController.profileModel.avatar),
                                  fit: BoxFit.cover,
                                  height: 24,
                                  width: 24,
                                  errorBuilder: (c, b, s) {
                                    return Image.asset(
                                      'assets/images/customer_avatar.png',
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _onBottomNavigationTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Color _changeBottomNavitionIconColor(int index) {
    if (index == _currentPageIndex)
      return primaryColor;
    else
      return Colors.grey.shade300;
  }
}
