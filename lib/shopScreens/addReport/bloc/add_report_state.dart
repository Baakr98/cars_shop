part of 'add_report_bloc.dart';

@immutable
abstract class AddReportState {}

class AddReportInitial extends AddReportState {}
class AddPartLoadingState extends AddReportState {}
class AddPartSuccessState extends AddReportState {}
class AddPartFailureState extends AddReportState {
  final String message;
  AddPartFailureState({required this.message});
}
class DeleteBillLoadingState extends AddReportState {}
class DeleteBillSuccessState extends AddReportState {}
class DeleteBillFailureState extends AddReportState {
  final String message;
  DeleteBillFailureState({required this.message});
}
