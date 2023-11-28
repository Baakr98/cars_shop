part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class GetUserEvent extends  ProfileEvent{
  final String userId;
  GetUserEvent({required this.userId});
}
class LogOutEvent extends ProfileEvent{}
