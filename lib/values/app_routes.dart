import 'package:flutter/cupertino.dart';
import 'package:fs04/pages/bt_01_page.dart';
import 'package:fs04/pages/bt_02_page.dart';
import 'package:fs04/pages/home_page.dart';

class AppRoutes {
  final BuildContext context;
  AppRoutes(this.context);

  var routes = {
    homePage: (context) => const HomePage(),
    bt01Page: (context) => const Bt01Page(),
    bt02Page: (context) => const Bt02Page(),
  };

  static const homePage = "/homePage";
  static const bt01Page = "/bt01Page";
  static const bt02Page = "/bt02Page";
}
