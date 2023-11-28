part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class GetUserLoadingState extends ProfileState {}
class GetUserSuccessState extends ProfileState {
  final UserModel user;
  GetUserSuccessState({required this.user});
}
class GetUserFailureState extends ProfileState {
  final String message;
  GetUserFailureState({required this.message});
}
class LogOutLoadingState extends ProfileState {}
class LogOutSuccessState extends ProfileState {}
class LogOutFailureState extends ProfileState {
  final String message;
  LogOutFailureState({required this.message});
}
