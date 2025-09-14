import 'package:app/route_handler.dart';
import 'package:design/models/custom_navigation_bar_items.dart';
import 'package:design/util/navigation_bar_handler.dart';
import 'package:design/widget/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class App extends StatefulWidget {
  const App({super.key, required this.router, this.child});

  final GoRouter router;
  final Widget? child;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String currentLocation = "/";
  DateTime? lastPopTime;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RouteHandler.setBackHandler(_back);
      widget.router.routerDelegate.addListener(_onRouteChanged);
      NavigationBarHandler.visibility.show();
    });
  }

  @override
  void dispose() {
    widget.router.routerDelegate.removeListener(_onRouteChanged);
    RouteHandler.clearBackHandler();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Widget? _buildNavigationBar() {
    try {
      final showNavigationBar = [
        "/home",
        "/navigation",
        "/reward",
        "/mypage",
      ].contains(currentLocation);

      return showNavigationBar
          ? CustomNavigationBar(
              visibility: NavigationBarHandler.visibility,
              currentItem: switch (currentLocation) {
                "/home" => CustomNavigationBarItems.home,
                "/navigation" => CustomNavigationBarItems.navigation,
                "/reward" => CustomNavigationBarItems.reward,
                "/mypage" => CustomNavigationBarItems.profile,
                _ => throw UnimplementedError(),
              },
              onItemTapped: (item) {
                NavigationBarHandler.visibility.show();

                switch (item) {
                  case CustomNavigationBarItems.home:
                    widget.router.go("/home");
                    break;
                  case CustomNavigationBarItems.navigation:
                    widget.router.go("/navigation");
                    break;
                  case CustomNavigationBarItems.reward:
                    widget.router.go("/reward");
                    break;
                  case CustomNavigationBarItems.profile:
                    widget.router.go("/mypage");
                    break;
                }
              },
            )
          : null;
    } on GoError catch (_) {
      return null;
    }
  }

  void _back() {
    if (widget.router.canPop()) {
      widget.router.pop();
    } else {
      final now = DateTime.now();
      if (lastPopTime == null ||
          now.difference(lastPopTime!) > const Duration(seconds: 2)) {
        lastPopTime = now;

        Fluttertoast.showToast(
          msg: "한 번 더 뒤로가기를 누르면 종료됩니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        SystemNavigator.pop();
      }
    }
  }

  void _onRouteChanged() {
    setState(
      () => currentLocation = widget
          .router
          .routerDelegate
          .currentConfiguration
          .uri
          .toString(),
    );
  }
}
