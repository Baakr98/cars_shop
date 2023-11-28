import 'package:cars_shop/core/helper_methods.dart';
import 'package:cars_shop/shopScreens/shopAuth/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import '../../../core/constance.dart';
import '../../../widgets/customBotton.dart';
import '../../../widgets/customText.dart';
import '../../../widgets/customfield.dart';
import '../../../mainNav.dart';
import '../signup/view.dart';

class ShopLogIn extends StatelessWidget {
  // const ShopLogIn({super.key});
  final bloc = KiwiContainer().resolve<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: bloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  text: 'Shop Log In',
                  fontSize: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    CutomField(
                      controller: bloc.email,
                      validator: (value) {
                        if (value == null || value == '') {
                          print("Error");
                          return "error";
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
                          print("Error");
                          return "error";
                        }
                        return null;
                      },
                      hint: 'Password',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocListener(
                      bloc: bloc,
                      listener: (context, state) {
                        if(state is LoginNowSuccessState){
                          navigateTo(context, page: const MainNav());
                        }else if(state is LoginNowFailureState){
                          toast(msg:state.message);
                        }
                      },
                      child: CustomBotton(
                          text: 'Log in',
                          onPressed: () {
                            if (bloc.formKey.currentState!.validate()) {
                              bloc.add(LoginNowEvent(email: bloc.email.text, password: bloc.password.text));
                            }
                            // Get.to(MainScreen());
                          }),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "You don't have an acount?",
                          fontSize: 16,
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, page: ShopSignUpScreen());
                            },
                            child: CustomText(
                              text: 'Signup',
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
