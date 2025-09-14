import 'package:flutter/material.dart';

class NavigationBarHandler {
  static final NavigationBarVisibility _visibility = NavigationBarVisibility();
  static NavigationBarVisibility get visibility => _visibility;
}

class NavigationBarVisibility extends ValueNotifier<bool> {
  NavigationBarVisibility() : super(false);

  void show() => value = true;
  void hide() => value = false;
}
