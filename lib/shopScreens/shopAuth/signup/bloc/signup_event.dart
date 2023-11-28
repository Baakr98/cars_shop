part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}
class SignUpNowEvent extends SignupEvent{
  final String name,email,password,phone,shopName;
  SignUpNowEvent({required this.name, required this.email, required this.password, required this.phone, required this.shopName});
}
