import 'package:cars_shop/core/cache_helper.dart';
import 'package:cars_shop/core/helper_methods.dart';
import 'package:cars_shop/shopScreens/shopAuth/login/view.dart';
import 'package:cars_shop/shopScreens/startreport/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/constance.dart';
import '../../widgets/customBotton.dart';
import '../../widgets/customText.dart';
import 'bloc/profile_bloc.dart';


class ShopHomeScreen extends StatefulWidget {
  ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  @override
  final bloc = KiwiContainer().resolve<ProfileBloc>()
    ..add(GetUserEvent(userId: CacheHelper.getId()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [BlocListener(
            bloc: bloc,
            listener: (context, state) {
              if(state is LogOutSuccessState){
                navigateTo(context, page: ShopLogIn());
              }else if(state is LogOutFailureState){
                toast(msg: state.message);
              }
            },
            child: IconButton(
              color: secondaryColor,
              icon: const Icon(Icons.logout_rounded, size: 28,), onPressed: () {
              bloc.add(LogOutEvent());
            },
            ),
          )
          ],
          centerTitle: true,
          elevation: 5,
          shadowColor: const Color.fromARGB(255, 231, 231, 231),
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'My Shop Details',
            fontSize: 20,
          )),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is GetUserSuccessState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration:
                          BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/avtar.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: state.user.username!,
                          fontSize: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: primaryColor),
                            width: 400,
                            height: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Shop Details',
                                    fontSize: 20,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: 'Email          : ',
                                        fontSize: 20,
                                      ),
                                      Text(
                                        state.user.email!,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),

                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: 'Shop Name   :  ',
                                        fontSize: 20,
                                      ),
                                      CustomText(
                                        text: state.user.shopName!,
                                        fontSize: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: 'Shop No.       :  ',
                                        fontSize: 20,
                                      ),
                                      CustomText(
                                        text: state.user.phoneNumber!,
                                        fontSize: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomBotton(
                            icon: Icons.add_circle_outline,
                            text: 'Add record',
                            onPressed: () {
                              navigateTo(context, page: const MainReport());
                            })
                      ],
                    );
                  } else if (state is GetUserFailureState) {
                    return Center(child: Text(state.message),);
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
