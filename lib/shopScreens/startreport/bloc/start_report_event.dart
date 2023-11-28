part of 'start_report_bloc.dart';

@immutable
abstract class StartReportEvent {}
class StartNewReportEvent extends StartReportEvent{
  final String userId,pic,dateOfBill;
  StartNewReportEvent({required this.userId, required this.pic, required this.dateOfBill});
}
class GetUsersEvent extends StartReportEvent{}
class UploadImageEvent extends StartReportEvent{
  final File imageFile;
  final String  imageName;
  UploadImageEvent({required this.imageFile, required this.imageName});
}
