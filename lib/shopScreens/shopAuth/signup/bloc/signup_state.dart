part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SignupNowLoadingState extends SignupState {}
class SignupNowSuccessState extends SignupState {}
class SignupNowFailureState extends SignupState {
  final String message;
  SignupNowFailureState({required this.message});
}
