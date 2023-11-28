import 'dart:async';


import 'package:cars_shop/mainNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import '../../core/cache_helper.dart';
import '../../core/helper_methods.dart';
import '../shopScreens/shopAuth/login/view.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3,milliseconds: 500),
          () {
        navigateTo(context, page: CacheHelper.getId()!=""?const MainNav():ShopLogIn(),withHistory: false);
      },
    );

    return Scaffold(
        body: Center(
          child: Container(
            width: 375,
            height: 812,
            child: Center(child: Image.asset('assets/images/logo.png')),
          ),
        ));
  }
}
// 55.21
// 33
