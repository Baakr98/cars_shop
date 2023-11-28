part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
class LoginNowEvent extends LoginEvent{
  final String email,password;
  LoginNowEvent({required this.email, required this.password});
}
