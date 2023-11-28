part of 'reports_bloc.dart';

@immutable
abstract class ReportsState {}

class ReportsInitial extends ReportsState {}
class GetReportsLoadingState extends ReportsState {}
class GetReportsSuccessState extends ReportsState {
  final List<Bill> bills;
  GetReportsSuccessState({required this.bills});
}
class GetReportsFailureState extends ReportsState {
  final String message;
  GetReportsFailureState({required this.message});
}
