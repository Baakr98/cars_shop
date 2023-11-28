part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginNowLoadingState extends LoginState {}
class LoginNowSuccessState extends LoginState {}
class LoginNowFailureState extends LoginState {
  final String message;
  LoginNowFailureState({required this.message});
}
