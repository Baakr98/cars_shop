import 'package:cars_shop/core/helper_methods.dart';
import 'package:cars_shop/shopScreens/shopAuth/login/view.dart';
import 'package:cars_shop/shopScreens/shopAuth/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import '../../../core/constance.dart';
import '../../../widgets/customBotton.dart';
import '../../../widgets/customText.dart';
import '../../../widgets/customfield.dart';


class ShopSignUpScreen extends StatelessWidget {
  // const ShopSignUpScreen({super.key});
  final bloc = KiwiContainer().resolve<SignupBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: bloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset('assets/images/logo.png'),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'Shop Details To Start',
                  fontSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    CutomField(
                      controller: bloc.name,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'error';
                        }
                        return null;
                      },
                      hint: 'Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CutomField(
                      controller: bloc.shopName,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'error';
                        }
                        return null;
                      },
                      hint: 'Shop Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CutomField(
                      controller: bloc.email,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'error';
                        }
                        return null;
                      },
                      hint: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CutomField(
                      controller: bloc.password,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'error';
                        }
                        return null;
                      },
                      hint: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CutomField(
                      controller: bloc.phoneNumber,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'error';
                        }
                        return null;
                      },
                      hint: 'Phone Number',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocListener(
                      bloc: bloc,
                      listener: (context, state) {
                        if(state is SignupNowSuccessState){
                          navigateTo(context, page: ShopLogIn());
                        }else if(state is SignupNowFailureState){
                          toast(msg: state.message);
                        }
                      },
                      child: CustomBotton(
                          text: 'Sign up',
                          onPressed: () async {
                            if (bloc.formKey.currentState!.validate()) {
                              bloc.add(SignUpNowEvent(name: bloc.name.text,
                                  email: bloc.email.text,
                                  password: bloc.password.text,
                                  phone: bloc.phoneNumber.text,
                                  shopName: bloc.shopName.text));
                            }

                            // Get.off(ShopLogIn());
                          }),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "You have an acount?",
                          fontSize: 16,
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, page: ShopLogIn());
                            },
                            child: CustomText(
                              text: 'Login',
                              fontSize: 18,
                              color: secondaryColor,
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
