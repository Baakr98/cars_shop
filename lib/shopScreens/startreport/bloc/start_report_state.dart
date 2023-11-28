part of 'start_report_bloc.dart';

@immutable
abstract class StartReportState {}

class StartReportInitial extends StartReportState {}
class StartNewReportLoadingState extends StartReportState {}
class StartNewReportSuccessState extends StartReportState {
  final String billId;
  StartNewReportSuccessState({required this.billId});
}
class StartNewReportFailureState extends StartReportState {
  final String message;
  StartNewReportFailureState({required this.message});
}
class GetUsersLoadingState extends StartReportState {}
class GetUsersSuccessState extends StartReportState {
  final List<UserModel> users;
  GetUsersSuccessState({required this.users});
}
class GetUsersFailureState extends StartReportState {
  final String message;
  GetUsersFailureState({required this.message});
}
class UploadImageLoadingState extends StartReportState {}
class UploadImageSuccessState extends StartReportState {
  final String imagePath;
  UploadImageSuccessState({required this.imagePath});
}
class UploadImageFailureState extends StartReportState {
  final String message;
  UploadImageFailureState({required this.message});
}
