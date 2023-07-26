import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_app/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_app/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_app/ui/cart/cart.dart';
import 'package:nike_ecommerce_app/ui/home/home.dart';
import 'package:nike_ecommerce_app/ui/widgets/badge.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  @override
  void initState() {
    cartRepository.count();
    super.initState();
  }

  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _cartKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _navigator(_homeKey, homeIndex, HomeScreen()),
            _navigator(_cartKey, cartIndex, CartScreen()),
            _navigator(
                _profileKey,
                profileIndex,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('profile page'),
                    ElevatedButton(
                        onPressed: () {
                          cartRepository.cartItemCountNotifier.value = 0;
                          authRepository.signOut();
                        },
                        child: Text('خروج'))
                  ],
                )),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedScreenIndex,
          onTap: (selectedIndex) {
            setState(() {
              _history.remove(selectedScreenIndex);
              _history.add(selectedScreenIndex);
              selectedScreenIndex = selectedIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(CupertinoIcons.cart),
                    Positioned(
                        right: -12,
                        top: -5,
                        child: ValueListenableBuilder<int>(
                          valueListenable: cartRepository.cartItemCountNotifier,
                          builder: (context, value, child) {
                            return BadgeWidget(value: value);
                          },
                        )),
                  ],
                ),
                label: 'سبد خرید'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
          ],
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;

    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                      offstage: selectedScreenIndex != index,
                      child: child,
                    )),
          );
  }
}
